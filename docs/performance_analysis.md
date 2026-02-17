# Performance Analysis

## Query Tested

Fleet delivery aggregation:

```sql
SELECT vehicle_id, COUNT(*)
FROM orders
WHERE delivered_date IS NOT NULL
GROUP BY vehicle_id;
```
## Before Index

- Execution Plan: Seq Scan

- Execution Time: XX ms

## After Index

- Execution Plan: Index Scan

- Execution Time: XX ms

## Conclusion

Indexing delivered_date significantly improved query performance.