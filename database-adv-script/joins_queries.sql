-- 1. INNER JOIN: Retrieve all bookings and the respective users who made those bookings
SELECT 
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.guests,
    b.status,
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u ON b.user_id = u.user_id;

-- 2. LEFT JOIN to retrieve all properties and their reviews, ordered by property name
SELECT
    p.property_id,
    p.name AS property_name,
    r.review_id,
    r.rating,
    r.comment,
    r.user_id AS reviewer_id
FROM properties p
LEFT JOIN reviews r
    ON p.property_id = r.property_id
ORDER BY p.name, r.review_id;


-- 3. FULL OUTER JOIN: Retrieve all users and all bookings,
-- even if the user has no booking or a booking is not linked to a user
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email,
    b.booking_id,
    b.property_id,
    b.start_date,
    b.end_date,
    b.guests,
    b.status
FROM users u
FULL OUTER JOIN bookings b ON u.user_id = b.user_id;


