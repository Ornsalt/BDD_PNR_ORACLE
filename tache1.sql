------------MATEO FLEJOU / ANTHONY HASCOET-------------------

-------------------------------------------------------------
----------SAE implantation SQL et manipulation---------------
-------------------------------------------------------------


DROP TABLE Mesure;
DROP TABLE TypeEqui_IndicateurEnv;
DROP TABLE Pays_A_TypeEquipement ;
DROP TABLE IndicateurEnv ;
DROP TABLE TypeEquipement ;
DROP TABLE Domaine;
DROP TABLE Pays ;

CREATE TABLE Pays (

	 nomPays VARCHAR(20)
	
		CONSTRAINT pk_Pays PRIMARY KEY,
		
	 regionDuMonde VARCHAR(20)
	
		CONSTRAINT nn_Pays NOT NULL,
		
		CONSTRAINT ck_DomregionDuMonde CHECK (regionDuMonde IN ('Afrique', 'Amerique du Nord', 'Amerique du Sud', 'Antarctique', 'Asie', 'Europe', 'Oceanie')), 
		
	 nbHab NUMBER
	 
		CONSTRAINT ck_nbHabPositif CHECK (nbHab > 0),	
	
	 pib NUMBER
	 
		CONSTRAINT ck_pibPositif CHECK (pib > 0)
);

CREATE TABLE Domaine (

	intituleDomaine VARCHAR(20)
	
		CONSTRAINT pk_Domaine PRIMARY KEY
		
		CONSTRAINT ck_DomDomaine CHECK (intituleDomaine IN ('Utilisateur', 'Reseau', 'Data center'))
		
);

CREATE TABLE TypeEquipement (

	intituleTypeEquipement VARCHAR(20)
	
		CONSTRAINT pk_TypeEquipement PRIMARY KEY,
	
	dureeVie NUMBER 
	
		CONSTRAINT nn_dureeVie NOT NULL
		
		CONSTRAINT ck_dureeViePositif CHECK (dureeVie > 0),
	
	leDomaine VARCHAR(20)
	
		CONSTRAINT fk_typeEquipement_Domaine_ REFERENCES Domaine(intituleDomaine)
	
		CONSTRAINT nn_leDomaine NOT NULL

); 

CREATE TABLE IndicateurEnv  (

	acronyme VARCHAR(20)
	
		CONSTRAINT pk_IndicateurEnv  PRIMARY KEY
		
		CONSTRAINT ck_DomIndicateurEnv CHECK (acronyme IN ('GES', 'BEP', 'ADP', 'EAU', 'ELEC')),
		
	intituleIndicateurEnv VARCHAR(20),
		
	unite VARCHAR(20)
		
		
);

CREATE TABLE Pays_A_TypeEquipement (

	unPaysEquipement VARCHAR(20)
		
	
		CONSTRAINT fk_Pays_A_TypeEquipement_Pays REFERENCES Pays(nomPays),
		
	unTypeEquipement VARCHAR(20) 
	
		
		CONSTRAINT fk_Pays_A_TypeEqui_TypeEqui REFERENCES TypeEquipement(intituleTypeEquipement),
		
	nombreEquipement NUMBER
	
		CONSTRAINT ck_nombreEquiPositif CHECK (nombreEquipement > 0),
		
		--Contraite table-- 
		
	CONSTRAINT pk_Pays_A_TypeEquipement PRIMARY KEY (unPaysEquipement, unTypeEquipement)
);

CREATE TABLE TypeEqui_IndicateurEnv(

	unTypeEquipement VARCHAR(20) 
			
		CONSTRAINT fk_intitule_TypeEqui REFERENCES TypeEquipement(intituleTypeEquipement),

	unIndicaEnvTEI VARCHAR(20) 											--TEI = Type Equipement indicateurEnv
		
		CONSTRAINT fk_TEI_indicateurEnv REFERENCES IndicateurEnv(acronyme),
	
	valeurUnitaire NUMBER
		
		CONSTRAINT ck_valeurUniPositif CHECK (valeurUnitaire > 0),
	
	--Contraite table-- 

	CONSTRAINT pk_TypeEqui_IndicateurEnv PRIMARY KEY (unTypeEquipement, unIndicaEnvTEI)
);

CREATE TABLE Mesure (

	unPaysMesure VARCHAR(20) 
			
				
			CONSTRAINT fk_Mesure_Pays REFERENCES Pays(nomPays),

	unDomaine VARCHAR(20) 
				
			
			CONSTRAINT fk_Mesure_Domaine REFERENCES Domaine(intituleDomaine),
	
	unIndicateurEnv VARCHAR(20) 
					
				
			CONSTRAINT fk_Mesure_IndicaEnvAcronyme REFERENCES IndicateurEnv(acronyme),


	valeur NUMBER
	
	CONSTRAINT ck_valeurPositif CHECK (valeur > 0),
	
	--Contraite table-- 
	
	CONSTRAINT pk_Mesure PRIMARY KEY (unPaysMesure, unDomaine, unIndicateurEnv)
	

);

