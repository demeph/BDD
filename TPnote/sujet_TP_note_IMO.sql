-- @sujet_TP_note_IMO
spool sujet_TP_note_IMO.log

prompt GROUPE TP
prompt Demetre PHALAVANDISHVILI
prompt COMPTE L3_35  
 
prompt *************************************************************
prompt ******************** CREATE TABLE ***************************
prompt *************************************************************
 
-- drop tables
DROP TABLE TP_JEUX_ACHETES CASCADE CONSTRAINTS;
DROP TABLE TP_JEUX CASCADE CONSTRAINTS;
DROP TABLE TP_JOUEURS CASCADE CONSTRAINTS;
 
-- create tables
CREATE TABLE TP_JEUX (
  nom_jeu				VARCHAR2(30),
  type_jeu				VARCHAR2(30),
  description_courte	VARCHAR2(200),
  prix					NUMBER,
  date_sortie			DATE,
  age_minimum			NUMBER,
  editeur				VARCHAR2(30),
  constraint pk_tp_jeux PRIMARY KEY (nom_jeu),
  constraint tp_verif_prix CHECK (prix >= 0),
  constraint tp_verif_age_minimum CHECK (age_minimum >= 0)
);

CREATE TABLE TP_JOUEURS (
  pseudo    	VARCHAR2(10),
  age			number,
  nb_jeux		number,
  constraint pk_tp_pseudo PRIMARY KEY (pseudo),
  constraint tp_verif_age CHECK (age >= 0)
);

CREATE TABLE TP_JEUX_ACHETES (
  nom_jeu    	VARCHAR2(30),
  pseudo     	VARCHAR2(10),
  date_achat    DATE,
  constraint pk_tp_jeux_achetes PRIMARY KEY (pseudo,nom_jeu),
  constraint fk_tp_jeux_achetes_joueurs FOREIGN KEY (pseudo) REFERENCES TP_JOUEURS(pseudo),
  constraint fk_tp_jeux_achetes_nom_jeu FOREIGN KEY (nom_jeu) REFERENCES TP_JEUX(nom_jeu)
);
 
prompt *************************************************************
prompt ******************** INSERT TABLE ***************************
prompt *************************************************************
 
insert into TP_JEUX (nom_jeu,type_jeu,description_courte,prix,date_sortie,age_minimum,editeur) 
VALUES ('The Witcher','Action-RPG','Base sur l''univers m�dieval-fantastique d''Andrzej Sapkowski, (...)',30,to_date('30-10-2007','dd-mm-yyyy'),18,'Atari');
insert into TP_JEUX (nom_jeu,type_jeu,description_courte,prix,date_sortie,age_minimum,editeur) 
VALUES ('Mass Effect','Action-RPG','En 2148, l''humanite decouvre sur la planete Mars les vestiges d''une civilisation disparue, les Protheens, permettant un bond technologique qui lui permet de voyager a travers l''espace (...)',30,to_date('28-05-2008','dd-mm-yyyy'),18,'Electronic Arts');
insert into TP_JEUX (nom_jeu,type_jeu,description_courte,prix,date_sortie,age_minimum,editeur) 
VALUES ('Anno 2205','Gestion','Bienvenue en 2205. voil� un siecle, l''Humanite s''est elancee vers les etoiles pour peupler la lune � l''occasion de la premiere vague de colonisation lunaire. ce  (...)',50,to_date('03-11-2015','dd-mm-yyyy'),0,'Ubisoft');
insert into TP_JEUX (nom_jeu,type_jeu,description_courte,prix,date_sortie,age_minimum,editeur) 
VALUES ('SpeedRunners','Plates-formes','SpeedRunners. Un jeu de course multijoueur a couper le souffle qui oppose 4 joueurs les uns contre les autres, (...)',15,to_date('19-04-2016','dd-mm-yyyy'),0,'TinyBuild Games');
insert into TP_JEUX (nom_jeu,type_jeu,description_courte,prix,date_sortie,age_minimum,editeur)  
VALUES ('Dragon Age Inquisition','Jeu de role (RPG)','Dragon Age: Inquisition prend place en Thedas, le monde fantastique dans lequel les deux jeux precedents se deroulaient. Le jeu couvre un territoire g�ographique (...)',40,to_date('18-11-2014','dd-mm-yyyy'),12,'Electronic Arts');
 
insert into TP_JOUEURS (pseudo,age,nb_jeux) VALUES ('SilCom',12,1);
insert into TP_JOUEURS (pseudo,age,nb_jeux) VALUES ('iCreeZiK',21,0);
insert into TP_JOUEURS (pseudo,age,nb_jeux) VALUES ('VolTaj',22,2);
insert into TP_JOUEURS (pseudo,age,nb_jeux) VALUES ('FaraY',18,0);
insert into TP_JOUEURS (pseudo,age,nb_jeux) VALUES ('SkyZze',9,0);
 
insert into TP_JEUX_ACHETES (nom_jeu,pseudo,date_achat)
VALUES ('SpeedRunners','VolTaj',to_date('11-03-2017','dd-mm-yyyy'));
insert into TP_JEUX_ACHETES (nom_jeu,pseudo,date_achat)
VALUES ('SpeedRunners','SilCom',to_date('11-03-2017','dd-mm-yyyy'));
insert into TP_JEUX_ACHETES (nom_jeu,pseudo,date_achat)
VALUES ('Mass Effect','VolTaj',to_date('15-02-2017','dd-mm-yyyy'));
 
commit;
 
prompt *************************************************************
prompt ******************** AFFICHAGE TABLE ************************
prompt *************************************************************
 
set pages 1000
set lines 150
 
SELECT * FROM TP_JEUX;
SELECT * FROM TP_JOUEURS;
SELECT * FROM TP_JEUX_ACHETES;
 
