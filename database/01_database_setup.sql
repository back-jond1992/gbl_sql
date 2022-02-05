DROP DATABASE IF EXISTS gb_leasing;
CREATE DATABASE gb_leasing;

\c gb_leasing


-- customers

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    full_address VARCHAR,
    email VARCHAR,
    contact_num VARCHAR(11)
);

INSERT INTO customers 
    (full_name, full_address, email, contact_num)
VALUES
    ('Joe Bloggs', '01 example road, example town', 'example@example.com', 11111111111),
    ('Jane Doe', '02 example road, example town', 'example2@example.com', 11111111112),
    ('John Doe', '03 example road, example town', 'example3@example.com', 11111111113);


-- vehicles

CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    vehicle_name VARCHAR,
    manufacturer VARCHAR,
    year_of_manufacturer VARCHAR
);

INSERT INTO vehicles 
    (vehicle_name, manufacturer, year_of_manufacturer)
VALUES
    ('corsa', 'vauxhall', '2020'),
    ('punto', 'fiat', '2022'),
    ('transit', 'ford', '2015'),
    ('berlingo', 'citreon', '2018');


-- -- leads

CREATE TABLE leads (
    lead_id SERIAL PRIMARY KEY,
    source VARCHAR,
    contact_num VARCHAR(11),
    vehicle INT REFERENCES vehicles(vehicle_id),
    created_at DATE,
    qualified BOOLEAN
);

INSERT INTO leads 
    (source, contact_num, vehicle, created_at, qualified)
VALUES
    ('lead1', 01612222222, 1, '2022-01-01', false),
    ('lead2', 01613333333, 1, '2022-01-01', true),
    ('lead3', 01614444444, 4, '2022-01-01', false),
    ('lead4', 01615555555, 4, '2022-01-01', true);


-- -- quotes

CREATE TABLE quotes (
    quote_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    lender VARCHAR,
    term VARCHAR,
    total_price VARCHAR,
    monthly_repayments VARCHAR,
    add_ons VARCHAR
);

INSERT INTO quotes 
    (vehicle_id, lender, term, total_price, monthly_repayments, add_ons)
VALUES
    (1, 'halifax', '24 months', '10000', '417', 'breakdown'),
    (1, 'rbs', '18 months', '11500', '639', 'service'),
    (2, 'barclays', '24 months', '9000', '375', 'serive'),
    (4, 'hsbc', '24 months', '20000', '833', 'breakdown + service');


-- policies

CREATE TABLE policies (
    policy_id SERIAL PRIMARY KEY,
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    lender VARCHAR,
    term VARCHAR,
    total_price VARCHAR,
    monthly_repayments VARCHAR,
    add_ons VARCHAR,
    lease_start DATE,
    lease_end DATE,
    lease_type VARCHAR
);

INSERT INTO policies 
    (vehicle_id, lender, term, total_price, monthly_repayments, add_ons, lease_start, lease_end, lease_type)
VALUES
    (1, 'halifax', '24 months', '10000', '417', 'breakdown', '2022-02-04', '2024-02-04', 'perosnal'),
    (1, 'rbs', '18 months', '11500', '639', 'service', '2022-02-04', '2023-08-04', 'perosnal'),
    (2, 'barclays', '24 months', '9000', '375', 'serive', '2022-02-04', '2024-02-04', 'perosnal'),
    (1, 'hsbc', '24 months', '20000', '833', 'breakdown + service', '2020-03-05', '2022-03-05', 'perosnal'),
    (2, 'rbs', '24 months', '20000', '833', 'breakdown', '2020-03-05', '2022-03-05', 'perosnal'),
    (4, 'hsbc', '24 months', '20000', '833', 'breakdown + service', '2022-02-04', '2024-02-04', 'commercial');


