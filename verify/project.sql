-- Verify paperplanes:project on sqlite

BEGIN;

select project_id, name from project where 0;

ROLLBACK;
