# TP2#

## Definition d'une séquence

Pour créer la sequence qui incremente automatiquement  **id** qu'on veut pour cela on utilise la commande suivante:

```sql
CREATE SEQUENCE nom_Sequence START WITH valeur_debut INCREMENT BY nb;
```

où nb $=$ nombre ajouté a la valeur du debut

Dans la commande d'insertion on utilise la commande suivante:

```sql
INSERT INTO maTable VALUES(nom_Sequence.nextval, ...) ;
```

Pour arrete auto-compteur, on utilise la commande suivnate:

```sql
DROP SEQUENCE nom_Sequence
```

### Q1 - Exemple de l'utilisation de la sequence

```sql
INSERT INTO Clients Values (maSequence.nextval,'toto','titi','Mars','123456789123');
INSERT INTO Clients Values (maSequence.nextval,'tata','tete','Jupiter','234567891231');
INSERT INTO Clients Values (maSequence.nextval,'Potter','Harry','Poudlard','345678912312');
INSERT INTO Clients Values (maSequence.nextval,'Elessar', 'telcontar', 'fennas druinin', '456789123123');
INSERT INTO Clients Values (maSequence.nextval,'Holmes','Sherlock','221b Baker str','567891231234');
INSERT INTO Clients Values (maSequence.nextval,'Dr. Watson','John','221b Baker str','678912312345');
INSERT INTO Clients Values (maSequence.nextval,'Pr. Moriarty','Jim',NULL,NULL);
```



