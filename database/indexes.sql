CREATE INDEX idx_orders_delivered_date 
ON orders(delivered_date);

CREATE INDEX idx_orders_vehicle 
ON orders(vehicle_id);
