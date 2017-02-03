Drop SEQUENCE valParcours;
CREATE SEQUENCE valParcours start with 0 increment by 1 minvalue 0;

INSERT INTO parcours values('P_'||valParcours.nextval,'Seminaire ISETL','Langue morte',to_date('6-02-2017','DD-MM-YYYY'));
INSERT INTO parcours values('P_'||valParcours.nextval,'ISETL: why?','Langue morte',to_date('22-03-2017','DD-MM-YYYY'));
INSERT INTO parcours values('P_'||valParcours.nextval,'Histoire ISETL','Langue morte',to_date('6-03-2017','DD-MM-YYYY'));
INSERT INTO parcours values('P_'||valParcours.nextval,'Apprendre C++','Programmation',to_date('6-04-2017','DD-MM-YYYY'));


INSERT INTO compo_parcours values ('P_0','evt_1');
INSERT INTO compo_parcours values ('P_0','evt_2');
INSERT INTO compo_parcours values ('P_0','evt_3');
INSERT INTO compo_parcours values ('P_1','evt_4');
INSERT INTO compo_parcours values ('P_0','evt_5');
INSERT INTO compo_parcours values ('P_0','evt_6');
INSERT INTO compo_parcours values ('P_3','evt_6');

INSERT INTO inscrip_parcours values (1,'P_1');
INSERT INTO inscrip_parcours values (1,'P_2');
INSERT INTO inscrip_parcours values (1,'P_3');
INSERT INTO inscrip_parcours values (2,'P_3');
INSERT INTO inscrip_parcours values (2,'P_1');
INSERT INTO inscrip_parcours values (3,'P_3');
INSERT INTO inscrip_parcours values (4,'P_3');


INSERT INTO inscrip_evt values (1,'P_1','evt_4');
INSERT INTO inscrip_evt values (2,'P_1','evt_4');
INSERT INTO inscrip_evt values (2,'P_3','evt_6');
INSERT INTO inscrip_evt values (3,'P_3','evt_6');
INSERT INTO inscrip_evt values (4,'P_3','evt_6');