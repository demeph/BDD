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

