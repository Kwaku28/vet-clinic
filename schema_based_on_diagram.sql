-- patients
CREATE TABLE patients (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(id)
);

-- treatments
CREATE TABLE treatments (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    type VARCHAR(36) NOT NULL,
    name VARCHAR(50) NOT NULL,
    PRIMARY KEY(id)
);

-- medical_histories
CREATE TABLE medical_histories (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    admitted_at TIMESTAMP NOT NULL,
    status VARCHAR(255),
    PRIMARY KEY(id)
);

ALTER TABLE
    medical_histories
ADD
    patient_id INTEGER REFERENCES patients(id) ON DELETE CASCADE;

-- invoices
CREATE TABLE invoices (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    total_amount DECIMAL NOT NULL,
    generated_at TIMESTAMP NOT NULL,
    payed_at TIMESTAMP NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE
    invoices
ADD
    medical_history_id INTEGER REFERENCES medical_histories(id) ON DELETE CASCADE;

-- invoice_items
CREATE TABLE invoice_items (
    id INTEGER GENERATED ALWAYS AS IDENTITY,
    unit_price DECIMAL NOT NULL,
    quantity INTEGER NOT NULL,
    total_price DECIMAL NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE
    invoice_items
ADD
    invoice_id INTEGER REFERENCES invoices(id) ON DELETE CASCADE;

ALTER TABLE
    invoice_items
ADD
    treatment_id INTEGER REFERENCES treatments(id) ON DELETE CASCADE;

-- medical_histories :: treatments (Many to Many)
CREATE TABLE medical_treatments_history (
    medical_history_id INTEGER REFERENCES medical_histories(id) ON DELETE CASCADE,
    treatment_id INTEGER REFERENCES treatments(id) ON DELETE CASCADE
);

CREATE INDEX patient_id_idx ON medical_histories(patient_id);

CREATE INDEX medical_history_id_idx ON invoices(medical_history_id);

CREATE INDEX invoice_id_idx ON invoice_items(invoice_id);

CREATE INDEX treatment_id_idx ON invoice_items(treatment_id);

CREATE INDEX medical_history_id_idx ON medical_treatments_history(medical_history_id);

CREATE INDEX treatment_history_id_idx ON medical_treatments_history(treatment_id);