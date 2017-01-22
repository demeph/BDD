# TP2#

## Definition d'une séquence

Pour créer la sequence qui incremente automatiquement  **id** qu'on veut pour cela on utilise la commande suivante:

```sql
CREATE SEQUENCE nom_Sequence START WITH valeur_debut INCREMENT BY nb;
```

où nb $=$ nombre ajouté a la valeur du debut

Dans la commande d'insertion on utilise la commande suivante:

```sql
INSERT INTO maTable VALUES(nom_Sequence.nextval, ...) ;
```

Pour arrete auto-compteur, on utilise la commande suivnate:

```sql
DROP SEQUENCE nom_Sequence
```

### Q1 - Exemple de l'utilisation de la sequence

```sql
INSERT INTO Clients Values (maSequence.nextval,'toto','titi','Mars','123456789123');
INSERT INTO Clients Values (maSequence.nextval,'tata','tete','Jupiter','234567891231');
INSERT INTO Clients Values (maSequence.nextval,'Potter','Harry','Poudlard','345678912312');
INSERT INTO Clients Values (maSequence.nextval,'Elessar', 'telcontar', 'fennas druinin', '456789123123');
INSERT INTO Clients Values (maSequence.nextval,'Holmes','Sherlock','221b Baker str','567891231234');
INSERT INTO Clients Values (maSequence.nextval,'Dr. Watson','John','221b Baker str','678912312345');
INSERT INTO Clients Values (maSequence.nextval,'Pr. Moriarty','Jim',NULL,NULL);
```

### Q2

```sql
SELECT 'DELETE FROM ' || table_name || ';'
FROM USER_TABLES ;
```

Attention : cette commande ne supprime pas les relations, il prepare juste les commandes pour supprimer tous les relations.

Cette commande il cherche tous les noms des relations qu'on a dans notre base des données, prepare le script sous ce forme la:

```
DELETE FROM nomtableau_1 CASCADE;
DELETE FROM nomtableau_2 CASCADE;
DELETE FROM nomtableau_3 CASCADE;
```

### Q3

Pour supprimer les tableaux, il faut utiliser ce script en incluant dedans la commande precedent:

```sql
SET ECHO OFF
SPOOL effacer.sql
SET ECHO OFF
SET FEEDBACK OFF
SET HEADING OFF
SET PAGESIZE 0

SELECT 'DELETE FROM ' || table_name || 'CASCADE;'
FROM USER_TABLES ;

SPOOL OFF
SET ECHO OFF
```

**NOTE**: ls script decrit plus haut c'est les commandes de **sqlplus** et non pas d'Oracle.

Quand on utilise DROP TABLE, il faut utiliser CASCADE CONTRAINTS

Quand on utilise DELETE FROM, a la creation de la contrainte FOREIGN KEY utiliser " ON DELETE CASCADE " cela va supprimer sur la table "maitre" et la table "esclave"

### Q4

```sql
SET ECHO OFF
SPOOL acheteurs.sql
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

```

On peut avoir une script qui permet d'avoir la liste des clients(nom,prenom,num telephone) qui ont acheté le livre durant l'année 2011. Après avoir executer cette dans le fichier *acheteurs.sql* on a cette liste.



La modele du question 3, on peut utiiser pour supprimer tous les tableaux qui se trouve dans notre base des données

```sql
SET ECHO OFF
SPOOL do_dropall.sql
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





### Q5

​	Pour  ajouter la colonne prix dans le tableau *Achats*, on utilise la commande suivant :

```sql
alter table achats add prix number(4,2);
```

​	Cette commande ajout juste la colonne vide; pour ajouter les valeurs on ajoute le prix de chaque livre present dans le tableau Achats; les commandes sont suivantes :

```sql
update achats set prix = '18,99' where refl = '011A';
update achats set prix = '15,99' where refl = '011B';
update achats set prix = '23,99' where refl = '03A3';
update achats set prix = '21,99' where refl = '03B3';
update achats set prix = '22,99' where refl = '03AA';
update achats set prix = '21,99' where refl = '02A3';
```

