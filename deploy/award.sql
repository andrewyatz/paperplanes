-- Deploy paperplanes:award to sqlite
-- requires: agency

BEGIN;

CREATE TABLE award (
  award_id  INTEGER   PRIMARY KEY,
  name      TEXT      NOT NULL UNIQUE,
  finish    TEXT      NOT NULL,
  end       TEXT      NOT NULL,
  agency_id INTEGER   NOT NULL,
  FOREIGN KEY(agency_id) REFERENCES agency(agency_id)
);

COMMIT;
