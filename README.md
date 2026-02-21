# 🚀 LogiTrack Analytics – Data Engineering & BI Project

## 📌 Overview

This project demonstrates how database architecture directly impacts BI performance.

A table containing 2.1 million records was optimized using partitioning in PostgreSQL, followed by the development of an executive dashboard in Power BI.

The project covers:

- Database performance optimization
- Partition pruning validation
- Analytical modeling
- Executive dashboard development
- Performance comparison (before vs after)

---

# 🗄 Data Source

| Item | Description |
|------|------------|
| Database | PostgreSQL |
| Table | `orders_partitioned` |
| Records | 2,100,000 |
| Strategy | `PARTITION BY RANGE (order_date)` |
| Environment | Docker |

---

# ⚙ Database Optimization

## Before Partitioning

```sql
SELECT COUNT(*) FROM orders;
```

Execution time: **551 ms**  
Full table scan (Seq Scan)

---

## After Partitioning

```sql
SELECT COUNT(*)
FROM orders_partitioned
WHERE order_date >= '2025-01-01'
AND order_date < '2026-01-01';
```

Execution time: **0.034 ms**

Only the relevant partition was scanned.

---

## Performance Comparison

| Scenario | Rows Scanned | Execution Time | Method |
|----------|--------------|----------------|--------|
| Before | 2,100,000 | 551 ms | Seq Scan |
| After | Single partition | 0.034 ms | Partition Pruning |

Estimated improvement: ~16,000x faster.

---

# 📊 Power BI Dashboard

Tool: Power BI  
Connection Mode: Import  
Source: PostgreSQL (Docker)

---

# 📈 Implemented Metrics

| Metric | Description |
|--------|------------|
| Total Orders | Total number of orders |
| Total Revenue | Sum of order value |
| Average Ticket | Revenue per order |
| Monthly Revenue | Time-based trend |
| Monthly Orders | Volume trend |
| Growth % | Month-over-month growth |
| Revenue by Vehicle Type | Operational distribution |
| Ranking by Total Orders | Vehicle performance |

---

# 🧠 DAX Measures

## Total Orders

```DAX
Total Orders = COUNT(orders_partitioned[id])
```

## Total Revenue

```DAX
Total Revenue = SUM(orders_partitioned[total_amount])
```

## Average Ticket

```DAX
Average Ticket =
DIVIDE(
    [Total Revenue],
    [Total Orders]
)
```

## Growth %

```DAX
Growth % =
VAR Current = [Total Revenue]
VAR Previous =
    CALCULATE(
        [Total Revenue],
        PREVIOUSMONTH(Calendario[Date])
    )
RETURN
DIVIDE(Current - Previous, Previous)
```

---

# 🖥 Dashboard Structure

## Executive Page

KPIs:
- Total Orders
- Total Revenue
- Average Ticket
- Growth %

Visuals:
- Line chart → Monthly Revenue
- Column chart → Monthly Orders
- Bar chart → Revenue by Vehicle Type
- Table → Ranking by Total Orders

Filters:
- Year
- Type of Vehicle

---

# 🏗 Architecture

```text
┌──────────────────────────┐
│   PostgreSQL (Docker)    │
│   Partitioned by Date    │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│     Power BI (Import)    │
│  DAX Modeling & Metrics  │
└──────────────┬───────────┘
               │
               ▼
┌──────────────────────────┐
│   Executive Dashboard    │
│   KPIs & Trend Analysis  │
└──────────────────────────┘
```

# 🎯 Conclusion

This project demonstrates:

- The impact of database design on analytics
- Real performance improvement using partitioning
- BI modeling best practices
- Full data engineering to dashboard pipeline

---

# 📌 Technologies

- PostgreSQL
- Docker
- Power BI
- DAX
- SQL
