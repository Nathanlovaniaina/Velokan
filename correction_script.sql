-- 1. Création de l'extension PostGIS
CREATE EXTENSION IF NOT EXISTS postgis;

-- 2. Création des tables
-- Table type_composant
CREATE TABLE type_composant(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

-- Table unite
CREATE TABLE unite (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    symbol VARCHAR(5)
);

-- Table plat
CREATE TABLE plat (
    id SERIAL PRIMARY KEY,
    intitule VARCHAR(100),
    prix INTEGER
);

-- Table composant
CREATE TABLE composant(
    id SERIAL PRIMARY KEY,
    id_type INTEGER REFERENCES type_composant(id) NOT NULL,
    nom VARCHAR(100),
    id_unite INTEGER REFERENCES unite(id) NOT NULL
);

-- Table details_plat
CREATE TABLE details_plat(
    id SERIAL PRIMARY KEY,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    quantite NUMERIC(10,2)
);

-- Table stock
CREATE TABLE stock (
    id SERIAL PRIMARY KEY,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    date_creation DATE,
    qtte_stock NUMERIC(10,2),
    nombre_jour_conservation INTEGER
);

-- Table mvt_stock
CREATE TABLE mvt_stock(
    id SERIAL PRIMARY KEY,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1)),
    quantite NUMERIC(10,2),
    date_mvt DATE NOT NULL,
    date_peremption DATE
);

-- Table entreprise
CREATE TABLE entreprise (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    adresse VARCHAR(100),
    latitude NUMERIC(10,2),
    longitude NUMERIC(10,2),
    geom geometry(Point, 4326),
    debut_date_contrat DATE
);

-- Table mvt_contrat
CREATE TABLE mvt_contrat(
    id SERIAL PRIMARY KEY,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1))
);

-- Table statut_livraison_commande
CREATE TABLE statut_livraison_commande (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(20)
);

-- Table commandes
CREATE TABLE commandes (
    id SERIAL PRIMARY KEY,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    prix_total INTEGER,
    date_heure_prevue TIMESTAMP
);

-- Table detail_commande
CREATE TABLE detail_commande(
    id SERIAL PRIMARY KEY,
    id_commande INTEGER REFERENCES commandes(id) NOT NULL,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    quantite INTEGER,
    prix_unitaire INTEGER
);

-- Table mvt_statut_livraison_commande
CREATE TABLE mvt_statut_livraison_commande(
    id SERIAL PRIMARY KEY,
    id_commande INTEGER REFERENCES commandes(id) NOT NULL,
    id_statut INTEGER REFERENCES statut_livraison_commande(id) NOT NULL,
    date_heure_modification TIMESTAMP
);

-- Table poste
CREATE TABLE poste (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50),
    salaire NUMERIC(10,2)
);

-- Table historique_salaire
CREATE TABLE historique_salaire (
    id SERIAL PRIMARY KEY,
    id_poste INTEGER REFERENCES poste(id) NOT NULL,
    date_modification DATE,
    nouveau_salaire NUMERIC(10,2)
);

-- Table employe
CREATE TABLE employe (
    id SERIAL PRIMARY KEY,
    id_poste INTEGER REFERENCES poste(id) NOT NULL,
    num_identification VARCHAR(10),
    nom VARCHAR(30),
    prenom VARCHAR(30),
    date_naissance DATE,
    contact VARCHAR(20),
    date_embauche DATE NOT NULL
);

-- Table presence
CREATE TABLE presence(
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe(id) NOT NULL,
    date_pres DATE
);

-- Table tache
CREATE TABLE tache(
    id SERIAL PRIMARY KEY,
    nom VARCHAR(30)
);

