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

Cette commande il cherche tous les noms des relations qu'on a dans notre base des données, prepare le script sous ce forma la:

```
DELETE FROM nomtableau_1 CASCADE;
DELETE FROM nomtableau_2 CASCADE;
DELETE FROM nomtableau_3 CASCADE;
```

**Attention** : cette commande ne supprime pas les relations, il prepare juste les commandes pour supprimer tous les relations.

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

**NOTE**: ls script decrit plus haut c'est les commandes de **sqlplus** et non pas d'Oracle



Quand on utilise DROP TABLE, il faut utiliser CASCADE CONTRAINTS

Quand on utilise DELETE FROM, a la creation de la contrainte FOREIGN KEY utiliser " ON DELETE CASCADE " cela va supprimer sur la table "maitre" et la table "esclave"

