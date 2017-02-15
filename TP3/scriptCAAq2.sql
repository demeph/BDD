CREATE OR REPLACE PROCEDURE modifNoteCom(idc in number,refe in varchar2) IS
	eval avis.note%type :=  &eval;
	comment avis.commentaire%type := '&comment';
BEGIN
	UPDATE avis set note = eval where idcl = idc and refl = refe;
	UPDATE avis set commentaire = comment where idcl = idc and refl = refe;
END;
/