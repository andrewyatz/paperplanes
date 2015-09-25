-- Verify paperplanes:person on sqlite

BEGIN;

select person_id, last_name, first_name, orcid, default_team, default_project from person where 0;

ROLLBACK;
