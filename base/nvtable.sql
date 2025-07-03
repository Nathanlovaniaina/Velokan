CREATE TABLE recommandation (
    id SERIAL PRIMARY KEY,
    date_recommandation DATE NOT NULL,
    id_plat INTEGER REFERENCES plat(id) NOT NULL,
    id_entreprise INTEGER REFERENCES entreprise(id) NOT NULL
);

CREATE TABLE plat (
    id SERIAL PRIMARY KEY,
    intitule VARCHAR(100),
    prix INTEGER,
    date_creation DATE,
    image VARCHAR(255)
);


CREATE TABLE entreprise (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    adresse VARCHAR(100),
    latitude NUMERIC(10,2),
    longitude NUMERIC(10,2),
    geom geometry(Point, 4326),
    debut_date_contrat DATE
);
