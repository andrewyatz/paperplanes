-- Revert paperplanes:activeperson from sqlite

BEGIN TRANSACTION;

CREATE TEMPORARY TABLE person_backup (
  person_id       INTEGER   PRIMARY KEY,
  last_name       TEXT      NOT NULL,
  first_name      TEXT      NOT NULL,
  orcid           TEXT      NOT NULL,
  default_team    INTEGER   NOT NULL,
  default_project INTEGER   NOT NULL,
  FOREIGN KEY(default_team) REFERENCES team(team_id),
  FOREIGN KEY(default_project) REFERENCES project(project_id)
);

INSERT INTO person_backup select person_id, last_name, first_name, orcid, default_team, default_project from person;

DROP TABLE person;

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

INSERT INTO person select person_id, last_name, first_name, orcid, default_team, default_project from person_backup;

DROP TABLE person_backup;

COMMIT;
