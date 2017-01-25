DECLARE
	num number(4,2);
	reflLivre varchar2(10) := '011A';
BEGIN
	select avg(note) into num
		from avis
		where refl = reflLivre;
	update livres set note_moy = num where refl = reflLivre;
END;
/