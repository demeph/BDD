CREATE OR REPLACE PROCEDURE calculeMoyenne IS
	moy number(4,2);
	cursor lesrefls is select refl from livres;
BEGIN
	for n in lesrefls LOOP
		select avg(note) into moy
		from avis
		where refl = n.refl;
		if moy is null 
			then moy:=0; 
		End if;
		update livres set note_moy = moy where refl = n.refl;
	End LOOP;
END;
/