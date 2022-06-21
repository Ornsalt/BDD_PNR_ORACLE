------------MATEO FLEJOU / ANTHONY HASCOET-------------------

-------------------------------------------------------------
----------SAE implantation SQL et manipulation---------------
-------------------------------------------------------------

-- Voici le jeu de donnée utilisée : 

DELETE FROM Mesure;
DELETE FROM TypeEqui_IndicateurEnv;
DELETE FROM Pays_A_TypeEquipement ;
DELETE FROM IndicateurEnv ;
DELETE FROM TypeEquipement ;
DELETE FROM Domaine;
DELETE FROM Pays;

INSERT INTO Pays VALUES('France','Europe',67,2.603); 
INSERT INTO Pays VALUES('Royaume-unis','Europe',67,2.708); 
INSERT INTO Pays VALUES('USA','Amerique du Sud',329,20.94); 
INSERT INTO Pays VALUES('Inde','Asie',1380,2.623); 
INSERT INTO Pays VALUES('Canada','Amerique du Nord',38.1,1.643); 


INSERT INTO Domaine VALUES('Utilisateur');
INSERT INTO Domaine VALUES('Reseau');
INSERT INTO Domaine VALUES('Data center');

INSERT INTO TypeEquipement VALUES('Smartphone',5,'Utilisateur');
INSERT INTO TypeEquipement VALUES('Rack',20,'Data center');
INSERT INTO TypeEquipement VALUES('Serveur',5,'Reseau');
INSERT INTO TypeEquipement VALUES('PC',7,'Utilisateur');

INSERT INTO IndicateurEnv VALUES('GES','effet de serre','CO2');
INSERT INTO IndicateurEnv VALUES('ADP','epuisement ressource',null);
INSERT INTO IndicateurEnv VALUES('BEP','Bilan energetique',null);
INSERT INTO IndicateurEnv VALUES('EAU','Tension sur eau','L/cube');
INSERT INTO IndicateurEnv VALUES('ELEC','électrique','GW/H');

INSERT INTO Pays_A_TypeEquipement VALUES('France','Smartphone',100);
INSERT INTO Pays_A_TypeEquipement VALUES('USA','Serveur',600);
INSERT INTO Pays_A_TypeEquipement VALUES('Inde','Rack',300);
INSERT INTO Pays_A_TypeEquipement VALUES('Canada','PC',5000);

INSERT INTO TypeEqui_IndicateurEnv VALUES('Smartphone','GES',10);
INSERT INTO TypeEqui_IndicateurEnv VALUES('Smartphone','BEP',50);
INSERT INTO TypeEqui_IndicateurEnv VALUES('Rack','ADP',2);
INSERT INTO TypeEqui_IndicateurEnv VALUES('Serveur','ELEC',30);
INSERT INTO TypeEqui_IndicateurEnv VALUES('PC','EAU',34);

INSERT INTO Mesure VALUES('France','Utilisateur','GES',2);
INSERT INTO Mesure VALUES('Inde','Data center','EAU',10);
INSERT INTO Mesure VALUES('USA','Reseau','ELEC',20);
INSERT INTO Mesure VALUES('Canada','Utilisateur','BEP',25);

-- Requête SQL -- 


-- Requête : projection avec restriction 

-- 1 ) 

-- Question - Quelle sont les pays en europe ? 

-- Algébrique relationnelle : 

-- Pays{regionDuMonde = 'EUROPE'} [nomPays]

SELECT UPPER (nomPays) 
FROM Pays
WHERE  regionDuMonde = 'Europe' ;

/*
Résultat  : 

UPPER(NOMPAYS)      
--------------------
FRANCE
ROYAUME-UNIS
*/

-- 2 ) 

-- Question : Quelle est l'indicateur envirommentale qui à pour unite 'CO2' ?

-- Algébrique relationnelle :

-- IndicateurEnv{unite = 'CO2'} [acronyme,intituleIndicateurEnv]

-- SQL : 

SELECT UPPER (acronyme),UPPER(intituleIndicateurEnv)
FROM IndicateurEnv
WHERE unite = 'CO2' ; 

