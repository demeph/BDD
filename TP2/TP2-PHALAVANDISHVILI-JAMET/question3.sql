--JAMET Felix - PHALAVANDISHVILI Demetre - Groupe 601B
SET ECHO OFF
SPOOL effacer.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT 'DELETE FROM ' || table_name || ' CASCADE;' FROM USER_TABLES ;

SPOOL OFF
--SET ECHO ON
SET PAGESIZE 500
SET FEEDBACK ON
SET HEADING ON