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
      dateachat date CHECK (dateachat > to_date('01-01-2008','DD-MM-YYYY') and dateachat < to_date('31-12-2013','DD-MM-YYYY') ),
      PRIMARY KEY(idcl,refl,dateachat)
    );
    
CREATE TABLE Avis(
  idcl number REFERENCES Clients,
  refl varchar2(10) REFERENCES LIVRES,
  note number(4,2) CHECK (note >= 1 and note <= 20),
  commentaire varchar2(50),
  PRIMARY KEY(idcl,refl)
);

INSERT INTO Clients Values (1,'toto','titi','Mars','41894561889');
INSERT INTO Clients Values (2,'tata','tete','Mars','41894561891');
INSERT INTO Clients Values (3,'harry','potter','poudlard','345989599');
INSERT INTO Clients Values (4,'elessar', 'telcontar', 'fennas druinin', '481516');
INSERT INTO Clients Values (5,'Holmes','Sherlock','221b Baker str','98546114');
INSERT INTO Clients Values (6,'Dr. Watson','John','221b Baker str','96464966');
INSERT INTO Clients Values (7,'Professeur Moriarty','Jim',NULL,NULL);


INSERT INTO Livres Values ('011A','C','Dennis Ritchie','casse tête');
INSERT INTO Livres Values ('011B','C++','Bjarne Stroustrup', 'casse tête avancé');
INSERT INTO Livres Values ('02A3','ISETL','Rampon','Langue morte');
INSERT INTO Livres Values ('03AA','Prolog','mr.logique','casse tête logique');
INSERT INTO Livres Values ('03A3', 'OCaml','Xavier Leroy';);
INSERT INTO Livres Values ();
INSERT INTO Livres Values ();
INSERT INTO Livres Values ();

INSERT INTO Achats Values (1,'O9REPI',to_date('01-01-2009','DD-MM-YYYY'));
INSERT INTO Achats Values (2,'O9REPO',to_date('02-01-2009','DD-MM-YYYY'));
