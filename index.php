<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

$conn = oci_connect("C##mihai", "ciscosecpa55", "localhost");
if (!$conn) {
    $error = oci_error();
    die("Failed to connect to Oracle: " . $error['message']);
}

$cerinta = $_GET['cerinta'] ?? '1';
$selected_table = $_GET['table'] ?? '';
$sort_column = $_GET['sort_column'] ?? '';
$sort_direction = $_GET['sort_direction'] ?? 'ASC';
$page = $_GET['page'] ?? 1;
?>
<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <title>Proiect Baze de Date - Interfață Cerințe</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <div class="container">
        <header>
            <h1> Proiect BD -> Sistem de gestiune a unei arhive muzicale</h1>
            <p>-- Interfață --</p>
        </header>

        <nav class="menu-cerinte">
            <a href="?cerinta=1" class="btn-cerinta <?= $cerinta == '1' ? 'active' : '' ?>">
                a) Listare conținut + sortare
            </a>
            <a href="?cerinta=2" class="btn-cerinta <?= $cerinta == '2' ? 'active' : '' ?>">
                b) Editare/Ștergere
            </a>
            <a href="?cerinta=3" class="btn-cerinta <?= $cerinta == '3' ? 'active' : '' ?>">
                c) Interogare 3 tabele 2 condiții
            </a>
            <a href="?cerinta=4" class="btn-cerinta <?= $cerinta == '4' ? 'active' : '' ?>">
                d) Funcții grup + having
            </a>
            <a href="?cerinta=5" class="btn-cerinta <?= $cerinta == '5' ? 'active' : '' ?>">
                e) Constrângere "on delete cascade"
            </a>
            <a href="?cerinta=6" class="btn-cerinta <?= $cerinta == '6' ? 'active' : '' ?>">
                f) Vizualizări
            </a>
        </nav>

        <div class="content">
            <?php
            switch ($cerinta) {
                case '1':
                    echo '<h2 class="cerinta-title">a) Listare conținut cu posibilitatea de sortare (toate tabelele)</h2>';
                    includeContent($conn);
                    break;

                case '2':
                    echo '<h2 class="cerinta-title">b) Modificare informații (editare/ștergere înregistrări)</h2>';
                    includeEditDelete($conn);
                    break;

                case '3':
                    echo '<h2 class="cerinta-title">c) Interogare din 3 tabele cu 2 condiții</h2>';
                    includeThreeTableQuery($conn);
                    break;

                case '4':
                    echo '<h2 class="cerinta-title">d) Funcții grup și clauza HAVING</h2>';
                    includeGroupFunctions($conn);
                    break;

                case '5':
                    echo '<h2 class="cerinta-title">e) ON DELETE CASCADE și exemplificare</h2>';
                    includeOnDeleteCascade($conn);
                    break;

                case '6':
                    echo '<h2 class="cerinta-title">f) Vizualizări (compusă și complexă)</h2>';
                    includeViews($conn);
                    break;

                default:
                    echo '<h2 class="cerinta-title">a) Listare conținut cu posibilitatea de sortare (toate tabelele)</h2>';
                    includeContent($conn);
                    break;
            }
            ?>
        </div>
    </div>

    <script src="script.js"></script>
</body>

</html>
<?php oci_close($conn); ?>

<?php

