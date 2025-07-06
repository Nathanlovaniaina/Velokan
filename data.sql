-- Insertion des types de composants
INSERT INTO type_composant (nom) VALUES ('Viande'), ('Légume'), ('Épice');

-- Insertion des unités
INSERT INTO unite (nom, symbol) VALUES ('Kilogramme', 'Kg'), ('Litre', 'L'), ('Pièce', 'Pce');

-- Insertion des composants
INSERT INTO composant (id_type, nom, id_unite) VALUES 
(1, 'Poulet', 1),
(2, 'Carotte', 1),
(3, 'Poivre', 1);

-- Insertion des plats
INSERT INTO plat (intitule, prix, date_creation) VALUES 
('Poulet Rôti', 15000, CURRENT_DATE),
('Ragoût de légumes', 12000, CURRENT_DATE);

-- Insertion des détails de plat (recettes)
INSERT INTO details_plat (id_plat, id_composant, quantite) VALUES 
(1, 1, 1.5),
(1, 3, 0.05),
(2, 2, 0.8),
(2, 3, 0.03);

-- Insertion des stocks
INSERT INTO stock (id_composant, date_creation, qtte_stock, nombre_jour_conservation) VALUES 
(1, CURRENT_DATE, 50, 5),
(2, CURRENT_DATE, 100, 7),
(3, CURRENT_DATE, 20, 365);

-- Insertion des mouvements de stock
INSERT INTO mvt_stock (id_composant, type_mvt, quantite, date_mvt, prix_unitaire, date_peremption) VALUES 
(1, 0, 20, CURRENT_DATE, 8000, CURRENT_DATE + INTERVAL '5 day'),
(2, 0, 50, CURRENT_DATE, 2000, CURRENT_DATE + INTERVAL '7 day');

-- Insertion des entreprises
INSERT INTO entreprise (nom, adresse, latitude, longitude, geom, debut_date_contrat, quartier) VALUES 
('Société A', 'Zone Industrielle', -18.8792, 47.5079, ST_SetSRID(ST_MakePoint(47.5079, -18.8792), 4326), CURRENT_DATE, 'Analakely'),
('Société B', 'Tanjombato', -18.9200, 47.5300, ST_SetSRID(ST_MakePoint(47.5300, -18.9200), 4326), CURRENT_DATE, 'Tanjombato');

-- Insertion des mouvements de contrat
INSERT INTO mvt_contrat (id_entreprise, type_mvt, date_mvt) VALUES 
(1, 0, CURRENT_DATE),
(2, 0, CURRENT_DATE);

-- Insertion des statuts de livraison commande
INSERT INTO statut_livraison_commande (nom) VALUES 
('Prêt à être livré'), 
('En cours de livraison'),
('Livré');

-- Insertion des commandes
INSERT INTO commandes (id_entreprise, prix_total, date_heure_prevue) VALUES 
(1, 30000, CURRENT_TIMESTAMP + INTERVAL '2 hour'),
(2, 15000, CURRENT_TIMESTAMP + INTERVAL '3 hour');

-- Insertion des détails commandes
INSERT INTO detail_commande (id_commande, id_plat, quantite, prix_unitaire) VALUES 
(1, 1, 2, 15000),
(2, 2, 1, 12000);

-- Insertion des mouvements de statut livraison
INSERT INTO mvt_statut_livraison_commande (id_commande, id_statut, date_heure_modification) VALUES 
(1, 1, CURRENT_TIMESTAMP),
(2, 1, CURRENT_TIMESTAMP);

-- Insertion des postes
INSERT INTO poste (nom, salaire) VALUES 
('Cuisinier', 500000),
('Livreur', 400000);

-- Insertion des historiques de salaire
INSERT INTO historique_salaire (id_poste, date_modification, nouveau_salaire) VALUES 
(1, CURRENT_DATE, 500000),
(2, CURRENT_DATE, 400000);

-- Insertion des employés
INSERT INTO employe (id_poste, num_identification, nom, prenom, date_naissance, contact, date_embauche) VALUES 
(1, 'EMP001', 'Rakoto', 'Jean', '1990-06-15', '0341234567', CURRENT_DATE),
(2, 'EMP002', 'Rasoa', 'Clara', '1988-12-20', '0347654321', CURRENT_DATE);

-- Insertion des présences
INSERT INTO presence (id_emp) VALUES (1), (2);

-- Insertion des tâches
INSERT INTO tache (nom) VALUES ('Préparation'), ('Livraison');

-- Insertion des statuts tâches
INSERT INTO statut_tache (nom, est_lie_plat) VALUES ('En cours', 1), ('Terminée', 1);

