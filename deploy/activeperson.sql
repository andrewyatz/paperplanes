-- Deploy paperplanes:activeperson to sqlite
-- requires: person

BEGIN;

ALTER TABLE person ADD COLUMN active_member TINYINT(1) DEFAULT 1;

COMMIT;
