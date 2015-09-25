-- Deploy paperplanes:team to sqlite

BEGIN;

CREATE TABLE team (
  team_id INTEGER   PRIMARY KEY,
  name    TEXT      NOT NULL UNIQUE
);

COMMIT;