-- Table statut_tache
CREATE TABLE statut_tache (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

-- Table distribution_tache
CREATE TABLE distribution_tache (
    id SERIAL PRIMARY KEY,
    id_tache INTEGER REFERENCES tache(id) NOT NULL,
    id_emp INTEGER REFERENCES employe(id) NOT NULL,
    id_commande INTEGER REFERENCES commandes(id) NOT NULL,
    date_tache DATE
);

-- Table mvt_statut_tache
CREATE TABLE mvt_statut_tache (
    id SERIAL PRIMARY KEY,
    id_distribution_tache INTEGER REFERENCES distribution_tache(id),
    date_heure_modification TIMESTAMP,
    id_statut INTEGER REFERENCES statut_tache(id)
);

-- Table mvt_employe
CREATE TABLE mvt_employe(
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe(id) NOT NULL,
    type_mvt INTEGER CHECK (type_mvt IN (0, 1)),
    date_mvt DATE
);

-- Table penalite
CREATE TABLE penalite(
    id SERIAL PRIMARY KEY,
    nb_jour INTEGER
);

-- Table paiement_salaire
CREATE TABLE paiement_salaire (
    id SERIAL PRIMARY KEY,
    id_emp INTEGER REFERENCES employe(id) NOT NULL,
    date_paie DATE NOT NULL,
    somme NUMERIC(10,2)
);

-- Table facture
CREATE TABLE facture (
    id SERIAL PRIMARY KEY,
    id_commandes INTEGER REFERENCES commandes(id) NOT NULL,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    date_emission DATE DEFAULT CURRENT_DATE,
    date_paiement DATE,
    montant_total NUMERIC(10,2),
    statut VARCHAR(20) CHECK (statut IN ('En attente', 'Payé', 'En retard', 'Annulé')),
    reference_paiement VARCHAR(50) 
);

-- Table paiement_entreprise
CREATE TABLE paiement_entreprise (
    id SERIAL PRIMARY KEY,
    id_facture INTEGER REFERENCES facture(id) NOT NULL,
    montant NUMERIC(10,2) NOT NULL,
    date_paiement DATE NOT NULL,
    mode_paiement VARCHAR(50)
);

-- 3. Peuplement des tables
-- Table type_composant
INSERT INTO type_composant (nom) VALUES 
('Légume'), 
('Viande'), 
('Épice');

-- Table unite
INSERT INTO unite (nom, symbol) VALUES 
('Kilogramme', 'kg'),
('Litre', 'l'),
('Pièce', 'pc');

-- Table composant
INSERT INTO composant (id_type, nom, id_unite) VALUES 
(1, 'Carotte', 1),
(2, 'Poulet', 1),
(3, 'Sel', 1);

-- Table plat
INSERT INTO plat (intitule, prix) VALUES 
('Riz Poulet', 10000), 
('Soupe de légumes', 8000);

-- Table details_plat
INSERT INTO details_plat (id_plat, id_composant, quantite) VALUES 
(1, 1, 0.2),
(1, 2, 0.3),
(1, 3, 0.01),
(2, 1, 0.5),
(2, 3, 0.01);

-- Table stock
INSERT INTO stock (id_composant, date_creation, qtte_stock, nombre_jour_conservation) VALUES 
(1, '2025-06-20', 50, 11),
(2, '2025-06-20', 20, 10),
(3, '2025-06-20', 5, 365);

-- Table mvt_stock
INSERT INTO mvt_stock (id_composant, type_mvt, quantite, date_mvt, date_peremption) VALUES 
(1, 0, 10, '2025-06-21', '2025-07-01'),
(1, 1, 2, '2025-06-22', '2025-07-02'),
(2, 0, 5, '2025-06-21', '2025-06-30');

-- Table entreprise
INSERT INTO entreprise (nom, adresse, latitude, longitude, geom, debut_date_contrat) VALUES 
('Orange', 'Zone Galaxy', -18.8792, 47.5079, ST_SetSRID(ST_MakePoint(47.5079, -18.8792), 4326), '2025-01-01'),
('Canal+', 'Analakely', -18.9101, 47.5260, ST_SetSRID(ST_MakePoint(47.5260, -18.9101), 4326), '2025-02-01');

-- Table mvt_contrat
INSERT INTO mvt_contrat (id_entreprise, type_mvt) VALUES 
(1, 0),
(2, 0);

-- Table statut_livraison_commande
INSERT INTO statut_livraison_commande (nom) VALUES 
('Prêt'),
('En cours'),
('Livré');

-- Table commandes
INSERT INTO commandes (id_entreprise, prix_total, date_heure_prevue) VALUES 
(1, 200000, '2025-06-25 11:00:00'),
(2, 80000, '2025-06-25 12:00:00');

-- Table detail_commande
INSERT INTO detail_commande (id_commande, id_plat, quantite, prix_unitaire) VALUES 
(1, 1, 20, 10000),
(1, 2, 5, 8000),
(2, 2, 10, 8000);

-- Table poste
INSERT INTO poste (nom, salaire) VALUES 
('Cuisinier', 500000),
('Livreur', 350000);

-- Table historique_salaire
INSERT INTO historique_salaire (id_poste, date_modification, nouveau_salaire) VALUES 
(1, '2025-06-01', 500000),
(2, '2025-06-01', 350000);

-- Table employe
INSERT INTO employe (id_poste, num_identification, nom, prenom, date_naissance, contact, date_embauche) VALUES 
(1, 'EMP001', 'Rakoto', 'Jean', '1990-05-10', '0321234567', '2023-01-15'),
(2, 'EMP002', 'Randria', 'Paul', '1992-08-20', '0337654321', '2024-02-20');

-- Table presence
INSERT INTO presence (id_emp, date_pres) VALUES 
(1, '2025-06-25'),
(2, '2025-06-25');

-- Table tache
INSERT INTO tache (nom) VALUES 
('Préparer riz'),
('Livrer commande');

-- Table statut_tache
INSERT INTO statut_tache (nom) VALUES 
('Non démarrée'),
('En cours'),
('Terminée');

-- Table distribution_tache
INSERT INTO distribution_tache (id_tache, id_emp, id_commande, date_tache) VALUES 
(1, 1, 1, '2025-06-25'),
(2, 2, 1, '2025-06-25');

-- Table mvt_statut_tache
INSERT INTO mvt_statut_tache (id_distribution_tache, date_heure_modification, id_statut) VALUES 
(1, '2025-06-25 09:00:00', 1),
(1, '2025-06-25 10:00:00', 3);

-- Table mvt_employe
INSERT INTO mvt_employe (id_emp, type_mvt, date_mvt) VALUES 
(1, 0, '2023-01-15'),
(2, 0, '2024-02-20');

-- Table penalite
INSERT INTO penalite (nb_jour) VALUES 
(3),
(5);

-- Table paiement_salaire
INSERT INTO paiement_salaire (id_emp, date_paie, somme) VALUES 
(1, '2025-06-25', 500000),
(2, '2025-06-25', 350000);

-- Table facture
INSERT INTO facture (id_commandes, id_entreprise, date_emission, date_paiement, montant_total, statut, reference_paiement) VALUES 
(1, 1, '2025-06-25', '2025-06-25', 200000, 'Payé', 'VIR123456'),
(2, 2, '2025-06-25', NULL, 80000, 'En attente', NULL);

-- Table paiement_entreprise
INSERT INTO paiement_entreprise (id_facture, montant, date_paiement, mode_paiement) VALUES 
(1, 200000, '2025-06-25', 'Virement bancaire');


ALTER TABLE details_plat
DROP CONSTRAINT details_plat_id_plat_fkey;

ALTER TABLE details_plat
ADD CONSTRAINT details_plat_id_plat_fkey
FOREIGN KEY (id_plat)
REFERENCES plat(id)
ON DELETE CASCADE;
