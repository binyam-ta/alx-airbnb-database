# Database Normalization to 3NF

## Initial Schema Review
The initial database schema was well-designed with proper foreign key relationships and constraints. However, upon closer examination for normalization principles, I identified a few areas that could be improved to achieve **Third Normal Form (3NF)**.

## Normalization Steps

### 1. First Normal Form (1NF)
The initial schema already satisfied 1NF as:

- All tables had primary keys
- All attributes were atomic (no multi-valued attributes)
- No repeating groups existed

### 2. Second Normal Form (2NF)
The schema satisfied 2NF as:

- All tables had primary keys
- All non-key attributes were fully functionally dependent on the entire primary key
- No partial dependencies existed

### 3. Third Normal Form (3NF)
To achieve 3NF, I identified and addressed the following **transitive dependencies**:

#### Issue 1: Property Price Update Anomaly
The `total_price` in the `Booking` table was transitively dependent on both the `property_id` and the dates, creating a potential update anomaly if property prices changed.

**Solution:**

- Added `booked_price_per_night` to the `Booking` table
- This ensures the booking records the price at the time of booking
- The `total_price` can now be calculated as:  
  `(end_date - start_date) * booked_price_per_night`

#### Issue 2: User Role Redundancy
The `role` attribute in the `User` table could lead to update anomalies if role definitions changed.

**Solution:**

- Created a new `UserRoles` reference table
- This allows for easier management of role types and permissions

