-- Deploy paperplanes:agency to sqlite

BEGIN;

CREATE TABLE agency (
  agency_id INTEGER   PRIMARY KEY,
  name      TEXT      NOT NULL
);

COMMIT;
