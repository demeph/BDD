CREATE OR REPLACE PROCEDURE modifNoteCom(idc in number,refe in varchar2) IS
	eval avis.note%type :=  &eval;
	comment avis.commentaire%type := '&comment';
	nbLigne number;
	pas_droit exception;
BEGIN
   Select count(*) into nbLigne from avis where idcl = idc and refl = refe;
   if nbLigne is null then
   	raise pas_droit;
  	else 
		UPDATE avis set note = eval where idcl = idc and refl = refe;
		UPDATE avis set commentaire = comment where idcl = idc and refl = refe;
	end if;
exception
	when pas_droit then
		DBMS_OUTPUT.PUT_LINE('Il faut avoir un avis, avant de modifier l''avis');	
END;
/
