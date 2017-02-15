--Jamet Félix - PHAlAVANDISHVILI Demetre  - Groupe 601B

-- Pour les explications, consulter le fichier pdf present dans le dossier
set linesize 100;

-- Mise à jour de la note moyenne
-- Q1
Alter table Livres add note_moy(4,2);
--a)
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

--b)
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

--c)
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

-- Q2

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
DROP TRIGGER maj_note_moy;

-- Cohérence Avis-Achat
-- Q1
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER coherenceAA
before INSERT on avis
FOR EACH ROW
DECLARE
	nb number;
	acheter_Liv exception;
BEGIN
	if inserting then
		select count(*) into nb
		from avis a left outer join achats b on a.idcl = b.idcl and a.refl = b.refl
		where a.idcl = :new.idcl and a.refl = :new.refl;
		if nb = 0 then 
			raise acheter_Liv;
		END if;
	end if;
exception
	when acheter_Liv then
		raise_application_error(-20010,'Vous devez acheter un livre avant donner un avis');
END;
/

-- Q2
CREATE OR REPLACE PROCEDURE modifNoteCom(idc in number,refe in varchar2) IS
	eval avis.note%type :=  &eval;
	comment avis.commentaire%type := '&comment';
	nbLigne number;
BEGIN
	Select count(*) into nbLigne from avis where idcl = idc and refl = refe;
	if nbLigne = 0 then
   		raise_application_error(-20011,'Il faut avoir un avis, avant de modifier l''avis');	
  	else
		if eval is not null then
			UPDATE avis set note = eval where idcl = idc and refl = refe;
		end if;
		if comment is not null then 
			UPDATE avis set commentaire = comment where idcl = idc and refl = refe;
		end if;
	end if;
END;
/

-- Traitement d'une inscription à un parcours
-- Q1) 
CREATE OR REPLACE PROCEDURE inscriptionEvt(idCa in varchar2,idpa in varchar2) IS
	idEVt inscrip_evt.id_evt%type;
	Unevt compo_parcours.id_evt%type;
	cursor lesEvt is select distinct id_evt
					from compo_parcours cmp
					where cmp.idp = idpa;
BEGIN
	INSERT INTO inscrip_parcours values (idCa,idpa);
	For Unevt in lesEvt LOOP
		INSERT INTO inscrip_evt values (idCa,idpa,Unevt.id_evt);
	END LOOP;
END;
/

-- Q2)
SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER propParcours
AFTER INSERT ON achats
FOR EACH ROW
DECLARE
	cursor lesParcs is select distinct intitulep,date_deb
					from parcours p
					where p.genre = (select genre FROM Livres l WHERE l.refl = :new.refl) and p.date_deb >= :new.dateachat
					order by date_deb asc;
BEGIN
	IF inserting then
		DBMS_OUTPUT.PUT_LINE('On vous propose les parours suivants :');
		For n in lesParcs LOOP
			DBMS_OUTPUT.PUT_LINE('"'||n.intitulep||'" commencant le '||n.date_deb);
		END LOOP;
	END IF; 	
END;
/