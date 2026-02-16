CREATE TABLE warehouses (
    warehouse_id SERIAL PRIMARY KEY,
    city VARCHAR(100),
    region VARCHAR(100)
);

CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    type VARCHAR(50),
    capacity_kg INT,
    cost_per_km DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT,
    warehouse_id INT REFERENCES warehouses(warehouse_id),
    vehicle_id INT REFERENCES vehicles(vehicle_id),
    order_date TIMESTAMP,
    promised_date TIMESTAMP,
    delivered_date TIMESTAMP,
    freight_cost DECIMAL(10,2)
);
