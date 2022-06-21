------------MATEO FLEJOU / ANTHONY HASCOET-------------------

-------------------------------------------------------------
----------SAE implantation SQL et manipulation---------------
-------------------------------------------------------------

-------------Teste demande dans le document------------------
DELETE FROM Mesure;
DELETE FROM TypeEqui_IndicateurEnv;
DELETE FROM Pays_A_TypeEquipement ;
DELETE FROM IndicateurEnv ;
DELETE FROM TypeEquipement ;
DELETE FROM Domaine;
DELETE FROM Pays;



-- existence de la clé primaire– 

--1) 
INSERT INTO Pays VALUES(null,'Afrique',25,35); 
--2)
INSERT INTO Domaine VALUES(null);

/*
Résultat des erreurs:
--1)
Erreur commençant à la ligne: 3 de la commande -
INSERT INTO Pays VALUES(null,'Afrique',25,35)
Rapport d'erreur -
ORA-01400: cannot insert NULL into ("MATEO"."PAYS"."NOMPAYS")

--2)
Erreur commençant à la ligne: 5 de la commande -
INSERT INTO Domaine VALUES(null)
Rapport d'erreur -
ORA-01400: cannot insert NULL into ("MATEO"."DOMAINE"."INTITULEDOMAINE")
*/

-- unicité de la clé primaire (deux même valeur) –
--1)
INSERT INTO Pays VALUES('France','Europe',25,35);
INSERT INTO Pays VALUES('France','Europe',45,68);

--2)
INSERT INTO Domaine VALUES('Utilisateur');
INSERT INTO Domaine VALUES('Utilisateur');
/*
Résultat des erreurs :

--1)
1 ligne inséré.

Erreur commençant à la ligne: 25 de la commande -
INSERT INTO Pays VALUES('France','Europe',45,68)
Rapport d'erreur -
ORA-00001: unique constraint (MATEO.PK_PAYS) violated

--2)
1 ligne inséré.


Erreur commençant à la ligne: 29 de la commande -
INSERT INTO Domaine VALUES('Utilisateur')
Rapport d'erreur -
ORA-00001: unique constraint (MATEO.PK_DOMAINE) violated
*/


-- intégrité de la clé étrangère–
--1)

INSERT INTO TypeEqui_IndicateurEnv VALUES (null,null,5);


INSERT INTO IndicateurEnv VALUES('GES','effet de serre','CO2');
INSERT INTO TypeEquipement VALUES('Smartphone',5,'Utilisateur');
INSERT INTO TypeEqui_IndicateurEnv VALUES ('Smartphone','Ah',7);


INSERT INTO TypeEqui_IndicateurEnv VALUES ('autre','GES',5);


INSERT INTO TypeEqui_IndicateurEnv VALUES ('A','A',5);

--2)
INSERT INTO TypeEquipement VALUES('PC',6,'Utilisateur');
INSERT INTO Pays_A_TypeEquipement VALUES('Autre','Utilisateur',1);

INSERT INTO Pays_A_TypeEquipement VALUES('France','Autre',1);
/*
Résultat des erreurs :
--1)
Erreur commençant à la ligne: 78 de la commande -
INSERT INTO TypeEqui_IndicateurEnv VALUES ('Smartphone','Ah',7)
Rapport d'erreur -
ORA-02291: integrity constraint (MATEO.FK_TEI_INDICATEURENV) violated - parent key not found


Erreur commençant à la ligne: 81 de la commande -
INSERT INTO TypeEqui_IndicateurEnv VALUES ('autre','GES',5)
Rapport d'erreur -
ORA-02291: integrity constraint (MATEO.FK_INTITULE_TYPEEQUI) violated - parent key not found


Erreur commençant à la ligne: 84 de la commande -
INSERT INTO TypeEqui_IndicateurEnv VALUES ('A','A',5)
Rapport d'erreur -
ORA-02291: integrity constraint (MATEO.FK_TEI_INDICATEURENV) violated - parent key not found

--2)
Erreur commençant à la ligne: 88 de la commande -
INSERT INTO Pays_A_TypeEquipement VALUES('Autre','Utilisateur',1)
Rapport d'erreur -
ORA-02291: integrity constraint (MATEO.FK_PAYS_A_TYPEEQUI_TYPEEQUI) violated - parent key not found


Erreur commençant à la ligne: 90 de la commande -
INSERT INTO Pays_A_TypeEquipement VALUES('France','Autre',1)
Rapport d'erreur -
ORA-02291: integrity constraint (MATEO.FK_PAYS_A_TYPEEQUI_TYPEEQUI) violated - parent key not found
*/