function includeContent($conn)
{
    global $selected_table, $sort_column, $sort_direction, $page;

    $query_tables = "select table_name from user_tables order by table_name";
    $stmt_tables = oci_parse($conn, $query_tables);
    oci_execute($stmt_tables);

    $tables = [];
    while ($row = oci_fetch_assoc($stmt_tables)) {
        $tables[] = $row['TABLE_NAME'];
    }

    if (!$selected_table && !empty($tables)) {
        $selected_table = $tables[0];
    }

    $rows_per_page = 10;
    $offset = ($page - 1) * $rows_per_page;

    if (!empty($tables)): ?>
        <div class="table-selector">
            <label for="table-select"> Selectați tabelul:</label>
            <select id="table-select" onchange="changeTable(this.value)">
                <?php foreach ($tables as $table): ?>
                    <option value="<?= htmlspecialchars($table) ?>" <?= $selected_table == $table ? 'selected' : '' ?>>
                        <?= htmlspecialchars($table) ?>
                    </option>
                <?php endforeach; ?>
            </select>
        </div>

        <?php if ($selected_table):
            $query_columns = "select column_name 
                             from user_tab_columns 
                             where table_name = upper('" . strtoupper($selected_table) . "') 
                             order by column_id";
            $stmt_cols = oci_parse($conn, $query_columns);
            oci_execute($stmt_cols);

            $columns = [];
            while ($col = oci_fetch_assoc($stmt_cols)) {
                $columns[] = $col['COLUMN_NAME'];
            }

            if (!empty($columns)):
                $valid_sort_column = $sort_column;
                if (!in_array(strtoupper($sort_column), array_map('strtoupper', $columns))) {
                    $valid_sort_column = $columns[0];
                }
                ?>
                <div class="sort-controls">
                    <div class="sort-group">
                        <label for="sort-column-select"> Sortare după coloană:</label>
                        <select id="sort-column-select">
                            <?php foreach ($columns as $col): ?>
                                <option value="<?= htmlspecialchars($col) ?>" <?= (strtoupper($valid_sort_column) == strtoupper($col)) ? 'selected' : '' ?>>
                                    <?= htmlspecialchars($col) ?>
                                </option>
                            <?php endforeach; ?>
                        </select>
                    </div>

                    <div class="sort-group">
                        <label for="sort-direction-select"> Direcție:</label>
                        <select id="sort-direction-select">
                            <option value="ASC" <?= $sort_direction == 'ASC' ? 'selected' : '' ?>> Crescător (ASC)</option>
                            <option value="DESC" <?= $sort_direction == 'DESC' ? 'selected' : '' ?>> Descrescător (DESC)</option>
                        </select>
                    </div>

                    <button class="btn-apply-sort" onclick="applySorting()">
                         Aplică Sortarea
                    </button>
                </div>

                <?php

                $count_query = 'select count(*) as total from "' . $selected_table . '"';
                $stmt_count = oci_parse($conn, $count_query);
                oci_execute($stmt_count);
                $count_row = oci_fetch_assoc($stmt_count);
                $total_rows = $count_row['TOTAL'];
                $total_pages = ceil($total_rows / $rows_per_page);

                $col_list = implode(", ", array_map(function ($col) {
                    return '"' . $col . '"';
                }, $columns));

                $order_clause = '';
                if ($valid_sort_column) {
                    $order_clause = ' order by "' . $valid_sort_column . '" ' . $sort_direction;
                }

                $main_query = 'select * from (
                                select a.*, rownum as rnum from (
                                    select ' . $col_list . ' from "' . $selected_table . '"' . $order_clause . '
                                ) a where rownum <= :max_row
                              ) where rnum > :min_row';

                $stmt_data = oci_parse($conn, $main_query);
                $max_row = $offset + $rows_per_page;
                $min_row = $offset;
                oci_bind_by_name($stmt_data, ":max_row", $max_row);
                oci_bind_by_name($stmt_data, ":min_row", $min_row);
                oci_execute($stmt_data);

                $data = [];
                while ($row = oci_fetch_assoc($stmt_data)) {
                    $data[] = $row;
                }
                ?>

                <div class="stats">
                    <div>
                        <strong> Tabel:</strong>
                        <?= htmlspecialchars($selected_table) ?>
                        | <strong>Rânduri totale:</strong>
                        <?= $total_rows ?>
                        | <strong>Pagina:</strong>
                        <?= $page ?> din
                        <?= $total_pages ?>
                    </div>
                    <div>
                        <strong>Sortare activă:</strong>
                        <span class="current-sort-indicator">
                            <?= htmlspecialchars($valid_sort_column) ?>
                            (
                            <?= $sort_direction == 'ASC' ? '↑' : '↓' ?>
                            <?= $sort_direction ?>)
                        </span>
                    </div>
                </div>

                <?php if (!empty($data)): ?>
                    <div style="overflow-x: auto;">
                        <table>
                            <thead>
                                <tr>
                                    <?php foreach ($columns as $col): ?>
                                        <th>
                                            <?= htmlspecialchars($col) ?>
                                            <?php if (strtoupper($valid_sort_column) == strtoupper($col)): ?>
                                                <span style="color: #667eea; font-size: 1.2em;">
                                                    <?= $sort_direction == 'ASC' ? '▲' : '▼' ?>
                                                </span>
                                            <?php endif; ?>
                                        </th>
                                    <?php endforeach; ?>
                                </tr>
                            </thead>
                            <tbody>
                                <?php foreach ($data as $row): ?>
                                    <tr>
                                        <?php foreach ($columns as $col): ?>
                                            <?php
                                            $value = $row[strtoupper($col)] ?? $row[$col] ?? null;
                                            
                                            $isImageColumn = (stripos($col, 'LOGO') !== false || 
                                                            stripos($col, 'URL_IMAGINE') !== false || 
                                                            stripos($col, 'IMAGINE') !== false);
                                            
                                            if ($isImageColumn && !empty($value) && $value !== 'NULL') {
                                                echo '<td><img src="' . htmlspecialchars($value) . '" '
                                                    . 'alt="Logo" class="table-img" '
                                                    . 'referrerpolicy="no-referrer" '
                                                    . 'onerror="this.style.display=\'none\'; this.nextElementSibling.style.display=\'block\';"> '
                                                    . '<span style="display:none; color: #999; font-size: 0.85em;"> Imagine indisponibilă</span>'
                                                    . '</td>';
                                            } else {
                                                echo '<td>' . htmlspecialchars($value ?? '') . '</td>';
                                            }
                                            ?>
                                        <?php endforeach; ?>
                                    </tr>
                                <?php endforeach; ?>
                            </tbody>
                        </table>
                    </div>

                    <?php if ($total_pages > 1): ?>
                        <div class="pagination">
                            <?php if ($page > 1): ?>
                                <button class="btn-pagination" onclick="goToPage(1)">« Prima</button>
                                <button class="btn-pagination" onclick="goToPage(<?= $page - 1 ?>)">‹ Anterioara</button>
                            <?php endif; ?>

                            <?php
                            $start_page = max(1, $page - 2);
                            $end_page = min($total_pages, $page + 2);

                            for ($i = $start_page; $i <= $end_page; $i++):
                                ?>
                                <button class="btn-pagination <?= $i == $page ? 'active' : '' ?>" onclick="goToPage(<?= $i ?>)">
                                    <?= $i ?>
                                </button>
                            <?php endfor; ?>

                            <?php if ($page < $total_pages): ?>
                                <button class="btn-pagination" onclick="goToPage(<?= $page + 1 ?>)">Următoarea ›</button>
                                <button class="btn-pagination" onclick="goToPage(<?= $total_pages ?>)">Ultima »</button>
                            <?php endif; ?>
                        </div>
                    <?php endif; ?>

                <?php else: ?>
                    <div class="error">
                        Nu există date în acest tabel.
                    </div>
                <?php endif; ?>

            <?php else: ?>
                <div class="error">
                    Nu s-au putut obține coloanele pentru tabelul selectat:
                    <?= htmlspecialchars($selected_table) ?>
                </div>
            <?php endif; ?>

        <?php else: ?>
            <div class="error">
                Vă rugăm să selectați un tabel.
            </div>
        <?php endif; ?>

    <?php else: ?>
        <div class="error">
            Nu s-au găsit tabele în baza de date.
        </div>
    <?php endif;
}

