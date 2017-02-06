*PHALAVANDISHVILI Demetre - JAMET Felix*

# TP3 PL/SQL

## Mise à jour de la note moyenne

### Q1

#### a)

```plsql
DECLARE
	num number(4,2);
	reflLivre varchar2(10) := '&reflLivre';
BEGIN
	select avg(note) into num
		from avis
		where refl = reflLivre;
	update livres set note_moy = num where refl = reflLivre;
END;
/
```

#### b)

​	Pour récupérer toutes les références des livres que l'on possède dans notre base de données, on utilise un curseur nous permettantde parcourir et de récupérer une à une les lignes du résultat de la requête suivante:

```plsql
cursor lesrefls is select refl from livres;
```

​	Puis, en utilisant une boucle *for*, on parcours les références en calculant la moyenne pour chaque livre

```plsql
DECLARE	
	moy Livres.note_moy%TYPE;
	cursor lesrefls is select refl from livres;
BEGIN
	for n in lesrefls LOOP
		select avg(note) into moy
		from avis
		where refl = n.refl;
		update livres set note_moy = moy where refl = n.refl;
	End LOOP;
END;
/
```

#### c)

```plsql
CREATE OR REPLACE PROCEDURE calculMoyenne IS
	moy Livres.note_moy%TYPE;
	cursor lesrefls is select refl from livres;
BEGIN
	for n in lesrefls LOOP
		select avg(note) into moy
		from avis
		where refl = n.refl;
		update livres set note_moy = moy where refl = n.refl;
	End LOOP;
END;
/
```

### Q2

```plsql
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER maj_note_moy
AFTER INSERT OR UPDATE on avis
FOR EACH ROW
DECLARE
	moy Livres.note_moy%type;
BEGIN
	if inserting or updating then
		select avg(note) into moy
		from avis
		where refl = :new.refl;
		update livres set note_moy = moy where refl = :new.refl;
	end if;
END;
/
```

​	On écrit le trigger suivant qui s'applique après l'ajout ou la modification d'un avis. Le but est de modifier dynamiquement la note moyenne de livre pour chaque avis exprimé. Mais on obtient une erreur en lançant la requête suivante :

```plsql
INSERT INTO AVIS Values (6,'03B3',16.5,NULL);
```

    Voici l'erreur obtenur :

```plsql
ERROR at line 1:
ORA-04091: table DEMNA.AVIS is mutating, trigger/function may not see it
ORA-06512: at "DEMNA.MAJ_NOTE_MOY", line 5
ORA-04088: error during execution of trigger 'DEMNA.MAJ_NOTE_MOY'
```

​	Le SGBD nous empêche d'utiliser les données qu'on veux ajouter dans notre bdd, parce que la requete par laquelle on modifie ou ajoute ladonnée peuvent echoué, comme ça on garantie l'integrité de la base des données.  //j'avoue pas comprendre. j'ai moitié oublié ce que isabelle avait expliqué pendant le TP

​	Pour éviter cette erreur, on ajoute la ligne suivante :

```plsql
DROP TRIGGER maj_note_moy;
```

## Cohérence Avis-Achat

### Q1

```plsql
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER coherenceAA
after INSERT on avis
FOR EACH ROW
DECLARE
	nb number;
	acheter_Liv exception;
BEGIN
	if inserting then
		select count(*) into nb
		from avis a left outer join achats b on a.idcl = b.idcl and a.refl = b.refl
		where a.idcl = :new.idcl and a.refl = :new.refl;
		if nb is null then 
			raise acheter_Liv;
		END if;
	end if;
exception
	when acheter_Liv then
		DBMS_OUTPUT.PUT_LINE('Vous devez acheter un livre avant donner un avis');
END;
/
DROP TRIGGER coherenceAA;
```





## Traitement d'une inscription à un parcours

