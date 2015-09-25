-- Deploy paperplanes:person to sqlite
-- requires: team
-- requires: project

BEGIN;

CREATE TABLE person (
  person_id       INTEGER   PRIMARY KEY,
  last_name       TEXT      NOT NULL,
  first_name      TEXT      NOT NULL,
  orcid           TEXT      NOT NULL,
  default_team    INTEGER   NOT NULL,
  default_project INTEGER   NOT NULL,
  FOREIGN KEY(default_team) REFERENCES team(team_id),
  FOREIGN KEY(default_project) REFERENCES project(project_id)
);


COMMIT;
