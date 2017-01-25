--JAMET Felix - PHALAVANDISHVILI Demetre - Groupe 601B
SET ECHO OFF
SPOOL acheteurs2011.lst
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT nom,pren,tel || ';' FROM Achats a left outer join clients c on a.idcl=c.idcl where a.dateachat >= to_date('01-01-2011','DD-MM-YYYY') and a.dateachat <= to_date('31-12-2011','DD-MM-YYYY')  group by nom,pren,tel;

SPOOL OFF
--SET ECHO ON
SET PAGESIZE 500
SET FEEDBACK ON
SET HEADING ON