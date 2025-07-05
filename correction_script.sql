CREATE DATABASE velonkan;

\c velonkan;

CREATE TABLE plat (
    id SERIAL PRIMARY KEY,
    intitule VARCHAR (100),
    prix INTEGER
);

CREATE TABLE type_composant(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

CREATE TABLE unite (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    symbol VARCHAR(5)
);

CREATE TABLE composant(
    id SERIAL PRIMARY KEY,
    id_type INTEGER REFERENCES type_composant (id) NOT NULL,
    nom VARCHAR(100),
    id_unite INTEGER REFERENCES unite(id) NOT NULL
);

--recette
CREATE TABLE details_plat(
    id SERIAL PRIMARY KEY,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    quantite NUMERIC (10,2)
);

CREATE TABLE stock (
    id SERIAL PRIMARY KEY,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    date_creation DATE,
    qtte_stock NUMERIC(10,2),
    nombre_jour_conservation INTEGER
);

CREATE TABLE mvt_stock(
    id SERIAL PRIMARY KEY,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1)),
    quantite NUMERIC (10,2),
    date_mvt DATE NOT NULL,
    date_peremption DATE
);

CREATE TABLE entreprise (
    id SERIAL PRIMARY KEY,
    nom VARCHAR (100),
    adresse VARCHAR (100),
    latitude NUMERIC (10,2),
    longitude NUMERIC(10,2),
    -- geom geometry(Point, 4326),
    debut_date_contrat DATE
);

CREATE TABLE mvt_contrat(
    id SERIAL PRIMARY KEY,
    id_entreprise INTEGER REFERENCES entreprise (id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1))
);

--Statuts livraison : pret a etre livre , en cours le livraison, livre

CREATE TABLE statut_livraison_commande (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(20)
);

CREATE TABLE commandes (
    id SERIAL PRIMARY KEY,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    prix_total INTEGER,
    date_heure_prevue TIMESTAMP
);

CREATE TABLE detail_commande(
    id SERIAL PRIMARY KEY,
    id_commande INTEGER REFERENCES commandes(id) NOT NULL,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    quantite INTEGER,
    prix_unitaire INTEGER
);

CREATE TABLE mvt_statut_livraison_commande(
    id SERIAL PRIMARY KEY,
    id_commande INTEGER REFERENCES commandes(id) NOT NULL,
    -- id_statut INTEGER REFERENCES statut_commande(id) NOT NULL,
    date_heure_modification TIMESTAMP
);


CREATE TABLE poste (
    id SERIAL PRIMARY KEY,
    nom VARCHAR (50),
    salaire NUMERIC (10,2)
);

CREATE TABLE historique_salaire (
    id SERIAL PRIMARY KEY,
    id_poste INTEGER REFERENCES poste (id) NOT NULL,
    date_modification DATE,
    nouveau_salaire NUMERIC (10,2)
);

CREATE TABLE employe (
    id SERIAL PRIMARY KEY,
    id_poste INTEGER REFERENCES poste(id) NOT NULL,
    num_identification VARCHAR (10),
    nom VARCHAR (30),
    prenom VARCHAR (30),
    date_naissance DATE,
    contact VARCHAR (20),
    date_embauche DATE NOT NULL
);

--date default actuelle
CREATE TABLE presence(
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe(id) NOT NULL,
    date_pres DATE
);

CREATE TABLE tache(
    id SERIAL PRIMARY KEY,
    nom VARCHAR (30)
);

CREATE TABLE  statut_tache (
    id SERIAL PRIMARY KEY,
    nom VARCHAR (50)
);


CREATE TABLE distribution_tache (
    id SERIAL PRIMARY KEY,
    id_tache INTEGER REFERENCES tache (id) NOT NULL,
    id_emp INTEGER REFERENCES employe (id) NOT NULL,
    id_plat INTEGER REFERENCES commandes(id) NOT NULL,
    date_tache DATE
);

CREATE TABLE mvt_statut_tache (
    id SERIAL PRIMARY KEY,
    id_distribution_tache INTEGER REFERENCES distribution_tache(id),
    date_heure_modification TIMESTAMP,
    statut INTEGER REFERENCES statut_tache(id)
);

CREATE TABLE mvt_employe(
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe (id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1)),
    date_mvt DATE
);

CREATE TABLE penalite(
    id SERIAL PRIMARY KEY,
    nb_jour INTEGER
);

CREATE TABLE paiement_salaire (
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe (id) NOT NULL,
    date_paie DATE NOT NULL,
    somme NUMERIC (10,2)
);

-- 1. Table "Facture" pour regrouper les commandes payées par l'entreprise
CREATE TABLE facture (
    id SERIAL PRIMARY KEY,
    id_commandes INTEGER REFERENCES commandes (id) NOT NULL,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    date_emission DATE DEFAULT CURRENT_DATE,
    date_paiement DATE,
    montant_total NUMERIC(10,2),
    statut VARCHAR(20) CHECK (statut IN ('En attente', 'Paye', 'En retard', 'Annule')),
    reference_paiement VARCHAR(50) 
);


-- 3. Historique des paiements entreprise (pour traçabilité)
CREATE TABLE paiement_entreprise (
    id SERIAL PRIMARY KEY,
    id_facture INTEGER REFERENCES facture(id) NOT NULL,
    montant NUMERIC(10,2) NOT NULL,
    date_paiement DATE NOT NULL,
    mode_paiement VARCHAR(50)
);



INSERT INTO plat (intitule, prix) VALUES
('Henankisoa sy Tsaramaso', 5000),
('Akoho', 1200),
('Henanomby', 800);

INSERT INTO entreprise (nom, adresse, latitude, longitude, debut_date_contrat) VALUES
('Orange Madagascar', '123 Rue Principale, Antananarivo', -18.91, 47.53, '2025-01-01'),
('Foodie SARL', '45 Avenue de l''Indépendance, Toamasina', -18.15, 49.40, '2024-06-15'),
('Cantine Express', 'Lot II A Andraharo, Antananarivo', -18.87, 47.51, '2025-03-01');


INSERT INTO commandes (id_entreprise, date_heure_prevue) VALUES
(1, '2025-06-25 11:30:00'), -- Orange Madagascar
(2, '2025-06-26 12:00:00'), -- Foodie SARL
(3, '2025-06-27 13:00:00'); -- Cantine Express
(2, '2025-06-30 13:00:00'); -- Cantine Express


INSERT INTO detail_commande (id_commande, id_plat, quantite, prix_unitaire) VALUES
(5, 1, 14, 5000), -- Commande 1: Henankisoa sy Tsaramaso (14*5000 = 70000)
(6, 2, 20, 8000),
(7, 2, 30, 6000),
(10, 3, 10, 4000);
