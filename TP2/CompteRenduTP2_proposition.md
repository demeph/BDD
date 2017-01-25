*JAMET Felix - PHALAVANDISHVILI Demetre - Groupe 601B*

# TP2 Reporting SQL PLUS

## Q 1

​	Pour créer une sequence, on ajoute la commande suivante dans notre script. Comme on nous l'a expliqué lors du TP, pour pouvoir réellement commencer à 1, nous avons utilisé ```sql START WITH 0``` et ```sql MINVALUE 0```:

````sql
CREATE SEQUENCE idcl_sequence START WITH 0 INCREMENT BY 1 MINVALUE 0 ;
````

	on utilise par la suite ```sql idcl_sequence.nextval``` lors de l'insertion de nouvelles valeurs dans la table :

````sql
INSERT INTO Clients Values (idcl_sequence.nextval,'toto','titi','Mars','123456789123');
INSERT INTO Clients Values (idcl_sequence.nextval,'tata','tete','Jupiter','234567891231');
INSERT INTO Clients Values (idcl_sequence.nextval,'Potter','Harry','Poudlard','345678912312');
INSERT INTO Clients Values (idcl_sequence.nextval,'Elessar', 'telcontar', 'fennas druinin', '456789123123');
INSERT INTO Clients Values (idcl_sequence.nextval,'Holmes','Sherlock','221b Baker str','567891231234');
INSERT INTO Clients Values (idcl_sequence.nextval,'Dr. Watson','John','221b Baker str','678912312345');
INSERT INTO Clients Values (idcl_sequence.nextval,'Pr. Moriarty','Jim',NULL,NULL);
````

	Toutes ces instructions se trouvent dans le fichier *tp2.sql* entre les lignes 38-50.

## Q 2

	On nous a demandé de tester la requête suivante :

````sql
SELECT  'DELETE FROM ' || table_name || ';' FROM user_tables;
````

​	Cette requête nous prépare les commandes pour vider toutes les tables de notre base de données, sans pour autant les exécuter.

​	La sortie de cette commande est :

````sql
DELETE FROM CLIENTS;
DELETE FROM LIVRES;
DELETE FROM ACHATS;
DELETE FROM AVIS;
````

## Q 3

​	Nous avons rajouté quelques lignes au script suggéré afin de rétablir l'affichage d'informations.

````sql
SET ECHO OFF
SPOOL poubelle.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT 'DELETE FROM ' || table_name || ';' FROM USER_TABLES ;

SPOOL OFF
SET PAGESIZE 500
SET FEEDBACK ON
SET HEADING ON
````

​	Le résultat de l'execution de ce script s'enregistre dans le fichier *poubelle.sql*. il faut ensuite exécuter *poubelle.sql* pour vider tout le contenu de nos tables.

​	Ce script se trouve dans le fichier *question3.sql*, puis *effacer.sql*.

## Q 4

​	On propose les exemples suivant:

- Exemple 1

```sql
SET ECHO OFF
SPOOL Drop_Table.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINTS;' FROM USER_TABLES ;

SPOOL OFF
--SET ECHO ON
SET PAGESIZE 500
SET FEEDBACK ON
SET HEADING ON
```

​	Ce script permet de supprimer toutes les tables présentes dans notre base de données.

​	Pour executer ce script, il faut executer le fichier *question4_ex1.sql*, et puis *Drop_Table.sql*.

- Exemple 2

```sql
SET ECHO OFF
SPOOL acheteurs2011.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT nom,pren,tel || ';' FROM Achats a left outer join clients c on a.idcl=c.idcl where a.dateachat >= to_date('01-01-2011','DD-MM-YYYY') and a.dateachat <= to_date('31-12-2011','DD-MM-YYYY')  group by nom,pren,tel;

SPOOL OFF
--SET ECHO ON
+SET PAGESIZE 500
SET FEEDBACK ON
+SET HEADING ON
```

​	Ce script permet d'avoir dans le fichier *acheteurs2012.sql* tous les clients (nom, prenom,tel) de chaque client qui ont acheté la(les) livre(s) durant l'année 2011.

​	Ce script peut être executé en utilisant le fichier *question4_ex2*. et puis *acheteurs2011.sql*.

## Q 5

​	Pour ajouter un nouvelle colonne a la rélation achats on utilise la commande suivante :

````sql
alter table achats add prix number(4,2);
````

Ensuite pour remplir cette colonne on utilise les instructions suivantes :

````sql
update achats set prix = '18,99' where refl = '011A';
update achats set prix = '15,99' where refl = '011B';
update achats set prix = '23,99' where refl = '03A3';
update achats set prix = '21,99' where refl = '03B3';
update achats set prix = '22,99' where refl = '03AA';
update achats set prix = '27,99' where refl = '02A3';
````

Dans le fichier *tp2.sql* on peut trouver ces instructions entre les lignes 83-2

## Q 6

​	Dans cette question il fallait fair le rapport de la moyenne et  la somme des prix par client. Avant de faire le rapport , on a d'abord ecrit la requête sql qui correspond a la demande. La requete est suivant :

```mysql
SELECT idcl,dateachat,genre,prix 
FROM Achats NATURAL JOIN livres 
WHERE dateachat <= to_date('28-01-2013','DD-MM-YYYY') 
ORDER BY idcl,dateAchat ASC;
```

​	Puis on a ecrit le script suivante qui permet d'avoir le rapport demandé :

```sql
set headsep !

-- Permet de definir le titre du rapport
ttitle 'Achats des clients au 28 janvier 2013'

--definit la colonne des identifiant de client de type entier
column idcl format 999
-- definit la colonne pour la date achat de chaque livre de type date
column DateAchat format a9
-- defnit la colonne pour la genre d'un livre de type chaine de caractère de longueur 15
column Genre format a15
-- definit la colonne pour la prix d'un livre  d'un type numbre(4,2)
column prix format 99.99

-- permet d'afficher la moyenne et la somme juste avant qu'on change idcl
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
```

