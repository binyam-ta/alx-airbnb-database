# SQL Joins Queries – Airbnb Database

## Objective
Practice and master SQL joins by writing queries that use different types of joins on the **Airbnb database schema**.

## Queries

### 1. INNER JOIN
Retrieve all **bookings** and the respective **users** who made those bookings.

```sql
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
````
### 2. LEFT JOIN

Retrieve all properties and their reviews, including properties that have no reviews.
```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    r.review_id,
    r.rating,
    r.comment,
    r.created_at
FROM properties p
LEFT JOIN reviews r ON p.property_id = r.property_id;
````
### 3. FULL OUTER JOIN

Retrieve all users and all bookings, even if:

the user has no booking

or a booking is not linked to a user.
```sql
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
````

# SQL Subqueries – Airbnb Database

## Objective
Practice writing **correlated** and **non-correlated** subqueries in SQL.

## Queries

### 1. Non-Correlated Subquery
Find all **properties** where the **average rating** is greater than `4.0`.

```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    p.location,
    p.price_per_night
FROM properties p
WHERE p.property_id IN (
    SELECT r.property_id
    FROM reviews r
    GROUP BY r.property_id
    HAVING AVG(r.rating) > 4.0
);
````
### 2. Correlated Subquery

Find all users who have made more than 3 bookings.
```sql
SELECT 
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.user_id = u.user_id
) > 3;
````

# SQL Aggregations & Window Functions – Airbnb Database

## Objective
Use SQL **aggregation** and **window functions** to analyze Airbnb-style booking data.

## Queries

### 1. Aggregation – COUNT & GROUP BY
Find the **total number of bookings** made by each user.

```sql
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
````
2. Window Function – RANK

Rank properties based on the total number of bookings they have received.
```sql
SELECT 
    p.property_id,
    p.name AS property_name,
    COUNT(b.booking_id) AS total_bookings,
    RANK() OVER (ORDER BY COUNT(b.booking_id) DESC) AS booking_rank
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
GROUP BY p.property_id, p.name
ORDER BY booking_rank;
```