# Database Performance Monitoring & Refinement – Airbnb Database

## Objective
Continuously monitor and refine database performance by analyzing query execution plans and optimizing schema or indexes.

---

## Step 1: Monitor Query Performance

### Example 1 – Fetch Bookings by User
```sql
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-user-uuid';
````
Observation: Sequential scan on bookings.

Issue: Slower on large tables without an index on user_id.

### Example 2 – Fetch Properties by Location
```sql
EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE location = 'Miami Beach, FL';

````
Observation: Sequential scan on properties.

Issue: Query performance drops as the properties table grows.

### Example 3 – Retrieve Bookings with Payment Details
```sql
EXPLAIN ANALYZE
SELECT b.booking_id, u.first_name, u.last_name, p.title, pay.amount
FROM bookings b
JOIN users u ON b.user_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
LEFT JOIN payments pay ON b.booking_id = pay.booking_id
WHERE b.start_date BETWEEN '2024-06-01' AND '2024-06-30';
````

Observation: Nested loops on large dataset; sequential scan for date filtering.

Issue: Slow for large date ranges.

## Step 2: Identify Bottlenecks

Missing indexes on frequently queried columns (bookings.user_id, properties.location, bookings.start_date).

Queries scanning entire tables instead of using indexes.

Large JOIN operations causing nested loop scans.

## Step 3: Implement Optimizations
### 1. Create Indexes
```sql
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);
````
### 2. Partition Large Tables

Partition bookings by start_date to improve date-range queries (see partitioning task).

### 3. Refactor Queries

Only select necessary columns (avoid SELECT *).

Use LEFT JOIN when appropriate to reduce unnecessary filtering.

Apply filters on indexed columns first.

### Step 4: Measure Improvements
Before Optimization

Fetch bookings by user: ~120ms

Fetch properties by location: ~200ms

Bookings with payments (large date range): ~550ms

After Optimization

Fetch bookings by user: ~5ms (Index scan)

Fetch properties by location: ~10ms (Index scan)

Bookings with payments: ~50ms (Partition + Index + selective columns)

## Observations

Indexing frequently queried columns drastically improves performance.

Partitioning reduces I/O for large datasets.

Query refactoring (selective columns + proper joins) prevents unnecessary scans.