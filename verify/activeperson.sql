-- Verify paperplanes:activeperson on sqlite

BEGIN;

select active_member from person where 0;

ROLLBACK;
