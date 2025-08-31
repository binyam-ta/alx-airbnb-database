# Airbnb Clone Database Schema

## Overview
This repository contains the SQL schema for a vacation rental platform database. The database is designed to be in **Third Normal Form (3NF)** to minimize redundancy and ensure data integrity.

---

## Schema Design
The database consists of the following tables:

- **UserRoles**: Reference table for user roles (`guest`, `host`, `admin`)  
- **Users**: Stores user information with role references  
- **Property**: Contains property listings with details  
- **Booking**: Manages property bookings with pricing information  
- **Payment**: Tracks payment transactions  
- **Review**: Stores property reviews and ratings  
- **Message**: Handles user-to-user messaging  

---

## Key Features

- **UUID Primary Keys**: All tables use UUIDs as primary keys for better distribution and security  
- **Referential Integrity**: Foreign key constraints with `CASCADE` delete to maintain data consistency  
- **Data Validation**: `CHECK` constraints ensure valid data (e.g., ratings between 1-5)  
- **Automatic Timestamps**: `created_at` and `updated_at` fields are automatically managed  
- **Performance Optimization**: Indexes on frequently queried columns  
- **Triggers**: Automated calculation of booking totals and timestamp updates  

---

## Normalization
The schema has been normalized to **3NF**:

- Created a separate `UserRoles` table to eliminate role redundancy  
- Added `booked_price_per_night` to `Booking` table to preserve historical pricing  
- All non-key attributes are fully functionally dependent on primary keys  
- No transitive dependencies exist  

---

## Installation
1. Ensure PostgreSQL is installed and running  
2. Execute the schema file to create the database structure:

```bash
psql -U username -d database_name -f schema.sql
```

## Usage
The database supports all core vacation rental operations:

- User registration and authentication  
- Property listing and management  
- Booking and payment processing  
- Review system  
- User messaging  

---

## Indexes
The schema includes indexes on:

- Frequently searched columns (`email`, `location`)  
- Foreign key columns for join performance  
- Date columns for time-based queries  
- Rating columns for review filtering  

---

## Constraints
- `NOT NULL` constraints on required fields  
- `UNIQUE` constraints on appropriate columns (`email`)  
- `CHECK` constraints for data validation (rating values)  
- `FOREIGN KEY` constraints for referential integrity  

---

## Triggers
- **update_property_updated_at**: Automatically updates the `updated_at` timestamp when a property is modified  
- **calculate_booking_total**: Calculates the `total_price` based on duration and nightly rate before inserting/updating a booking
