/* Database schema to keep the structure of entire database. */
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BIT,
    weight_kg FLOAT,
    PRIMARY KEY(id)
);

-- Alter table to include species column
ALTER TABLE
    animals
ADD
    species VARCHAR(100);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age INT,
    PRIMARY KEY(id)
);

CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    PRIMARY KEY(id)
);

-- Drop species column
ALTER TABLE
    animals DROP COLUMN species;

-- Add species_id column to animals table
ALTER TABLE
    animals
ADD
    COLUMN species_id INT;

--Reference species table in animals table
ALTER TABLE
    animals
ADD
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id) ON DELETE CASCADE;

-- Add owner_id colum to animals table
ALTER TABLE
    animals
ADD
    COLUMN owner_id INT;

-- Reference owners table in animals table
ALTER TABLE
    animals
ADD
    CONSTRAINT fk_owners FOREIGN KEY(owner_id) REFERENCES owners(id) ON DELETE CASCADE;

-- Create table for vets
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

-- Create table for specializations
CREATE TABLE specializations (
    species_id INT,
    vet_id INT,
    CONSTRAINT fk_species_sp FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id),
    PRIMARY KEY(species_id, vet_id)
);

-- Create table for visits
CREATE TABLE visits (
    animal_id INT,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animal_visit FOREIGN KEY(animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets_visit FOREIGN KEY(vet_id) REFERENCES vets(id),
    PRIMARY KEY(animal_id, vet_id, date_of_visit)
);

ALTER TABLE
    owners
ADD
    COLUMN email VARCHAR(120);

CREATE INDEX owners_email_idx ON owners(email);

CREATE INDEX visits_animal_id_index ON visits(animal_id);

CREATE INDEX visits_vet_id_index ON visits(vet_id);