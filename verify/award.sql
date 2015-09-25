-- Verify paperplanes:award on sqlite

BEGIN;

select award_id, name, start, end, agency_id from award where 0;

ROLLBACK;
