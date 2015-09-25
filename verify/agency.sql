-- Verify paperplanes:agency on sqlite

BEGIN;

select agency_id, name from agency where 0;

ROLLBACK;
