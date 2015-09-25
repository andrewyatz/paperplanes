-- Revert paperplanes:award from sqlite

BEGIN;

drop table award;

COMMIT;