function includeEditDelete($conn)
{
    $terminal_output = ""; 

    if (isset($_POST['edit_submit'])) {
        $table = strtoupper($_POST['edit_table']);
        $id = $_POST['edit_id'];
        $field = strtoupper($_POST['edit_field']);
        $value = $_POST['edit_value'];

        $pk_map = [
            'UTILIZATOR' => 'ID_UTILIZATOR',
            'PIESA' => 'ID_PIESA',
            'ALBUM' => 'ID_ALBUM',
            'TRUPA' => 'ID_TRUPA',
            'LOCATIE' => 'ID_LOCATIE',
            'CASA_DE_DISCURI' => 'ID_CASA_DE_DISCURI'
        ];
        $pk_field = $pk_map[$table] ?? ('ID_' . $table);

        $query = "update $table set $field = :value where $pk_field = :id";
        $stmt = oci_parse($conn, $query);
        oci_bind_by_name($stmt, ":value", $value);
        oci_bind_by_name($stmt, ":id", $id);

        $simulated_sql = "UPDATE $table SET $field = '$value' WHERE $pk_field = $id;";

        if (oci_execute($stmt, OCI_COMMIT_ON_SUCCESS)) {
            $rows_affected = oci_num_rows($stmt);
            $terminal_output .= "<div style='margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #555;'>";
            $terminal_output .= "<span style='color: #888;'>oracle@admin:~$</span> <span style='color: #e6db74;'>$simulated_sql</span><br>";
            $terminal_output .= "<span style='color: #a6e22e; font-weight: bold;'>➜ SUCCES: Înregistrare actualizată. ($rows_affected rânduri modificate)</span>";
            $terminal_output .= "</div>";
        } else {
            $error = oci_error($stmt);
            $terminal_output .= "<div style='margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #555;'>";
            $terminal_output .= "<span style='color: #888;'>oracle@admin:~$</span> <span style='color: #e6db74;'>$simulated_sql</span><br>";
            $terminal_output .= "<span style='color: #f92672; font-weight: bold;'>➜ EROARE: " . htmlspecialchars($error['message']) . "</span>";
            $terminal_output .= "</div>";
        }
    }

    if (isset($_POST['delete_submit'])) {
        $table = strtoupper($_POST['delete_table']);
        $id = $_POST['delete_id'];

        $pk_map = [
            'UTILIZATOR' => 'ID_UTILIZATOR',
            'PIESA' => 'ID_PIESA',
            'ALBUM' => 'ID_ALBUM',
            'TRUPA' => 'ID_TRUPA',
            'LOCATIE' => 'ID_LOCATIE',
            'CASA_DE_DISCURI' => 'ID_CASA_DE_DISCURI'
        ];
        $pk_field = $pk_map[$table] ?? ('ID_' . $table);

        $query = "delete from $table where $pk_field = :id";
        $stmt = oci_parse($conn, $query);
        oci_bind_by_name($stmt, ":id", $id);

        $simulated_sql = "DELETE FROM $table WHERE $pk_field = $id;";

        if (oci_execute($stmt, OCI_COMMIT_ON_SUCCESS)) {
            $rows_affected = oci_num_rows($stmt);
            $terminal_output .= "<div style='margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #555;'>";
            $terminal_output .= "<span style='color: #888;'>oracle@admin:~$</span> <span style='color: #e6db74;'>$simulated_sql</span><br>";
            $terminal_output .= "<span style='color: #a6e22e; font-weight: bold;'>➜ SUCCES: Înregistrare ștearsă. ($rows_affected rânduri modificate)</span>";
            $terminal_output .= "</div>";
        } else {
            $error = oci_error($stmt);
            $terminal_output .= "<div style='margin-bottom: 15px; padding-bottom: 10px; border-bottom: 1px dashed #555;'>";
            $terminal_output .= "<span style='color: #888;'>oracle@admin:~$</span> <span style='color: #e6db74;'>$simulated_sql</span><br>";
            $terminal_output .= "<span style='color: #f92672; font-weight: bold;'>➜ EROARE: " . htmlspecialchars($error['message']) . "</span>";
            $terminal_output .= "</div>";
        }
    }

    echo '<div class="sql-code">';
    
    if (!empty($terminal_output)) {
        echo $terminal_output;
    }

    echo '<div style="opacity: 0.7;">';
    echo '<strong>SQL examples:</strong><br>';
    echo 'update piesa set titlu_piesa = \'Valoare Noua\' where id_piesa = [id];<br>';
    echo 'update utilizator set nume_utilizator = \'Popescu\' where id_utilizator = [id];<br>';
    echo '<br>'; 
    echo 'delete from piesa where id_piesa = [id_piesa];<br>';
    echo 'delete from utilizator where id_utilizator = [id_utilizator];';
    echo '</div>';
    
    echo '</div>';

    echo '<div class="action-buttons">
        <button class="btn-action" onclick="document.getElementById(\'edit-form\').style.display=\'block\'"> Editare Înregistrare</button>
        <button class="btn-action btn-danger" onclick="document.getElementById(\'delete-form\').style.display=\'block\'"> Ștergere Înregistrare</button>
    </div>';

    echo '<div id="edit-form" style="display:none; background:#f9f9f9; padding:20px; border-radius:5px; margin:20px 0; border: 2px solid #667eea;">
        <h3>️ Editare Înregistrare</h3>
        <form method="post">
            <div class="form-group">
                <label>Tabel:</label>
                <select name="edit_table" class="form-control">
                    <option value="utilizator">UTILIZATOR</option>
                    <option value="piesa">PIESA</option>
                    <option value="album">ALBUM</option>
                    <option value="trupa">TRUPA</option>
                    <option value="locatie">LOCATIE</option>
                    <option value="casa_de_discuri">CASA_DE_DISCURI</option>
                </select>
            </div>
            <div class="form-group">
                <label>ID înregistrare:</label>
                <input type="number" name="edit_id" class="form-control" required placeholder="Ex: 1">
            </div>
            <div class="form-group">
                <label>Câmp de modificat:</label>
                <input type="text" name="edit_field" class="form-control" required placeholder="Ex: NUME_UTILIZATOR">
            </div>
            <div class="form-group">
                <label>Valoare nouă:</label>
                <input type="text" name="edit_value" class="form-control" required placeholder="Introduceți noua valoare">
            </div>
            <button type="submit" class="btn-action btn-success" name="edit_submit"> Salvează Modificările</button>
            <button type="button" class="btn-action btn-warning" onclick="document.getElementById(\'edit-form\').style.display=\'none\'"> Anulează</button>
        </form>
    </div>';

    echo '<div id="delete-form" style="display:none; background:#fff0f0; padding:20px; border-radius:5px; margin:20px 0; border: 2px solid #dc3545;">
        <h3> Ștergere Înregistrare</h3>
        <form method="post">
            <div class="form-group">
                <label>Tabel:</label>
                <select name="delete_table" class="form-control">
                    <option value="utilizator">UTILIZATOR</option>
                    <option value="piesa">PIESA</option>
                    <option value="album">ALBUM</option>
                    <option value="trupa">TRUPA</option>
                    <option value="locatie">LOCATIE</option>
                    <option value="casa_de_discuri">CASA_DE_DISCURI</option>
                </select>
            </div>
            <div class="form-group">
                <label>ID înregistrare de șters:</label>
                <input type="number" name="delete_id" class="form-control" required placeholder="Ex: 1">
            </div>
            <button type="submit" class="btn-action btn-danger" name="delete_submit" onclick="return confirm(\'Sigur doriți să ștergeți această înregistrare?\')"> Șterge Înregistrarea</button>
            <button type="button" class="btn-action btn-warning" onclick="document.getElementById(\'delete-form\').style.display=\'none\'"> Anulează</button>
        </form>
    </div>';

    echo '<h3 style="margin-top: 30px;"> Exemple de înregistrări (primele 5 din fiecare tabel)</h3>';

    $tables_to_show = ['UTILIZATOR', 'PIESA', 'ALBUM', 'TRUPA'];
    foreach ($tables_to_show as $table) {
        echo "<h4 style='color: #667eea; margin-top: 20px;'>Tabel: $table</h4>";
        $query = "select * from $table where rownum <= 5";
        $stmt = oci_parse($conn, $query);
        oci_execute($stmt);

        echo '<div style="overflow-x: auto;"><table>';
        echo '<tr>';
        for ($i = 1; $i <= oci_num_fields($stmt); $i++) {
            $field = oci_field_name($stmt, $i);
            echo '<th>' . htmlspecialchars($field) . '</th>';
        }
        echo '</tr>';

        while ($row = oci_fetch_assoc($stmt)) {
            echo '<tr>';
            foreach ($row as $key => $value) {
                $isImageColumn = (stripos($key, 'LOGO') !== false || stripos($key, 'URL_IMAGINE') !== false);
                if ($isImageColumn && !empty($value) && $value !== 'NULL') {
                    echo '<td><img src="' . htmlspecialchars($value) . '" class="table-img" onerror="this.style.display=\'none\'"></td>';
                } else {
                    echo '<td>' . htmlspecialchars($value ?? '') . '</td>';
                }
            }
            echo '</tr>';
        }
        echo '</table></div>';
    }
}

