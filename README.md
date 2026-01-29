# Sistem-de-gestiune-a-unei-arhive-muzicale

Implementarea unui model relațional complet pentru gestionarea unui ecosistem muzical integrat. [cite_start]Arhitectura centralizează relațiile dintre producători (case de discuri), interpreți (trupe) și consumatori, permițând administrarea metadatelor pentru albume și piese, precum și gestionarea playlist-urilor utilizatorilor.

* **RDBMS:** Oracle Database
* **Management:** Oracle SQL Developer
* **Backend:** PHP (via extensia **OCI8** pe XAMPP)
* **Frontend:** JavaScript, HTML, CSS

* ## Structură & Modelare

**Tabele Principale:**
* [cite_start]`Utilizator` 
* [cite_start]`Lista_piese` 
* [cite_start]`Piesa` 
* [cite_start]`Album` 
* [cite_start]`Casa_de_discuri` 
* [cite_start]`Trupa` 
* [cite_start]`Locatie` 

## Setup

1.  [cite_start]Configurare mediu: Oracle Database + XAMPP (enable `extension=oci8_12c`).
2.  Import schemă: Rulare scripturi DDL pentru structura tabelelor și constrângeri.
3.  Seed: Populare DB cu dataset-ul inițial.
