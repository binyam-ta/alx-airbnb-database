-- 1. Aggregation with COUNT and GROUP BY:
-- Find the total number of bookings made by each user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    COUNT(b.booking_id) AS total_bookings
FROM users u
LEFT JOIN bookings b ON u.user_id = b.user_id
GROUP BY u.user_id, u.first_name, u.last_name, u.email
ORDER BY total_bookings DESC;

-- 2. Window Function (RANK):
-- Rank properties based on the total number of bookings they have received
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;

-- Count total bookings per property
WITH property_bookings AS (
    SELECT
        property_id,
        COUNT(*) AS total_bookings
    FROM bookings
    GROUP BY property_id
)

-- Rank properties by total bookings using ROW_NUMBER()
SELECT
    property_id,
    total_bookings,
    ROW_NUMBER() OVER (ORDER BY total_bookings DESC) AS rank_by_bookings
FROM property_bookings;