function includeThreeTableQuery($conn)
{
    echo '<div class="sql-code">
    <strong>SQL Query:</strong><br>
    select t.nume_trupa, a.titlu_album, p.titlu_piesa, p.durata, p.gen_muzical<br>
    from trupa t<br>
    join album a on t.id_trupa = a.id_trupa<br>
    join piesa p on a.id_album = p.id_album<br>
    where t.status = \'ACTIVA\'<br>
    and p.gen_muzical = \'Rock\'<br>
    and a.an_lansare > 1995<br>
    order by t.nume_trupa, a.titlu_album;
    </div>';

    echo '<button class="btn-action" onclick="window.location.href=\'?cerinta=3&execute=1\'"> Execută Interogarea</button>';

    if (isset($_GET['execute']) && $_GET['execute'] == 1) {
        $query = "select t.nume_trupa, a.titlu_album, p.titlu_piesa, p.durata, p.gen_muzical
                 from trupa t
                 join album a on t.id_trupa = a.id_trupa
                 join piesa p on a.id_album = p.id_album
                 where t.status = 'ACTIVA'
                 and p.gen_muzical = 'Rock'
                 and a.an_lansare > 1995
                 order by t.nume_trupa, a.titlu_album";

        $stmt = oci_parse($conn, $query);
        oci_execute($stmt);

        echo '<div class="query-result">
                <h3> Rezultate Interogare (3 tabele + 3 condiții)</h3>
                <p><strong>Condiții:</strong> Status = \'ACTIVA\' AND Gen = \'Rock\' AND An > 1995</p>';

        echo '<div style="overflow-x: auto;"><table>
                <tr>
                    <th>Trupă</th>
                    <th>Album</th>
                    <th>Piesă</th>
                    <th>Durată</th>
                    <th>Gen</th>
                </tr>';

        $count = 0;
        while ($row = oci_fetch_assoc($stmt)) {
            $count++;
            echo '<tr>
                    <td>' . htmlspecialchars($row['NUME_TRUPA']) . '</td>
                    <td>' . htmlspecialchars($row['TITLU_ALBUM']) . '</td>
                    <td>' . htmlspecialchars($row['TITLU_PIESA']) . '</td>
                    <td>' . htmlspecialchars($row['DURATA']) . '</td>
                    <td>' . htmlspecialchars($row['GEN_MUZICAL']) . '</td>
                  </tr>';
        }

        echo '</table></div>';
        echo '<p style="margin-top: 15px;"><strong>Total înregistrări găsite:</strong> ' . $count . '</p>';
        echo '</div>';
    }
}

