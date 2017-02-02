SET SERVEROUTPUT ON
CREATE OR REPLACE TRIGGER propParcours
AFTER INSERT ON achats
FOR EACH ROW
DECLARE
	genreLiv Livres.genre%type;	
	/*cursor lesParcs is select distinct intitulep,date_deb
					from parcours p
					where p.genre = (select genre FROM Livres l WHERE l.refl = :new.refl) and p.date_deb > (select sysdate from dual)
					order by date_deb asc;*/
BEGIN
	select genre into genreLiv FROM Livres l WHERE l.refl = :new.refl;
	DBMS_OUTPUT.PUT_LINE(genreLiv);	
	/*IF inserting then
		DBMS_OUTPUT.PUT_LINE('On vous propose les parours suivants :');
		For n in lesParcs LOOP
			DBMS_OUTPUT.PUT_LINE(n.intitulep||n.date_deb);
		END LOOP;
	END IF;*/
END;
/