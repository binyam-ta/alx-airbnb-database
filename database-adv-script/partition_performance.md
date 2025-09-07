# Partitioning Performance – Airbnb Database

## Objective
Implement **table partitioning** on the Booking table to optimize queries on large datasets.

---

## Strategy
- Partition the **bookings** table by `start_date` using **RANGE partitioning**.
- Each partition holds bookings for one year.
- Query performance is expected to improve for date-range queries because PostgreSQL only scans relevant partitions.

---

## SQL Implementation
```sql
-- Partitioned bookings table
CREATE TABLE bookings_partitioned (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    guests INT NOT NULL,
    status VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Yearly partitions
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

    ````

## Performance Testing
### Query Before Partitioning
EXPLAIN ANALYZE
```sql
SELECT *
FROM bookings
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';

````
Execution Plan: Sequential scan on the entire bookings table.

Time: High, especially on large datasets.

### Query After Partitioning
EXPLAIN ANALYZE
```sql
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';

````
Execution Plan: Only scans bookings_2024 partition.

Time: Reduced significantly due to smaller scanned dataset.

### Observations

Partitioning by start_date drastically reduces I/O for date-range queries.

Maintenance becomes easier as old partitions can be archived or dropped.

Query execution scales better with increasing data size.