prompt *************************************************************
prompt ******************** QUESTION 1 *****************************
prompt *************************************************************

-- cr�er la vue jeux_de_VolTaj
-- elle permet de lister les jeux du joueur VolTaj
-- elle a les colonnes suivantes : nom_jeu, type_jeu, date_achat

drop view jeux_de_VolTaj;
CREATE VIEW jeux_de_VolTaj as 
select nom_jeu,type_jeu,date_achat
from tp_jeux natural join TP_JEUX_ACHETES t
where t.pseudo = 'VolTaj';

-- test de la vue

 
prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 2 *****************************
prompt *************************************************************


-- affichez tous les jeux que le joueur SilCom n'a pas encore achet� 
-- 	et qu'il a l'�ge de pouvoir acheter 
--		(l'�ge du joueur doit �tre �gal ou sup�rieur � l'�ge minimum associ� au jeu)
-- affichez : leur nom, type de jeu, prix, date de sortie
-- listez les jeux par ordre de date de sortie (date la plus r�cente en premier)
select j.nom_jeu,type_jeu,prix,date_sortie
from (TP_JEUX_ACHETES a natural join TP_JOUEURS joueur) right outer join TP_JEUX j on a.nom_jeu=j.nom_jeu
where joueur.age >= j.age_minimum
Order by date_sortie asc;


 
prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 3 *****************************
prompt *************************************************************

-- cr�er le trigger update_nb_jeux qui :
--		incr�mente de 1 la valeur de la colonne nb_jeux dans la table TP_JOUEURS � chaque fois qu'un joueur ach�te un jeu


set serveroutput on
CREATE or REPLACE TRIGGER update_nb_jeux
after insert on tp_jeux_achetes
FOR EACH ROW
Declare 
  nbjeux tp_joueurs.nb_jeux%type;
BEGIN
  select nb_jeux into nbjeux
  from tp_joueurs
  where pseudo = :new.pseudo;
  update tp_joueurs set nb_jeux = (nbjeux+1) where pseudo = :new.pseudo;
END;
/
show err

-- montrez que le trigger fonctionne par le biais d'un insert
select * from tp_jeux;
select * from tp_joueurs;
select * from TP_JEUX_ACHETES;
-- votre insert
INSERT into tp_jeux_achetes values ('Mass Effect','SilCom',to_date('23/03/2017','DD/MM/YYYY'));
INSERT into tp_jeux_achetes values ('The Witcher','SilCom',to_date('23/03/2017','DD/MM/YYYY'));

select * from tp_joueurs;

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 4 *****************************
prompt *************************************************************
 
-- cr�ez la procedure achat_jeu 
-- elle prend en entr�e le pseudo du joueur et le nom du jeu
-- elle v�rifie si le joueur � l'�ge pour jouer le jeu
-- si non elle soul�ve une exception
-- si oui, elle fait l'ajout et affiche un message disant au joueur que le jeu a �t� achet�
-- pour la date d'achat, la date du jour est prise (info : SYSDATE renvoie la date du jour)

set serveroutput on
create or replace procedure achat_jeu(pseudoJ in VARCHAR2,nomJeu in VARCHAR2)
IS 
 ageJ number;
 ageMin number;
 dateToday date;
 pas_le_droit exception;
BEGIN 
  select SYSDATE into dateToday from DUAL;
  select age into ageJ 
  from tp_joueurs
  where pseudo = pseudoJ;
  select age_minimum into ageMin
  from tp_jeux 
  where nom_jeu = nomJeu;
  if ageJ < ageMin then
    raise pas_le_droit;
  else 
    insert into tp_jeux_achetes values (nomJeu,pseudoJ,dateToday);
    DBMS_OUTPUT.PUT_LINE('le jeux a �t� achet� pour la date_achat : '|| dateToday);
  END if;
exception
  when pas_le_droit then
    RAISE_APPLICATION_ERROR(-20001,'Vous avez pas l''age minimum pour acheter ce jeux');
END;
/
show err

/*  il y a une erreur de ce type l� :
18/5   PL/SQL: SQL Statement ignored
18/41  PL/SQL: ORA-00984: column not allowed here
 je vois pas pourquoi

*/
-- 1pt
 
-- testez la procedure 
select nom_jeu,age_minimum from tp_jeux;
select pseudo,age from tp_joueurs;
select * from TP_JEUX_ACHETES;

-- appel de la procedure pour soulever l'exception
exec achat_jeu('SkyZze','Dragon Age Inquisition');

-- appel de la procedure pour faire l'achat
exec achat_jeu('VolTaj','Anno 2205');

select * from TP_JEUX_ACHETES;
 
prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION 5 *****************************
prompt *************************************************************

-- donnez les droits en select sur la table TP_JEUX_ACHETES � l'utilisateur TP_imo2017
 
-- donnez les droits d'insert, update et delete sur la table tp_jeux � l'utilisateur TP_imo2017

Grant select on tp_jeux_achetes to TP_imo2017;
Grant insert,update,delete on tp_jeux to TP_imo2017;

prompt
prompt
prompt *************************************************************
prompt ******************** QUESTION BONUS *************************
prompt *************************************************************


explain plan for select * from TP_JEUX_ACHETES where date_achat = to_date('11-03-2017','dd-mm-yyyy');
SELECT * FROM table(DBMS_XPLAN.DISPLAY);
 
-- comment am�liorer le plan d'execution
 
-- R�ponse : 
 
-- impl�mentation de la solution
 
-- test
 
explain plan for select * from TP_JEUX_ACHETES where date_achat = to_date('11-03-2017','dd-mm-yyyy');
SELECT * FROM table(DBMS_XPLAN.DISPLAY);
 
spool off