function includeGroupFunctions($conn)
{
    echo '<div class="sql-code">
    <strong>SQL Query:</strong><br>
    select t.nume_trupa, count(p.id_piesa) as numar_piese, <br>
    avg(to_number(substr(p.durata, 1, 2)) * 60 + to_number(substr(p.durata, 4, 2))) as durata_medie_sec<br>
    from trupa t<br>
    join album a on t.id_trupa = a.id_trupa<br>
    join piesa p on a.id_album = p.id_album<br>
    group by t.id_trupa, t.nume_trupa<br>
    having count(p.id_piesa) > 5<br>
    order by numar_piese desc;
    </div>';

    echo '<button class="btn-action" onclick="window.location.href=\'?cerinta=4&execute=1\'"> Execută Interogarea</button>';

    if (isset($_GET['execute']) && $_GET['execute'] == 1) {
        $query = "select t.nume_trupa, 
                          count(p.id_piesa) as numar_piese, 
                          round(avg(to_number(substr(p.durata, 1, 2)) * 60 + to_number(substr(p.durata, 4, 2)))) as durata_medie_sec
                  from trupa t
                  join album a on t.id_trupa = a.id_trupa
                  join piesa p on a.id_album = p.id_album
                  group by t.id_trupa, t.nume_trupa
                  having count(p.id_piesa) > 5
                  order by numar_piese desc";

        $stmt = oci_parse($conn, $query);
        oci_execute($stmt);

        echo '<div class="query-result">
                <h3> Rezultate functii grup + having </h3>
                <p><strong>Clauză HAVING:</strong> COUNT(p.id_piesa) > 5</p>';

        echo '<div style="overflow-x: auto;"><table>
                <tr>
                    <th>Trupă</th>
                    <th>Număr Piese</th>
                    <th>Durata Medie (secunde)</th>
                    <th>Durata Medie (mm:ss)</th>
                </tr>';

        $count = 0;
        while ($row = oci_fetch_assoc($stmt)) {
            $count++;
            $avg_seconds = $row['DURATA_MEDIE_SEC'];
            $avg_minutes = floor($avg_seconds / 60);
            $avg_remaining_seconds = $avg_seconds % 60;
            $avg_formatted = sprintf("%02d:%02d", $avg_minutes, $avg_remaining_seconds);

            echo '<tr>
                    <td>' . htmlspecialchars($row['NUME_TRUPA']) . '</td>
                    <td><strong>' . htmlspecialchars($row['NUMAR_PIESE']) . '</strong></td>
                    <td>' . htmlspecialchars($row['DURATA_MEDIE_SEC']) . '</td>
                    <td>' . $avg_formatted . '</td>
                  </tr>';
        }

        echo '</table></div>';
        echo '<p style="margin-top: 15px;"><strong>Total trupe cu peste 5 piese:</strong> ' . $count . '</p>';
        echo '</div>';
    }
}

