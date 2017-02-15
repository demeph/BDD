--JAMET Felix - PHALAVANDISHVILI Demetre - Groupe 601B
DROP TABLE Achats;
DROP TABLE Avis;
DROP TABLE Clients;
DROP TABLE Livres;


CREATE TABLE Clients (
  idcl number PRIMARY KEY,
  nom varchar2(20),
  pren varchar2(15),
  adr varchar2(30),
  tel varchar2(12)
);
    
CREATE TABLE Livres(
  refl varchar2(10) PRIMARY KEY,
  titre varchar2(20),
  auteur varchar2(20),
  genre varchar2(15)
);

CREATE TABLE Achats(
  idcl number REFERENCES Clients ON DELETE CASCADE,
  refl varchar2(10) REFERENCES Livres ON DELETE CASCADE,
  dateachat date CHECK (dateachat BETWEEN to_date('01-01-2008','DD-MM-YYYY') and to_date('31-12-2013','DD-MM-YYYY') ),
  PRIMARY KEY(idcl,refl,dateachat)
);
    
CREATE TABLE Avis(
  idcl number REFERENCES Clients ON DELETE CASCADE,
  refl varchar2(10) REFERENCES LIVRES ON DELETE CASCADE,
  note number(4,2) CHECK (note >= 1 and note <= 20),
  commentaire varchar2(50),
  PRIMARY KEY(idcl,refl)
);

--Question 1:
Drop SEQUENCE idcl_sequence;
CREATE SEQUENCE idcl_sequence START WITH 0 INCREMENT BY 1 MINVALUE 0 ;

-- Les requetes pour remplir les tableaux créés auparavant

INSERT INTO Clients Values (idcl_sequence.nextval,'toto','titi','Mars','123456789123');
INSERT INTO Clients Values (idcl_sequence.nextval,'tata','tete','Jupiter','234567891231');
INSERT INTO Clients Values (idcl_sequence.nextval,'Potter','Harry','Poudlard','345678912312');
INSERT INTO Clients Values (idcl_sequence.nextval,'Elessar', 'telcontar', 'fennas druinin', '456789123123');
INSERT INTO Clients Values (idcl_sequence.nextval,'Holmes','Sherlock','221b Baker str','567891231234');
INSERT INTO Clients Values (idcl_sequence.nextval,'Dr. Watson','John','221b Baker str','678912312345');
INSERT INTO Clients Values (idcl_sequence.nextval,'Pr. Moriarty','Jim',NULL,NULL);


INSERT INTO Livres Values ('011A','C','Dennis Ritchie','Programmation');
INSERT INTO Livres Values ('011B','C++','Bjarne Stroustrup', 'Programmation');
INSERT INTO Livres Values ('02A3','ISETL','Jacob Schwartz','Langue morte');
INSERT INTO Livres Values ('03AA','Prolog','mr.logique','Programmation');
INSERT INTO Livres Values ('03A3','OCaml','Xavier Leroy','Prog Fonction');
INSERT INTO Livres Values ('03B3','HASKELL','Commun Has','Prog Fonction');

INSERT INTO Achats Values (1,'011A',to_date('01-01-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (2,'011A',to_date('02-01-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'011A',to_date('02-12-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (1,'011B',to_date('23-11-2012','DD-MM-YYYY'));
INSERT INTO Achats Values (2,'011B',to_date('21-12-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'011B',to_date('22-04-2012','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'03A3',to_date('02-05-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (4,'011B',to_date('02-09-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (5,'03B3',to_date('02-01-2012','DD-MM-YYYY'));
INSERT INTO Achats Values (6,'03AA',to_date('02-12-2010','DD-MM-YYYY'));
INSERT INTO Achats Values (1,'02A3',to_date('02-12-2009','DD-MM-YYYY'));

INSERT INTO AVIS Values (1,'011A',19,'Cool');
INSERT INTO AVIS Values (2,'011A',16,'bien');
INSERT INTO AVIS Values (3,'011A',7,'pas content');
INSERT INTO AVIS Values (1,'011B',18,'Cool');
INSERT INTO AVIS Values (2,'011B',17,'bien');
INSERT INTO AVIS Values (3,'011B',17,'contente');
INSERT INTO AVIS Values (3,'03A3',17,'content');
INSERT INTO AVIS Values (4,'011B',19,NULL);
INSERT INTO AVIS Values (5,'03B3',16.5,NULL);
INSERT INTO AVIS Values (6,'03AA',17,NULL);


-- Question 5

alter table achats add prix number(4,2);

update achats set prix = '18,99' where refl = '011A';
update achats set prix = '15,99' where refl = '011B';
update achats set prix = '23,99' where refl = '03A3';
update achats set prix = '21,99' where refl = '03B3';
update achats set prix = '22,99' where refl = '03AA';
update achats set prix = '27,99' where refl = '02A3';