/*
Resultat : 

UPPER(ACRONYME)      UPPER(INTITULEINDICA
-------------------- --------------------
GES                  EFFET DE SERRE     
*/

-- Requete : union ou intersection ou difference ensembliste

-- 1 )

-- Question : Quelle equipement ont pour indicateur environemental BEP et GES ?

-- Algébrique relationnelle : 

-- TypeEqui_IndicateurEnv{unIndicaEnvTEI = 'BEP' et unIndicaEnvTEI = 'GES'} [unTypeEquipement]

SELECT UPPER (unTypeEquipement) 
FROM TypeEqui_IndicateurEnv
WHERE  unIndicaEnvTEI = 'BEP'
INTERSECT
SELECT UPPER (unTypeEquipement) 
FROM TypeEqui_IndicateurEnv
WHERE  unIndicaEnvTEI = 'GES'; 

/*
Résultat  : 

UPPER(UNTYPEEQUIPEMENT)
--------------------
SMARTPHONE
*/

-- 2 )

-- Question : Quelle sont les pays qui ont comme mesure le domaine utilisateur et datacenter ?

-- Algébrique relationnelle : 

-- Mesure{unDomaine ='Utilisateur' ou unDomaine ='Data center'} [unPaysMesure]

SELECT UPPER (unPaysMesure) 
FROM Mesure
WHERE  unDomaine ='Utilisateur'
UNION
SELECT UPPER (unPaysMesure) 
FROM Mesure
WHERE  unDomaine ='Data center'; 

/*
Résultat  : 

UPPER(UNPAYSMESURE) 
--------------------
CANADA
FRANCE
INDE
*/


-- Requête : jointure de 2 tables 

-- Question : Quelle sont les equipements utilise en amerique du sud ?

-- Algébrique relationnelle : 

-- Pays[[  nomPays = unPaysEquipement ]] Pays_A_TypeEquipement{regionDuMonde = 'Amerique du Sud'} [unTypeEquipement]

SELECT UPPER(unTypeEquipement)
FROM Pays,Pays_A_TypeEquipement
WHERE  nomPays = unPaysEquipement 
	AND regionDuMonde = 'Amerique du Sud' ;

/*
Résultat : 

UPPER(UNTYPEEQUIPEME
--------------------
SERVEUR
*/

-- 2 )

-- Question : Quelles sont les indicateurs environementaux des pays qui ont pour domaine Utilisateur ?

-- Algébrique relationnelle : 

-- Pays[[ nomPays = unPaysEquipement ]] Mesure{unDomaine = 'Utilisateur'} [unIndicateurEnv]

SELECT UPPER(unIndicateurEnv)
FROM Pays,Mesure
WHERE  nomPays = unPaysMesure
    AND unDomaine = 'Utilisateur' ; 

/*
Résultat  : 

UPPER(UNTYPEEQUIPEME
--------------------
SMARTPHONE
*/

-- Requête : jointure de 3 tables

-- Question : Dans domaine de l'utilisateur , Quelle sont les pays qui intervienne dans ce domaine ? affiche leur region, leur equipement et leur nombre.

-- Algébrique relationnelle :  

-- Pays[[ unPaysEquipement = nomPays AND intituleTypeEquipement = unTypeEquipement ]]TypeEquipement{LeDomaine = 'Utilisateur'} [nomPays,regionDuMonde,intituleTypeEquipement,nombreEquipement]

SELECT UPPER (nomPays), UPPER(regionDuMonde), UPPER (intituleTypeEquipement), UPPER(nombreEquipement)
FROM Pays,TypeEquipement,Pays_A_TypeEquipement
WHERE  unPaysEquipement = nomPays 
	AND intituleTypeEquipement = unTypeEquipement
	AND LeDomaine = 'Utilisateur';

/*
Résultat  : 

UPPER(NOMPAYS)       UPPER(REGIONDUMONDE) UPPER(INTITULETYPEEQ
-------------------- -------------------- --------------------
FRANCE               EUROPE               SMARTPHONE          
CANADA               AMERIQUE DU NORD     PC                  

*/

-- Requête : auto-jointure 

-- Question : Quelle pays a plus d'habitant que la France ?

-- Algébrique relationnel : 

