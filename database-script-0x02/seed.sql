-- Seed data for UserRoles table (already populated in schema, but ensuring)
INSERT INTO UserRoles (role_name, description) VALUES
('guest', 'Standard user who can book properties'),
('host', 'User who can list and manage properties'),
('admin', 'Administrator with system-wide permissions')
ON CONFLICT (role_name) DO NOTHING;

-- Seed data for Users table
INSERT INTO Users (user_id, first_name, last_name, email, password_hash, phone_number, role_id) VALUES
-- Admin user
('11111111-1111-1111-1111-111111111111', 'Admin', 'User', 'admin@example.com', '$2b$10$examplehash', '+1234567890', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'admin')),
-- Host users
('22222222-2222-2222-2222-222222222222', 'John', 'PropertyOwner', 'john@example.com', '$2b$10$examplehash', '+1234567891', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'host')),
('33333333-3333-3333-3333-333333333333', 'Sarah', 'RealEstate', 'sarah@example.com', '$2b$10$examplehash', '+1234567892', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'host')),
-- Guest users
('44444444-4444-4444-4444-444444444444', 'Mike', 'Traveler', 'mike@example.com', '$2b$10$examplehash', '+1234567893', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'guest')),
('55555555-5555-5555-5555-555555555555', 'Lisa', 'Vacationer', 'lisa@example.com', '$2b$10$examplehash', '+1234567894', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'guest')),
('66666666-6666-6666-6666-666666666666', 'David', 'Explorer', 'david@example.com', '$2b$10$examplehash', '+1234567895', 
 (SELECT role_id FROM UserRoles WHERE role_name = 'guest'));

-- Seed data for Property table
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight) VALUES
-- John's properties
('77777777-7777-7777-7777-777777777777', '22222222-2222-2222-2222-222222222222', 
 'Beachfront Villa', 'Beautiful villa with direct beach access, 3 bedrooms, and stunning ocean views', 
 'Miami Beach, FL', 350.00),
('88888888-8888-8888-8888-888888888888', '22222222-2222-2222-2222-222222222222', 
 'Downtown Loft', 'Modern loft in the heart of the city, close to restaurants and nightlife', 
 'New York, NY', 250.00),
-- Sarah's properties
('99999999-9999-9999-9999-999999999999', '33333333-3333-3333-3333-333333333333', 
 'Mountain Cabin', 'Cozy cabin with fireplace and mountain views, perfect for a relaxing getaway', 
 'Aspen, CO', 200.00),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333', 
 'Lakeside Retreat', 'Peaceful retreat on the lake with private dock and fishing equipment', 
 'Lake Tahoe, CA', 275.00);

-- Seed data for Booking table
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, booked_price_per_night, status) VALUES
-- Mike's bookings
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '77777777-7777-7777-7777-777777777777', 
 '44444444-4444-4444-4444-444444444444', '2023-06-15', '2023-06-20', 350.00, 'confirmed'),
-- Lisa's bookings
('cccccccc-cccc-cccc-cccc-cccccccccccc', '99999999-9999-9999-9999-999999999999', 
 '55555555-5555-5555-5555-555555555555', '2023-07-10', '2023-07-15', 200.00, 'confirmed'),
('dddddddd-dddd-dddd-dddd-dddddddddddd', '88888888-8888-8888-8888-888888888888', 
 '55555555-5555-5555-5555-555555555555', '2023-08-05', '2023-08-10', 250.00, 'pending'),
-- David's bookings
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 
 '66666666-6666-6666-6666-666666666666', '2023-09-01', '2023-09-07', 275.00, 'confirmed'),
('ffffffff-ffff-ffff-ffff-ffffffffffff', '77777777-7777-7777-7777-777777777777', 
 '66666666-6666-6666-6666-666666666666', '2023-10-12', '2023-10-15', 350.00, 'canceled');

-- Seed data for Payment table
INSERT INTO Payment (payment_id, booking_id, amount, payment_method) VALUES
('11111111-1111-1111-1111-111111111112', 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 
 1750.00, 'credit_card'),
('22222222-2222-2222-2222-222222222223', 'cccccccc-cccc-cccc-cccc-cccccccccccc', 
 1000.00, 'paypal'),
('33333333-3333-3333-3333-333333333334', 'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 
 1925.00, 'stripe');

-- Seed data for Review table
INSERT INTO Review (review_id, property_id, user_id, rating, comment) VALUES
('44444444-4444-4444-4444-444444444445', '77777777-7777-7777-7777-777777777777', 
 '44444444-4444-4444-4444-444444444444', 5, 
 'Absolutely stunning villa! The views were incredible and the location was perfect.'),
('55555555-5555-5555-5555-555555555556', '99999999-9999-9999-9999-999999999999', 
 '55555555-5555-5555-5555-555555555555', 4, 
 'Cozy cabin with beautiful views. The fireplace made our evenings so relaxing.'),
('66666666-6666-6666-6666-666666666667', 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 
 '66666666-6666-6666-6666-666666666666', 5, 
 'Perfect lakeside getaway! We loved fishing from the private dock every morning.');

-- Seed data for Message table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body) VALUES
('77777777-7777-7777-7777-777777777778', '44444444-4444-4444-4444-444444444444', 
 '22222222-2222-2222-2222-222222222222', 
 'Hi John, I''m interested in your beachfront villa. Is it available for the first week of July?'),
('88888888-8888-8888-8888-888888888889', '22222222-2222-2222-2222-222222222222', 
 '44444444-4444-4444-4444-444444444444', 
 'Hi Mike, thanks for your interest! Unfortunately, the first week of July is already booked.'),
('99999999-9999-9999-9999-99999999999a', '55555555-5555-5555-5555-555555555555', 
 '33333333-3333-3333-3333-333333333333', 
 'Hello Sarah, I had a wonderful stay at your mountain cabin. When will it be available again?');