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
    ('lead1', 01612222222, 1, '2022-02-04', false),
    ('lead2', 01613333333, 1, '2022-02-04', true),
    ('lead3', 01614444444, 4, '2022-02-04', false),
    ('lead4', 01615555555, 4, '2022-02-04', true);


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
    (1, 'hsbc', '24 months', '20000', '833', 'breakdown + service', '2020-04-05', '2022-04-05', 'perosnal'),
    (2, 'rbs', '24 months', '20000', '833', 'breakdown', '2020-04-05', '2022-04-05', 'perosnal'),
    (4, 'hsbc', '24 months', '20000', '833', 'breakdown + service', '2022-02-04', '2024-02-04', 'commercial');


-- leads_customers

CREATE TABLE leads_customers (
    lead_customer_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    lead_id INT REFERENCES leads(lead_id)
);

INSERT INTO leads_customers 
    (customer_id, lead_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4);


-- customers_quotes

CREATE TABLE customers_quotes (
    customer_quote_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    quote_id INT REFERENCES quotes(quote_id)
);

INSERT INTO customers_quotes 
    (customer_id, quote_id)
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 4);


-- customers_policies

CREATE TABLE customers_policies (
    customer_polciy_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    policy_id INT REFERENCES policies(policy_id)
);

INSERT INTO customers_policies 
    (customer_id, policy_id)
VALUES
    (3, 4),
    (2, 5),
    (1, 1),
    (2, 2);


-- Queries

-- The business wants to try and engage customers through email marketing, which have leasing policies expiring in the next 2 months. Based on your entity diagram, write an SQL query which will return a list of these customers and their contact details, along with their vehicle details.

SELECt * FROM customers_policies
JOIN customers ON customers_policies.customer_id = customers.customer_id
JOIN policies ON customers_policies.policy_id = policies.policy_id;
WHERE