-- Insertion des tâches liées aux plats
INSERT INTO taches_plat (id_plat, nom, ordre) VALUES 
(1, 'Découpe', 1),
(1, 'Cuisson', 2);

-- Insertion des distributions de tâche
INSERT INTO distribution_tache (id_tache_plat, id_emp, date_tache) VALUES 
(1, 1, CURRENT_DATE),
(2, 1, CURRENT_DATE);

-- Insertion des mouvements de statut de tâche
INSERT INTO mvt_statut_tache (id_distribution_tache, date_heure_modification, statut) VALUES 
(1, CURRENT_TIMESTAMP, 1),
(2, CURRENT_TIMESTAMP, 1);

-- Insertion des mouvements employés
INSERT INTO mvt_employe (id_emp, type_mvt, date_mvt) VALUES 
(1, 0, CURRENT_DATE),
(2, 0, CURRENT_DATE);

-- Insertion des pénalités
INSERT INTO penalite (nb_jour) VALUES (2), (3);

-- Insertion des paiements salaires
INSERT INTO paiement_salaire (id_emp, date_paie, somme) VALUES 
(1, CURRENT_DATE, 500000),
(2, CURRENT_DATE, 400000);

-- Insertion des factures
INSERT INTO facture (id_commandes, id_entreprise, date_paiement, montant_total, statut, reference_paiement) VALUES 
(1, 1, CURRENT_DATE, 30000, 'Paye', 'REF001'),
(2, 2, CURRENT_DATE, 15000, 'En attente', 'REF002');

-- Insertion des paiements entreprise
INSERT INTO paiement_entreprise (id_facture, montant, date_paiement, mode_paiement) VALUES 
(1, 30000, CURRENT_DATE, 'Espèces'),
(2, 15000, CURRENT_DATE, 'Virement');
-- Nettoyage
DELETE FROM mvt_stock;
DELETE FROM detail_commande;
DELETE FROM commandes;
DELETE FROM details_plat;
DELETE FROM composant;
DELETE FROM type_composant;
DELETE FROM unite;
DELETE FROM plat;

-- Types de composants
INSERT INTO type_composant (id, nom) VALUES 
(1, 'Viande'),
(2, 'Légume');

-- Unités
INSERT INTO unite (id, nom, symbol) VALUES 
(1, 'Kg', 'Kg'),
(2, 'Litre', 'L');

-- Composants
INSERT INTO composant (id, id_type, nom, id_unite) VALUES 
(1, 1, 'Poulet', 1),
(2, 2, 'Carotte', 1),
(3, 2, 'Pomme de terre', 1);

-- Plats
INSERT INTO plat (id, intitule, prix, date_creation) VALUES 
(1, 'Poulet rôti', 15000, '2024-12-15'),
(2, 'Potage légumes', 12000, '2024-12-20');

-- Détails des plats
INSERT INTO details_plat (id, id_plat, id_composant, quantite) VALUES 
(1, 1, 1, 1.5),
(2, 1, 2, 0.5),
(3, 2, 2, 0.8),
(4, 2, 3, 1.2);

-- Commandes
INSERT INTO commandes (id, id_entreprise, prix_total, date_heure_prevue) VALUES 
(1, 1, 30000, '2025-06-10 12:00'),
(2, 1, 24000, '2025-07-03 18:00');

-- Détails commandes
INSERT INTO detail_commande (id, id_commande, id_plat, quantite, prix_unitaire) VALUES 
(1, 1, 1, 2, 15000),
(2, 2, 2, 2, 12000);

-- Mouvements stock (entrées)
INSERT INTO mvt_stock (id, id_composant, type_mvt, quantite, date_mvt, prix_unitaire, date_peremption) VALUES 
(1, 1, 0, 50, '2025-06-01', 9000, '2025-06-10'),
(2, 2, 0, 80, '2025-06-01', 2500, '2025-06-15'),
(3, 3, 0, 60, '2025-06-01', 3000, '2025-06-20'),
(4, 1, 0, 30, '2025-07-01', 9500, '2025-07-10'),
(5, 2, 0, 50, '2025-07-01', 2700, '2025-07-15');

-- Mouvements stock (sorties)
INSERT INTO mvt_stock (id, id_composant, type_mvt, quantite, date_mvt, prix_unitaire, date_peremption) VALUES 
(6, 1, 1, 3, '2025-06-10', 9000, '2025-06-10'),
(7, 2, 1, 2, '2025-06-10', 2500, '2025-06-15'),
(8, 2, 1, 4, '2025-07-03', 2700, '2025-07-15'),
(9, 3, 1, 2.4, '2025-07-03', 3000, '2025-07-20');
