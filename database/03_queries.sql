\c gb_leasing

-- Queries

-- The business wants to try and engage customers through email marketing, which have leasing policies expiring in the next 2 months. Based on your entity diagram, write an SQL query which will return a list of these customers and their contact details, along with their vehicle details.

SELECt * FROM customers_policies
JOIN customers ON customers_policies.customer_id = customers.customer_id
JOIN policies ON customers_policies.policy_id = policies.policy_id
JOIN vehicles ON policies.vehicle_id = vehicles.vehicle_id
WHERE policies.lease_end < '2022-04-05';



-- The customer has asked for a report that shows all leads generated in the last month where they were qualified and quotes sent – they simply want name, lead source and make and model of car initially enquired about on the lead report. Write an SQL query to get the above data based on your entity model.

SELECt * FROM leads_customers
JOIN leads ON leads_customers.lead_id = leads.lead_id
JOIN customers ON leads_customers.customer_id = customers.customer_id
WHERE leads.qualified = true;