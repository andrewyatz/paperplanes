-- Revert paperplanes:agency from sqlite

BEGIN;

drop table agency;

COMMIT;
