# PaperPlanes

## Creating a DBIx::Class Schema

Guide assumes you have locally installed SQLite databases.

```
rm *.db
sqitch deploy db:sqlite:paperplanes.db --verify
perl -MDBIx::Class::Schema::Loader=make_schema_at,dump_to_dir:./lib -e 'make_schema_at("PaperPlanes::Schema", { debug => 1 }, [ "dbi:SQLite:paperplanes.db"])'
```
