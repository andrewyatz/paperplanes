-- Revert paperplanes:project from sqlite

BEGIN;

drop table project;

COMMIT;