-- CHECK de valeurs positives des attributs–
--1) 
INSERT INTO Pays_A_TypeEquipement VALUES('Amérique',-24);
--2) 
INSERT INTO Pays VALUES('Royaume-unis','Europe',-25,-35);

/*
Résultat des erreurs :

--1)
Erreur commençant à la ligne: 77 de la commande -
INSERT INTO Pays_A_TypeEquipement VALUES('AmÃ©rique',-24)
Rapport d'erreur -
ORA-02290: check constraint (MATEO.CK_NOMBREEQUIPOSITIF) violated

--2)
Erreur commençant à la ligne: 79 de la commande -
INSERT INTO Pays VALUES('Royaume-unis','Europe',-25,-35)
Rapport d'erreur -
ORA-02290: check constraint (MATEO.CK_PIBPOSITIF) violated
*/

-- CHECK de DOM de l’attribut regionDuMonde– 

INSERT INTO Pays VALUES('Royaume-unis','Rien',25,35);

/*
Résultat de l'erreur: 

Erreur commençant à la ligne: 98 de la commande -
INSERT INTO Pays VALUES('Royaume-unis','Rien',25,35)
Rapport d'erreur -
ORA-02290: check constraint (MATEO.CK_DOMREGIONDUMONDE) violated
*/

-- CHECK de DOM de l’attribut acronyme–

INSERT INTO IndicateurEnv VALUES('Rien','Riendutout',14);

/*
Résultat de l'erreur:

Erreur commençant à la ligne: 111 de la commande -
INSERT INTO IndicateurEnv VALUES('Rien','Riendutout',14)
Rapport d'erreur -
ORA-02290: check constraint (MATEO.CK_DOMINDICATEURENV) violated
*/


----------------Teste suplementaire--------------------

-- existence de la clé primaire– 

INSERT INTO IndicateurEnv VALUES(null,'effet de serre','CO2');
/*
Résultat : 

Erreur commençant à la ligne: 14 de la commande -
INSERT INTO IndicateurEnv VALUES(null,'effet de serre','CO2')
Rapport d'erreur -
ORA-01400: cannot insert NULL into ("ANTHONY"."INDICATEURENV"."ACRONYME")
*/

INSERT INTO Mesure VALUES(null,'Utilisateur','GES',2);
/*
Résultat : 

Erreur commençant à la ligne: 16 de la commande -
INSERT INTO Mesure VALUES(null,'Utilisateur','GES',2)
Rapport d'erreur -
ORA-01400: cannot insert NULL into ("ANTHONY"."MESURE"."UNPAYSMESURE")
*/

 -- unicité de la clé primaire (deux même valeur)

INSERT INTO IndicateurEnv VALUES('GES','effet de serre','CO2');
INSERT INTO IndicateurEnv VALUES('GES','bonjour','bonsoir');
/*
Résultat : 

INSERT INTO IndicateurEnv VALUES('GES','bonjour','bonsoir')
Rapport d'erreur -
ORA-00001: unique constraint (ANTHONY.PK_INDICATEURENV) violated
*/

INSERT INTO Mesure VALUES('France','Utilisateur','GES',2); 
INSERT INTO Mesure VALUES('France','Utilisateur','GES',2); 
/*
Résutat :

Erreur commençant à la ligne: 54 de la commande -
INSERT INTO Mesure VALUES('France','Utilisateur','GES',2)
Rapport d'erreur -
ORA-00001: unique constraint (ANTHONY.PK_MESURE) violated
*/


