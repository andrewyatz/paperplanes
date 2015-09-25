-- Revert paperplanes:team from sqlite

BEGIN;

drop table team;

COMMIT;
