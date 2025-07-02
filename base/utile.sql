CREATE TABLE plat (
    id SERIAL PRIMARY KEY,
    intitule VARCHAR(100),
    prix INTEGER,
    date_creation DATE,
    image VARCHAR(255)
);


CREATE TABLE details_plat(
    id SERIAL PRIMARY KEY,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    id_composant INTEGER REFERENCES composant(id) NOT NULL,
    quantite NUMERIC (10,2)
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


CREATE TABLE commandes (
    id SERIAL PRIMARY KEY,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL,
    prix_total INTEGER,
    date_heure_prevue TIMESTAMP
);

CREATE TABLE detail_commande(
    id SERIAL PRIMARY KEY,
    id_commande INTEGER REFERENCES commande(id) NOT NULL,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    quantite INTEGER,
    prix_unitaire INTEGER
);
