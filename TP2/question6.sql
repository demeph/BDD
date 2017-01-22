rem Bookshelf activty report

set headsep !

ttitle 'Achats des clients au 28 janvier 2013'
btitle ''

column idcl format 999
column DateAchat format a20 word_wrapped
column Genre format a20 
column prix format 999.99
column prix heading 'prix'

break on idcl skip 1 on report
compute avg sum of prix on idcl

set linesize 80
set pagesize 41
set newpage 0
set feedback off

spool 2013-01-28-achats.lst

select c.idcl,dateachat,genre,a.prix from (clients c left outer join Achats a on c.idcl=a.idcl) join livres l on l.refl = a.refl where a.dateachat < to_date('28-01-2013','DD-MM-YYYY') order by c.idcl,a.dateAchat asc;

spool off