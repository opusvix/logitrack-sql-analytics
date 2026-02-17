INSERT INTO warehouses (city, region)
SELECT
    'City ' || gs,
    CASE 
        WHEN gs % 4 = 0 THEN 'North'
        WHEN gs % 4 = 1 THEN 'South'
        WHEN gs % 4 = 2 THEN 'East'
        ELSE 'West'
    END
FROM generate_series(1, 10) AS gs;

INSERT INTO vehicles (type, capacity_kg, cost_per_km)
SELECT
    CASE WHEN gs % 2 = 0 THEN 'Truck' ELSE 'Van' END,
    (random()*10000)::INT,
    ROUND((random()*5 + 1)::numeric,2)
FROM generate_series(1, 50) AS gs;

INSERT INTO orders (
    customer_id,
    warehouse_id,
    vehicle_id,
    order_date,
    promised_date,
    delivered_date,
    freight_cost
)
SELECT
    (random()*10000)::INT,
    (random()*9 + 1)::INT,
    (random()*49 + 1)::INT,
    NOW() - (random()*365)::INT * INTERVAL '1 day',
    NOW() - (random()*350)::INT * INTERVAL '1 day',
    NOW() - (random()*340)::INT * INTERVAL '1 day',
    ROUND((random()*500 + 50)::numeric,2)
FROM generate_series(1, 100000);