-- Pays P1[[ P1.nomPays = 'France']]Pays P2{ P2.nomPays != 'France' AND P1.nbHab < P2.nbHab}

SELECT UPPER(P2.nomPays)
FROM Pays P1,Pays P2
WHERE P1.nomPays = 'France'
AND P2.nomPays != 'France'
	AND P1.nbHab < P2.nbHab; 
	
/*
Résultat 
UPPER(P2.NOMPAYS)   
--------------------
USA
INDE
*/	
	

-- Requête : tri avec restriction

-- Question : dans ordre Décroissant , quelle sont les pays avec un PIB supérieur a 2 ?

-- Algrébrique relationnel : 

-- Pays{pib > 2 AND ORDER BY pib} [nomPays,pib]

SELECT UPPER (nomPays) , pib
FROM Pays
WHERE  pib > 2
ORDER BY pib DESC ;

/*
Résultat : 

UPPER(NOMPAYS)              PIB
-------------------- ----------
USA                       20,94
ROYAUME-UNIS              2,708
INDE                      2,623
FRANCE                    2,603
*/

-- Requête : tri et ROWNUM 

-- Question : Dans l'ordre alphabétique, Quelle sont les trois premiéres lignes de la table "Pays" ? 

-- Algrébrique relationnel : 

-- Pays{ORDER BY (nomPays) AND ROWNUM <= 2 }[nomPays,regionDuMonde]


SELECT * 
FROM(
		SELECT UPPER(nomPays) ,UPPER(regionDuMonde),pib,nbHab
		FROM Pays
		ORDER BY nomPays
	)
WHERE ROWNUM <= 3 ;

/*
Resultat : 

UPPER(NOMPAYS)       UPPER(REGIONDUMONDE)        PIB      NBHAB
-------------------- -------------------- ---------- ----------
CANADA               AMERIQUE DU NORD          1,643       38,1
FRANCE               EUROPE                    2,603         67
*/

-- Requête : test des valeurs (avec IN ou NOT IN) 

-- 1 )

-- Question : Quelles sont les pays qui ont comme domaine Utilisateur et Data center

-- Algébrique relationnelle : 

-- Mesure{unDomaine = 'utilisateur ou unDomaine = 'Data center'} [unPaysMesure]

SELECT UPPER(unPaysMesure)
FROM Mesure
WHERE unDomaine IN ('Utilisateur', 'Data center'); 

/*
Résultat  : 

UPPER(UNPAYSMESURE) 
--------------------
FRANCE
INDE
CANADA
*/

-- 2 )

-- Question : Quelles sont les pays qui n'ont pas comme domaine Utilisateur et Data center

-- Algébrique relationnelle : 

-- Mesure{unDomaine != 'utilisateur et unDomaine != 'Data center'} [unPaysMesure]

SELECT UPPER(unPaysMesure)
FROM Mesure
WHERE unDomaine NOT IN ('Utilisateur', 'Data center'); 

/*
Résultat  : 

UPPER(UNPAYSMESURE) 
--------------------
USA
*/

-- Requete : test des valeurs (avec IN ou NOT IN)

-- 1 )

-- Question : Quelles sont les indicateurs environnementaux qui ont une unité ?

-- Algébrique relationnelle : 

-- IndicateurEnv{NOT EXISTS(unite = null)} [acronyme]

SELECT UPPER(P1.acronyme)
FROM IndicateurEnv P1
WHERE EXISTS ( SELECT unite
               FROM IndicateurEnv
               WHERE P1.unite IS NULL
             );

/*
Résultat  : 

UPPER(P1.ACRONYME)  
--------------------
ADP
BEP
*/

-- 2 ) 

-- Question : Quelles sont les indicateurs environnementaux qui n'ont pas une unité ? 

-- Algébrique relationnelle : 

-- IndicateurEnv{NOT EXISTS(unite = null)} [acronyme]

SELECT UPPER(P1.acronyme)
FROM IndicateurEnv P1
WHERE NOT EXISTS ( SELECT unite
				   FROM IndicateurEnv
                   WHERE P1.unite IS NULL
                 );

/*
Résultat  : 

UPPER(P1.ACRONYME)  
--------------------
GES
EAU
ELEC
*/
