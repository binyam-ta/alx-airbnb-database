# Index Performance Optimization – Airbnb Database

## Objective
Improve query performance by creating indexes on frequently used columns in the **Users**, **Bookings**, and **Properties** tables.

---

## Identified High-Usage Columns

- **users.email** → Used for login and lookups.
- **bookings.user_id** → Used in JOIN with `users`.
- **bookings.property_id** → Used in JOIN with `properties`.
- **bookings.created_at** → Used for sorting and filtering bookings by date.
- **properties.location** → Used when searching properties by city or region.
- **reviews.property_id** → Used in JOIN with `properties`.

---

## SQL Commands

```sql
-- Users table
CREATE INDEX idx_users_email ON users(email);

-- Bookings table
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_bookings_property_id ON bookings(property_id);
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- Properties table
CREATE INDEX idx_properties_location ON properties(location);

-- Reviews table
CREATE INDEX idx_reviews_property_id ON reviews(property_id);
````
## Performance Measurement

Before and after creating indexes, we can use EXPLAIN or ANALYZE in PostgreSQL to evaluate query performance.

Example 1 – Without Index
EXPLAIN ANALYZE
```sql
SELECT * 
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'test@example.com';
````

Execution Plan: Sequential Scan on users, Nested Loop Join with bookings.

## Performance: Slower due to full table scan.

Example 2 – With Index
EXPLAIN ANALYZE
```sql
SELECT * 
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE u.email = 'test@example.com';
````

Execution Plan: Index Scan on users.email, Index Scan on bookings.user_id.

Performance: Much faster, especially on large datasets.