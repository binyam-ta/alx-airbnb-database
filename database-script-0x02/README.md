# Database Seeding Script

## Overview
This script populates the Airbnb clone database with realistic sample data that demonstrates the platform's functionality. The data includes users with different roles, properties, bookings, payments, reviews, and messages.

## Data Structure

### User Roles
- **Admin**: System administrator with full access  
- **Host**: Property owners who can list and manage properties  
- **Guest**: Users who can book properties and leave reviews  

### Users
- **1 Admin user**  
- **2 Host users**: John and Sarah  
- **3 Guest users**: Mike, Lisa, and David  

### Properties
- **John's properties**:  
  - Beachfront Villa  
  - Downtown Loft  

- **Sarah's properties**:  
  - Mountain Cabin  
  - Lakeside Retreat  

### Bookings
- 5 bookings with various statuses: confirmed, pending, canceled  
- Different date ranges and properties  

### Payments
- 3 payments corresponding to confirmed bookings  
- Different payment methods: credit card, PayPal, Stripe  

### Reviews
- 3 reviews with ratings between 4-5 stars  
- Detailed comments about the properties  

### Messages
- 3 sample messages between users  
- Demonstrates the messaging functionality  

## Usage
1. Ensure the database schema has been created using the `schema.sql` script  
2. Run the seeding script:

```bash
psql -U username -d database_name -f seed.sql
```
## Data Relationships
- Users have specific roles (admin, host, or guest)  
- Properties are owned by host users  
- Bookings connect guests to properties  
- Payments are linked to specific bookings  
- Reviews are left by guests for properties they've booked  
- Messages are exchanged between users  

## Sample Data Details
- Realistic names, emails, and phone numbers  
- Varied property types and locations  
- Different booking statuses and date ranges  
- Multiple payment methods  
- Detailed reviews with ratings  
- Example conversations between users
