\c gb_leasing

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
    (1, 4);


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


