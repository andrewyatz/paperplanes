-- Deploy paperplanes:project to sqlite

BEGIN;

CREATE TABLE project (
  project_id INTEGER   PRIMARY KEY,
  name       TEXT      NOT NULL UNIQUE
);

COMMIT;
