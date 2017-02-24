

/* Define the SQL necessary to create an employee table. The table to maintain at least the following information...

1.) Record ID (This is the primary key of the table)
2.) First name
3.) Last name
4.) Employee ID
5.) Active (Indicates whether an employee is active or inactive)
6.) Classification or role (Must maintain 3 or more values starting with: general manager, shift manager, and cashier)
7.) Manager (This is a foreign key to another record in the Employee table, may be empty)
8.) Password
9.) Created On (timestamp)

This may be modeled after the "product" table defined in the SQL script of the registerddls project. Of course, the "employee" table will look different. */

-- v.0001 has not yet been checked in the editor; this is based off of the registerddls and off of w3Schools SQL tutorial.
-- When I am out of class and have time, it will be checked over for errors, tested and marked complete, probably in that order.
-- [test notes: look into adding default to isActive and empRole, figure out how to associate manager w/empID, make isActive/empRole notnull]
-- 2/24/17 VLH

CREATE TABLE Employees
(
recordID int,
firstName varchar(255) NOT NULL, 
lastName varchar(255) NOT NULL, 
empID int NOT NULL UNIQUE,
isActive varchar(9),
empRole varchar(9),
manager varchar(255), 
password varchar(8),
stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT roleCheck CHECK (empRole IN ('GManager', 'SManager', 'Cashier')),
CONSTRAINT activeCheck CHECK (isActive IN ('Active', 'Inactive')),
CONSTRAINT employees_pkey PRIMARY KEY (recordID)
);
