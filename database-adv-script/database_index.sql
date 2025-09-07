-- Create indexes to improve query performance

-- 1. Index on users.email (frequently used for login & lookups)
CREATE INDEX idx_users_email ON users(email);

-- 2. Index on bookings.user_id (used in JOIN between users and bookings)
CREATE INDEX idx_bookings_user_id ON bookings(user_id);

-- 3. Index on bookings.property_id (used in JOIN between properties and bookings)
CREATE INDEX idx_bookings_property_id ON bookings(property_id);

-- 4. Index on bookings.created_at (for ORDER BY and time-based queries)
CREATE INDEX idx_bookings_created_at ON bookings(created_at);

-- 5. Index on properties.location (for property searches by location)
CREATE INDEX idx_properties_location ON properties(location);

-- 6. Index on reviews.property_id (for retrieving reviews linked to properties)
CREATE INDEX idx_reviews_property_id ON reviews(property_id);

-- Example query to measure performance before adding indexes
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-user-uuid';

EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE location = 'Miami Beach, FL';

EXPLAIN ANALYZE
SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2024-06-01' AND '2024-06-30';

-- Step 1: Create indexes
CREATE INDEX idx_bookings_user_id ON bookings(user_id);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_bookings_start_date ON bookings(start_date);

-- Step 2: Measure performance after adding indexes
EXPLAIN ANALYZE
SELECT *
FROM bookings
WHERE user_id = 'some-user-uuid';

EXPLAIN ANALYZE
SELECT *
FROM properties
WHERE location = 'Miami Beach, FL';

EXPLAIN ANALYZE
SELECT *
FROM bookings b
JOIN users u ON b.user_id = u.user_id
WHERE b.start_date BETWEEN '2024-06-01' AND '2024-06-30';
