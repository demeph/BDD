--JAMET Felix - PHALAVANDISHVILI Demetre - Groupe 601B
set headsep !

-- Permet de definir le titre du rapport
ttitle 'Achats des clients au 28 janvier 2013'

--definit la colonne des identifiant de client de type entier
column idcl format 999
-- definit la colonne pour la prix d'un livre  d'un type numbre(4,2)
column prix format 99.99

-- rajouter une ligne vide avant une valeur diffèrent de idcl
break on idcl skip 1 on report
-- Permet de calculer la somme et la moyenne des achats que chaque client a réalisé
compute avg sum of prix on idcl

set linesize 80
set pagesize 41
set newpage 0
set feedback OFF

SET ECHO OFF

--ecrit le resultat dans le fichier
spool 2013-01-28-achats.lst

--requete qui permet d'avoir le resultat souhaité
select idcl,dateachat,genre,prix from Achats natural join livres where dateachat <= to_date('28-01-2013','DD-MM-YYYY') order by idcl,dateAchat asc;

spool off