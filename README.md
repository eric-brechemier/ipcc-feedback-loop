ipcc-feedback-loop
==================

GOAL: to export IPCC authors data from MySQL database
back to CSV to perform QA checks in ipcc-facts-checking

## Rationale

Differences in the structure of the source for authors data
in IPCC assessment reports and the structure of the database
where the data is stored make it hard to perform analyses for
Quality Assurance.

This project fills this gap by formatting data from the database
in chunks matching the contents and organization of the source
documents: for each chapter, authors are sorted first by role,
then by last name and first name, and authors are listed with
full names and countries. On the other hand, only the lists of
authors in annexes mention the institutions.

## Usage

Run `export.sh`, providing the optional `user`, `host` and `password`
to connect to the MySQL database (by default as root@localhost without
password).

The CSV data is exported as separate files for each chapter and annex,
to the `ipcc-facts-checking` folder of the git submodule within this
repository.

The exported data can then be committed in the `ipcc-facts-checking`
submodule and pushed to the remote repository on GitHub.

## Implementation

The selection and formatting of data is performed in SQL, with a
distinct query for each exported dataset. Common parts are extracted
to separate files including queries with variables, which are then
shared by multiple scripts, each setting different values to the
variables to customize the common behavior before triggering its
execution with the `source` instruction.

The output of each SQL script is filtered by the shell script
`tsv2csv.sh` to convert it from TSV to CSV before saving the file
to the same folder as the reference PDF documents for the QA checks
within `ipcc-facts-checking` subdirectory.

## Attribution

[MEDEA Project][MEDEA]
[CC-BY][] [Arts Déco][Arts Deco] & [Sciences Po][Medialab]

[MEDEA]: http://www.projetmedea.fr/
[CC-BY]: https://creativecommons.org/licenses/by/4.0/
         "Creative Commons Attribution 4.0 International"
[Arts Deco]: http://www.ensad.fr/en
             "École Nationale Supérieure des Arts Décoratifs"
[Medialab]: http://www.medialab.sciences-po.fr/
               "Sciences Po Médialab"
