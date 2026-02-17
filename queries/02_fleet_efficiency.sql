WITH vehicle_metrics AS (
    SELECT
        vehicle_id,
        COUNT(*) AS total_deliveries,
        AVG(delivered_date - order_date) AS avg_delivery_time
    FROM orders
    WHERE delivered_date IS NOT NULL
    GROUP BY vehicle_id
)

SELECT
    vehicle_id,
    total_deliveries,
    avg_delivery_time,
    RANK() OVER (
        ORDER BY avg_delivery_time ASC
    ) AS efficiency_rank
FROM vehicle_metrics;
