-- Verify paperplanes:team on sqlite

BEGIN;

select team_id, name from team where 0;

ROLLBACK;
