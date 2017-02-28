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

-- This has been checked in MySQL on Turing. When Heroku comes back up, it can be tested. 
-- You can use the query at the end and replace the last with new information to test it out.
-- The only issue here is finding a way to reference the manager column from the empID/recordID of the listed manager. 
-- I feel like there must be a way to do this with a lookup....
-- Definitely need a constraint that will only allow you to toss it in if it is an existing ID and listed as GManager or SManager
-- Also need to create the index b/t recordID and empID.
-- [test notes: look into adding default to isActive and empRole, figure out how to associate manager w/empID]
-- 
-- 2/28/17 VLH

CREATE TABLE Employees
(
recordID char(32),
firstName varchar(255) NOT NULL, 
lastName varchar(255) NOT NULL, 
empID int NOT NULL UNIQUE,
isActive varchar(9) NOT NULL,
empRole varchar(9) NOT NULL,
manager varchar(255), 
password varchar(8) NOT NULL UNIQUE,
stamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT roleCheck CHECK (empRole IN ('GManager', 'SManager', 'Cashier')),
CONSTRAINT activeCheck CHECK (isActive IN ('Active', 'Inactive')),
CONSTRAINT employees_pkey PRIMARY KEY (recordID)
);

INSERT INTO Employees 
(recordID, firstName, lastName, empID, isActive, empRole, manager, password, stamp) 
VALUES 
('99999999999999999999999999999999', 'John', 'Smith', 999999999, 'Active', 'GManager', NULL, 'password', CURTIME()
);
