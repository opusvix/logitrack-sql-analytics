WITH delivered_orders AS (
    SELECT *
    FROM orders
    WHERE delivered_date IS NOT NULL
),
delay_analysis AS (
    SELECT
        COUNT(*) AS total_delivered,
        SUM(
            CASE 
                WHEN delivered_date > promised_date THEN 1 
                ELSE 0 
            END
        ) AS total_delayed
    FROM delivered_orders
)

SELECT
    total_delivered,
    total_delayed,
    ROUND(
        100.0 * total_delayed / total_delivered,
        2
    ) AS delay_rate_percent
FROM delay_analysis;
