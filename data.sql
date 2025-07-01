
-- 📌 Table type_composant
INSERT INTO type_composant (nom) VALUES 
('Legume'), 
('Viande'), 
('Epice');

-- 📌 Table unite
INSERT INTO unite (nom, symbol) VALUES 
('Kilogramme', 'kg'),
('Litre', 'l'),
('Piece', 'pc');

-- 📌 Table composant (corrige la reference à unite)
INSERT INTO composant (id_type, nom, id_unite) VALUES 
(1, 'Carotte', 1),
(2, 'Poulet', 1),
(3, 'Sel', 1);

-- 📌 Table plat (ajout du champ prix manquant)
INSERT INTO plat (intitule, prix) VALUES 
('Riz Poulet', 10000), 
('Soupe de legumes', 8000);

-- 📌 Table details_plat (recette des plats)
INSERT INTO details_plat (id_plat, id_composant, quantite) VALUES 
(1, 1, 0.2),
(1, 2, 0.3),
(1, 3, 0.01),
(2, 1, 0.5),
(2, 3, 0.01);

-- 📌 Table stock (corrige les champs pour correspondre au schema)
INSERT INTO stock (id_composant, date_creation, qtte_stock, nombre_jour_conservation) VALUES 
(1, '2025-06-20', 50, 11),  -- 11 jours entre le 20/06 et 01/07
(2, '2025-06-20', 20, 10),   -- 10 jours entre le 20/06 et 30/06
(3, '2025-06-20', 5, 365);   -- 1 an de conservation

-- 📌 Table mvt_stock (ajout du champ date_peremption manquant)
INSERT INTO mvt_stock (id_composant, type_mvt, quantite, date_mvt, date_peremption) VALUES 
(1, 0, 10, '2025-06-21', '2025-07-01'),
(1, 1, 2, '2025-06-22', '2025-07-02'),
(2, 0, 5, '2025-06-21', '2025-06-30');

-- 📌 Table entreprise (ajout du champ geom manquant)
INSERT INTO entreprise (nom, adresse, latitude, longitude, geom, debut_date_contrat) VALUES 
('Orange', 'Zone Galaxy', -18.8792, 47.5079, ST_SetSRID(ST_MakePoint(47.5079, -18.8792), 4326), '2025-01-01'),
('Canal+', 'Analakely', -18.9101, 47.5260, ST_SetSRID(ST_MakePoint(47.5260, -18.9101), 4326), '2025-02-01');

-- 📌 Table mvt_contrat
INSERT INTO mvt_contrat (id_entreprise, type_mvt) VALUES 
(1, 0),
(2, 0);

-- 📌 Table statut_livraison_commande
INSERT INTO statut_livraison_commande (nom) VALUES 
('Prêt à livrer'),
('En cours'),
('Livre');

-- 📌 Table commandes (corrige la structure - pas de id_plat ici)
INSERT INTO commandes (id_entreprise, prix_total, date_heure_prevue) VALUES 
(1, 200000, '2025-06-25 11:00:00'),
(2, 80000, '2025-06-25 12:00:00');

-- 📌 Table detail_commande (corrige le nom de la table et la structure)
INSERT INTO detail_commande (id_commande, id_plat, quantite, prix_unitaire) VALUES 
(1, 1, 20, 10000),
(1, 2, 5, 8000),
(2, 2, 10, 8000);

-- 📌 Table poste
INSERT INTO poste (nom, salaire) VALUES 
('Cuisinier', 500000),
('Livreur', 350000);

-- 📌 Table historique_salaire
INSERT INTO historique_salaire (id_poste, date_modification, nouveau_salaire) VALUES 
(1, '2025-06-01', 500000),
(2, '2025-06-01', 350000);

-- 📌 Table employe
INSERT INTO employe (id_poste, num_identification, nom, prenom, date_naissance, contact, date_embauche) VALUES 
(1, 'EMP001', 'Rakoto', 'Jean', '1990-05-10', '0321234567', '2023-01-15'),
(2, 'EMP002', 'Randria', 'Paul', '1992-08-20', '0337654321', '2024-02-20');

-- 📌 Table presence
INSERT INTO presence (id_emp, date_pres) VALUES 
(1, '2025-06-25'),
(2, '2025-06-25');

-- 📌 Table tache
INSERT INTO tache (nom) VALUES 
('Preparer riz'),
('Livrer commande');

-- 📌 Table statut_tache
INSERT INTO statut_tache (nom) VALUES 
('Non demarree'),
('En cours'),
('Terminee');

-- 📌 Table distribution_tache (corrige id_plat en id_commande)
INSERT INTO distribution_tache (id_tache, id_emp, id_commande, date_tache) VALUES 
(1, 1, 1, '2025-06-25'),
(2, 2, 1, '2025-06-25');

-- 📌 Table mvt_statut_tache (corrige statut en id_statut)
INSERT INTO mvt_statut_tache (id_distribution_tache, date_heure_modification, id_statut) VALUES 
(1, '2025-06-25 09:00:00', 1),
(1, '2025-06-25 10:00:00', 3);

-- 📌 Table mvt_employe
INSERT INTO mvt_employe (id_emp, type_mvt, date_mvt) VALUES 
(1, 0, '2023-01-15'),
(2, 0, '2024-02-20');

-- 📌 Table penalite
INSERT INTO penalite (nb_jour) VALUES 
(3),
(5);

-- 📌 Table paiement_salaire
INSERT INTO paiement_salaire (id_emp, date_paie, somme) VALUES 
(1, '2025-06-25', 500000),
(2, '2025-06-25', 350000);

-- 📌 Table facture (corrige id_commandes en id_commande)
INSERT INTO facture (id_commande, id_entreprise, date_emission, date_paiement, montant_total, statut, reference_paiement) VALUES 
(1, 1, '2025-06-25', '2025-06-25', 200000, 'Paye', 'VIR123456'),
(2, 2, '2025-06-25', null, 80000, 'En attente', null);

-- 📌 Table paiement_entreprise (complete le mode_paiement)
INSERT INTO paiement_entreprise (id_facture, montant, date_paiement, mode_paiement) VALUES 
(1, 200000, '2025-06-25', 'Virement bancaire');