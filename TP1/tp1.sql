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
  idcl number REFERENCES Clients,
  refl varchar2(10) REFERENCES Livres,
  dateachat date CHECK (dateachat BETWEEN to_date('01-01-2008','DD-MM-YYYY') and to_date('31-12-2013','DD-MM-YYYY') ),
  PRIMARY KEY(idcl,refl,dateachat)
);
    
CREATE TABLE Avis(
  idcl number REFERENCES Clients,
  refl varchar2(10) REFERENCES LIVRES,
  note number(4,2) CHECK (note >= 1 and note <= 20),
  commentaire varchar2(50),
  PRIMARY KEY(idcl,refl)
);

INSERT INTO Clients Values (1,'toto','titi','Mars','123456789123');
INSERT INTO Clients Values (2,'tata','tete','Jupiter','234567891231');
INSERT INTO Clients Values (3,'Potter','Harry','Poudlard','345678912312');
INSERT INTO Clients Values (4,'Elessar', 'telcontar', 'fennas druinin', '456789123123');
INSERT INTO Clients Values (5,'Holmes','Sherlock','221b Baker str','567891231234');
INSERT INTO Clients Values (6,'Dr. Watson','John','221b Baker str','678912312345');
INSERT INTO Clients Values (7,'Pr. Moriarty','Jim',NULL,NULL);


INSERT INTO Livres Values ('011A','C','Dennis Ritchie','Programmation');
INSERT INTO Livres Values ('011B','C++','Bjarne Stroustrup', 'Programmation');
INSERT INTO Livres Values ('02A3','ISETL','Jacob Schwartz','Langue morte');
INSERT INTO Livres Values ('03AA','Prolog','mr.logique','Programmation');
INSERT INTO Livres Values ('03A3','OCaml','Xavier Leroy','Fonctionnelle');
INSERT INTO Livres Values ('03B3','HASKELL','Commun Has','Fonctionnelle');

INSERT INTO Achats Values (1,'011A',to_date('01-01-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (2,'011A',to_date('02-01-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'011A',to_date('02-12-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (1,'011B',to_date('23-11-2012','DD-MM-YYYY'));
INSERT INTO Achats Values (2,'011B',to_date('21-12-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'011B',to_date('22-04-2012','DD-MM-YYYY'));
INSERT INTO Achats Values (3,'03A3',to_date('02-05-2011','DD-MM-YYYY'));
INSERT INTO Achats Values (4,'011B',to_date('02-09-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (5,'03B3',to_date('02-1-2012','DD-MM-YYYY'));
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

-- Suppression
DELETE FROM Clients where idcl = 7;
DELETE FROM Achats where idcl = 1 and refl = '02A3';


-- check contrainnts
INSERT INTO Achats Values (4,'011A',to_date('02-12-2015','DD-MM-YYYY'));
INSERT INTO Achats Values (4,'011A',to_date('02-12-2003','DD-MM-YYYY'));
INSERT INTO AVIS Values (6,'03AA',22,NULL);
INSERT INTO AVIS Values (6,'03AA',0,NULL);


-- Requets SQL format lisible
--    1.
--    SELECT titre,auteur,genre
--    FROM Livres natural join Achats
--    GROUP BY refl
--    having count(*) >= 2
--    ORDER BY ASC

--    2. 
--    Select titre,auteur,genre
--    FROM Avis natural join Livres
--    Group by titre,auteur,genre
--    HAVING AVG(note) > 16

--    3.
--    Select idcl,titre, note
--    FROM ( Clients c right outer join Avis a on c.idcl=a.idcl ) join Livres l on l.refl= a.refl
--    WHERE Avis.commentaire = NULL
 
-- Requets SQL formal SQL Command
-- 1.   
Select titre,auteur,genre From Livres natural join Achats Group BY titre,auteur,genre having count(*)> 2;

-- 2.
Select titre,auteur,genre from Avis natural join Livres Group by titre,auteur,genre having AVG(note) > 16;

-- 3.
Select nom,pren,l.titre,note from ( Clients c right outer join Avis a on c.idcl=a.idcl ) join Livres l on l.refl= a.refl where a.commentaire is NULL;
