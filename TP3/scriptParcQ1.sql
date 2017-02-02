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
