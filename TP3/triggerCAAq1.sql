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