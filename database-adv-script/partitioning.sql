-- Step 1: Create a partitioned table for bookings based on start_date
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

-- Step 2: Create partitions for specific date ranges
CREATE TABLE bookings_2023 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE bookings_2024 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');

CREATE TABLE bookings_2025 PARTITION OF bookings_partitioned
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Step 3: Insert data from original bookings table into the partitioned table
INSERT INTO bookings_partitioned (booking_id, user_id, property_id, start_date, end_date, guests, status, created_at)
SELECT booking_id, user_id, property_id, start_date, end_date, guests, status, created_at
FROM bookings;

-- Step 4: Test query performance on partitioned table
EXPLAIN ANALYZE
SELECT *
FROM bookings_partitioned
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30';
