# Sistem de Gestiune a unei Arhive Muzicale

## Despre Proiect

Aplicația oferă o interfață grafică interactivă (frontend) conectată la un sistem de gestiune a bazelor de date relaționale (Oracle). Utilizatorul poate naviga cu ușurință prin tabelele bazei de date, poate sorta datele și poate executa diverse interogări complexe SQL specifice cerințelor de proiect, direct din browser.

### Stiva Tehnică (Tech Stack)
- **Bază de date:** Oracle SQL
- **Backend / Frontend:** PHP (extensia `oci8` pentru conectare), HTML5, CSS3 pur (fără framework-uri externe)

## Funcționalități Principale
- **Interfață UI prietenoasă:** Design modern și responsiv creat în CSS pentru o navigare ușoară.
- **Vizualizare Dinamică:** Paginare automată, selectarea tabelelor direct din meniu și sortare interactivă (crescător/descrescător) dând click pe numele coloanelor.
- **Execuție Cerințe:** Sistem modular pentru rularea cerințelor SQL, afișând simultan rezultatele sub formă de tabel și codul SQL rulat în spate.
- **Securitate și Validare:** Gestionarea erorilor Oracle (`oci_error`) direct în interfață pentru un feedback rapid asupra operațiunilor de tip CRUD.

## Structura Repository-ului
- `script_arhiva_muzicala.sql`: Scriptul SQL complet care conține crearea tabelelor (DDL), constrângerile de integritate și popularea cu date inițiale (DML).
- `index.php`: Aplicația web propriu-zisă care realizează conexiunea la baza de date Oracle și randează elementele vizuale.
- `Documentatie_Arhiva_muzicala_Balan_Mihai.pdf`: Documentația tehnică detaliată a bazei de date (structură, logică de business, scenarii).
- `Interfata_Arhiva_muzicala_Balan_Mihai.pdf`: Prezentarea vizuală a interfeței web dezvoltate.
- `Diagrame/`: Folder ce conține diagramele arhitecturale ale bazei de date (Diagrama Entitate-Relație, Scheme Conceptuale).
