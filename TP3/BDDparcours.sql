create table parcours (
	idp varchar2(10) primary key,
	intitulep varchar2(15),
	genre varchar2(15),
	date_deb date
);

create table compo_parcours(
	idp varchar2(10) REFERENCES parcours on delete cascade,
	id_evt varchar2(10),
	primary key(idp,id_evt)
);

create table inscrip_parcours(
	idcl number references clients on delete cascade,
	idp varchar2(10) REFERENCES parcours on delete cascade,
	primary key(idcl,idp)
);

create table inscrip_evt(
	idcl number references clients on delete cascade,
	idp varchar2(10) REFERENCES parcours on delete cascade,
	id_evt varchar2(10),
	primary key(idcl,idp,id_evt)
);

