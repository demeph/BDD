#TP 5#

##Prise en main de la base

###Q
 PUBLICATION_ID   			       NOT NULL VARCHAR2(100)
 SQUAD_ID					       NOT NULL VARCHAR2(100)
 DATE_ID					       NOT NULL VARCHAR2(20)
 SUPPORT_ID	
- facts
	- clé primaire :
	- clé etrangeres : tous les attributs de cette rélation sont les clés etrangeres
- authors
	- clé primaire : 
		- author_id 
	- aucune clé étrangère
- collaborations
	- clé primaire : 
		- squad_id & author_id
	- clé(s) étrangère(s) : 
		- squad_id $\rightarrow $ relation *Squad* 
		- author_id $\rightarrow $ relation *author_id*
- dates 
	- clé primaire :
		- date_id
	- aucune clé étrangère
- publications 
	- clé primaire 
		- publication_id
	- aucune clé étrangère
- squads  
	- clé primaire : 
		- squad_id & author_id
	- aucune clé étrangère
- supports
	- clé primaire : 
		- support_id
	- aucune clé(s) étrangère(s)

###Q2
|Nom de Tableau | nombre de Ligne |
| facts |  473176 |
| authors | 454807 |
| collaborations | 1212896 |
| dates | 487 |
| publications | 481659 |
| squads | 479540 |
| supports | 11243 |

## Visualisation du plan d'exécution d'une requête