function includeOnDeleteCascade($conn)
{
    echo '<div class="sql-code">
    <strong>Exemplu de ON DELETE CASCADE din scriptul inițial:</strong><br>
    -- Constraint-ul FK din tabelul ALBUM care referențiază TRUPA<br>
    -- Va șterge automat albumele când o trupă este ștearsă<br>
    constraint album_fk_1 foreign key (id_trupa) references trupa (id_trupa)<br><br>
    
    <strong>Exemplificare practică:</strong><br>
    1. Verificăm câte albume are o trupă<br>
    2. Ștergem trupa<br>
    3. Verificăm dacă albumele s-au șters automat
    </div>';

    echo '<div class="action-buttons">
        <button class="btn-action" onclick="window.location.href=\'?cerinta=5&test=1\'"> Test ON DELETE CASCADE</button>
        <button class="btn-action btn-warning" onclick="window.location.href=\'?cerinta=5\'"> Resetează</button>
    </div>';

    if (isset($_GET['test']) && $_GET['test'] == 1) {
        echo '<div class="query-result">';

        $query1 = "select t.id_trupa, t.nume_trupa, count(a.id_album) as numar_albume
                    from trupa t
                    left join album a on t.id_trupa = a.id_trupa
                    where t.id_trupa = 5
                    group by t.id_trupa, t.nume_trupa";

        $stmt1 = oci_parse($conn, $query1);
        oci_execute($stmt1);
        $trupa_info = oci_fetch_assoc($stmt1);

        echo '<h3>Pas 1: Verificăm trupa și albumele sale</h3>';
        echo '<table>
                <tr><th>Trupa ID</th><th>Nume Trupa</th><th>Număr Albume</th></tr>
                <tr>
                    <td>' . $trupa_info['ID_TRUPA'] . '</td>
                    <td>' . htmlspecialchars($trupa_info['NUME_TRUPA']) . '</td>
                    <td>' . $trupa_info['NUMAR_ALBUME'] . '</td>
                </tr>
              </table>';

        $query2 = "select id_album, titlu_album from album where id_trupa = 5";
        $stmt2 = oci_parse($conn, $query2);
        oci_execute($stmt2);

        echo '<h3>Albumele trupei:</h3>';
        echo '<table><tr><th>ID Album</th><th>Titlu Album</th></tr>';
        $albume = [];
        while ($row = oci_fetch_assoc($stmt2)) {
            $albume[] = $row;
            echo '<tr><td>' . $row['ID_ALBUM'] . '</td><td>' . htmlspecialchars($row['TITLU_ALBUM']) . '</td></tr>';
        }
        echo '</table>';

        echo '<h3>Pas 2: Dacă am șterge trupa (delete from trupa where id_trupa = 5)</h3>';
        echo '<p>Toate albumele asociate (ID: ';
        foreach ($albume as $album) {
            echo $album['ID_ALBUM'] . ' ';
        }
        echo ') ar fi șterse automat datorită ON DELETE CASCADE.</p>';

        echo '<h3>Pas 3: Verificăm toate constraint-urile CASCADE din baza de date</h3>';
        $query3 = "select uc.table_name, uc.constraint_name, uc.delete_rule
                    from user_constraints uc
                    where uc.constraint_type = 'R'
                    and uc.delete_rule = 'CASCADE'
                    order by uc.table_name";

        $stmt3 = oci_parse($conn, $query3);
        oci_execute($stmt3);

        echo '<table>
                <tr><th>Tabel</th><th>Constraint</th><th>Regula Delete</th></tr>';

        while ($row = oci_fetch_assoc($stmt3)) {
            echo '<tr>
                    <td>' . htmlspecialchars($row['TABLE_NAME']) . '</td>
                    <td>' . htmlspecialchars($row['CONSTRAINT_NAME']) . '</td>
                    <td><strong>' . htmlspecialchars($row['DELETE_RULE']) . '</strong></td>
                  </tr>';
        }
        echo '</table>';

        echo '</div>';
    }
}

