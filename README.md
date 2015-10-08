# PaperPlanes

## Creating a DBIx::Class Schema

Guide assumes you have locally installed SQLite databases.

```
rm *.db
sqitch deploy db:sqlite:paperplanes.db --verify
dbicdump -o dump_directory='./lib' -o debug=1 -o components='["InflateColumn::DateTime"]' PaperPlanes::Schema "dbi:SQLite:paperplanes.db"
```
