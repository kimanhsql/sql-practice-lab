-- ============================================================
-- ALTER TABLES
-- ============================================================

-- Question 2
-- Add the Notes column to the PRODUCTS table
-- with the data type VARCHAR(20).

ALTER TABLE PRODUCTS
    ADD Notes VARCHAR(20);
GO


-- Question 3
-- Add the CustomerType column to the CUSTOMERS table
-- with the data type TINYINT.

ALTER TABLE CUSTOMERS
    ADD CustomerType TINYINT;
GO


-- Question 4
-- Change the data type of the Notes column
-- in the PRODUCTS table to VARCHAR(100).

ALTER TABLE PRODUCTS
    ALTER COLUMN Notes VARCHAR(100);
GO


-- Question 5
-- Delete the Notes column from the PRODUCTS table.

ALTER TABLE PRODUCTS
    DROP COLUMN Notes;
GO


-- Question 6
-- Configure the CustomerType column in the CUSTOMERS table
-- to store values such as 'Vang lai', 'Thuong xuyen', 'Vip', etc.

ALTER TABLE CUSTOMERS
    ADD CONSTRAINT CHK_CustomerType
        CHECK (CustomerType IN ('Vang lai', 'Thuong xuyen', 'Vip'));
GO


-- Question 7
-- The unit of a product can only be one of the following values:
-- ('Cây', 'hop', 'cai', 'quyen', 'chuc').

ALTER TABLE PRODUCTS
    ADD CONSTRAINT CHK_Unit
        CHECK (Unit IN ('Cây', 'hop', 'cai', 'quyen', 'chuc'));
GO


-- Question 8
-- The selling price of a product must be 500 VND or higher.

ALTER TABLE PRODUCTS
    ADD CONSTRAINT CHK_Price
        CHECK (Price >= 500);
GO