function includeViews($conn)
{
    echo '<div class="sql-code">
    <strong>SQL pentru vizualizări:</strong><br><br>
    create or replace view info_piese_complete as<br>
    select p.id_piesa, p.titlu_piesa, a.titlu_album, t.nume_trupa, p.gen_muzical<br>
    from piesa p<br>
    join album a on p.id_album = a.id_album<br>
    join trupa t on a.id_trupa = t.id_trupa<br>
    where t.status = \'ACTIVA\';<br><br>
    
    <strong>2. Vizualizare complexă:</strong><br>
    create or replace view statistici_trupe as<br>
    select t.nume_trupa, l.tara, l.oras,<br>
           count(distinct a.id_album) as numar_albume,<br>
           count(p.id_piesa) as numar_piese,<br>
           min(a.an_lansare) as an_primul_album,<br>
           max(a.an_lansare) as an_ultimul_album<br>
    from trupa t<br>
    join locatie l on t.id_locatie = l.id_locatie<br>
    left join album a on t.id_trupa = a.id_trupa<br>
    left join piesa p on a.id_album = p.id_album<br>
    group by t.nume_trupa, l.tara, l.oras<br>
    order by numar_piese desc;
    </div>';

    echo '<div class="action-buttons">
        <button class="btn-action" onclick="window.location.href=\'?cerinta=6&view=compusa\'"> Vezi Vizualizarea Compusă</button>
        <button class="btn-action" onclick="window.location.href=\'?cerinta=6&view=complexa\'"> Vezi Vizualizarea Complexă</button>
        <button class="btn-action btn-warning" onclick="window.location.href=\'?cerinta=6&create=1\'"> Creează Vizualizările</button>
    </div>';

    if (isset($_GET['create']) && $_GET['create'] == 1) {
        $drop1 = "begin execute immediate 'drop view info_piese_complete'; exception when others then null; end;";
        $drop2 = "begin execute immediate 'drop view statistici_trupe'; exception when others then null; end;";

        $stmt1 = oci_parse($conn, $drop1);
        $stmt2 = oci_parse($conn, $drop2);
        oci_execute($stmt1);
        oci_execute($stmt2);

        $view1 = "create view info_piese_complete as
                  select p.id_piesa, p.titlu_piesa, a.titlu_album, t.nume_trupa, p.gen_muzical
                  from piesa p
                  join album a on p.id_album = a.id_album
                  join trupa t on a.id_trupa = t.id_trupa
                  where t.status = 'ACTIVA'";

        $stmt3 = oci_parse($conn, $view1);
        if (oci_execute($stmt3)) {
            echo '<div class="success"> Vizualizarea compusă a fost creată cu succes!</div>';
        } else {
            $error = oci_error($stmt3);
            echo '<div class="error"> Eroare la crearea vizualizării: ' . htmlspecialchars($error['message']) . '</div>';
        }

        $view2 = "create view statistici_trupe as
                  select t.nume_trupa, l.tara, l.oras,
                         count(distinct a.id_album) as numar_albume,
                         count(p.id_piesa) as numar_piese,
                         min(a.an_lansare) as an_primul_album,
                         max(a.an_lansare) as an_ultimul_album
                  from trupa t
                  join locatie l on t.id_locatie = l.id_locatie
                  left join album a on t.id_trupa = a.id_trupa
                  left join piesa p on a.id_album = p.id_album
                  group by t.nume_trupa, l.tara, l.oras
                  order by numar_piese desc";

        $stmt4 = oci_parse($conn, $view2);
        if (oci_execute($stmt4)) {
            echo '<div class="success"> Vizualizarea complexă a fost creată cu succes!</div>';
        } else {
            $error = oci_error($stmt4);
            echo '<div class="error"> Eroare la crearea vizualizării: ' . htmlspecialchars($error['message']) . '</div>';
        }
    }

    if (isset($_GET['view'])) {
        echo '<div class="query-result">';

        if ($_GET['view'] == 'compusa') {
            echo '<h3> Vizualizare Compusă - Info Piese Complete</h3>';

            $query = "select * from info_piese_complete where rownum <= 20";
            $stmt = oci_parse($conn, $query);

            if (oci_execute($stmt)) {
                echo '<div style="overflow-x: auto;"><table>
                        <tr>
                            <th>ID Piesă</th>
                            <th>Titlu Piesă</th>
                            <th>Album</th>
                            <th>Trupă</th>
                            <th>Gen Muzical</th>
                        </tr>';

                while ($row = oci_fetch_assoc($stmt)) {
                    echo '<tr>
                            <td>' . $row['ID_PIESA'] . '</td>
                            <td>' . htmlspecialchars($row['TITLU_PIESA']) . '</td>
                            <td>' . htmlspecialchars($row['TITLU_ALBUM']) . '</td>
                            <td>' . htmlspecialchars($row['NUME_TRUPA']) . '</td>
                            <td>' . htmlspecialchars($row['GEN_MUZICAL']) . '</td>
                          </tr>';
                }
                echo '</table></div>';
            } else {
                echo '<div class="error"> Vizualizarea nu există. Creează vizualizările mai întâi folosind butonul "Creează Vizualizările".</div>';
            }

        } elseif ($_GET['view'] == 'complexa') {
            echo '<h3> Vizualizare Complexă - Statistici Trupe</h3>';

            $query = "select * from statistici_trupe";
            $stmt = oci_parse($conn, $query);

            if (oci_execute($stmt)) {
                echo '<div style="overflow-x: auto;"><table>
                        <tr>
                            <th>Trupă</th>
                            <th>Țară</th>
                            <th>Oraș</th>
                            <th>Nr. Albume</th>
                            <th>Nr. Piese</th>
                            <th>An Primul Album</th>
                            <th>An Ultimul Album</th>
                        </tr>';

                while ($row = oci_fetch_assoc($stmt)) {
                    echo '<tr>
                            <td>' . htmlspecialchars($row['NUME_TRUPA']) . '</td>
                            <td>' . htmlspecialchars($row['TARA']) . '</td>
                            <td>' . htmlspecialchars($row['ORAS']) . '</td>
                            <td>' . $row['NUMAR_ALBUME'] . '</td>
                            <td><strong>' . $row['NUMAR_PIESE'] . '</strong></td>
                            <td>' . $row['AN_PRIMUL_ALBUM'] . '</td>
                            <td>' . $row['AN_ULTIMUL_ALBUM'] . '</td>
                          </tr>';
                }
                echo '</table></div>';
            } else {
                echo '<div class="error"> Vizualizarea nu există. Creează vizualizările mai întâi folosind butonul "Creează Vizualizările".</div>';
            }
        }
        echo '</div>';
    }
}
?>
