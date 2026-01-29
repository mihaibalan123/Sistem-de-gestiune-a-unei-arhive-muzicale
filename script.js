function changeTable(tableName) {
    const url = new URL(window.location.href);
    url.searchParams.set('table', tableName);
    url.searchParams.set('page', 1);
    url.searchParams.delete('sort_column');
    url.searchParams.delete('sort_direction');

    window.location.href = url.toString();
}

function applySorting() {
    const sortColumn = document.getElementById('sort-column-select').value;
    const sortDirection = document.getElementById('sort-direction-select').value;

    const url = new URL(window.location.href);
    url.searchParams.set('sort_column', sortColumn);
    url.searchParams.set('sort_direction', sortDirection);
    url.searchParams.set('page', 1);

    window.location.href = url.toString();
}

function goToPage(page) {
    const url = new URL(window.location.href);
    url.searchParams.set('page', page);
    window.location.href = url.toString();
}

function confirmDelete(tableName, id) {
    if (confirm('Sigur doriți să ștergeți această înregistrare?')) {
        window.location.href = `?cerinta=2&delete=${tableName}&id=${id}`;
    }
}

document.addEventListener('DOMContentLoaded', function () {
    const sortSelects = document.querySelectorAll('.sort-group select');
    sortSelects.forEach(select => {
        select.addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                applySorting();
            }
        });
    });
});
