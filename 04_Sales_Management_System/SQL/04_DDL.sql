-- ============================================================
-- SALES MANAGEMENT SYSTEM
-- DATA DEFINITION LANGUAGE (DDL)
-- ============================================================

USE SALES_DB;
GO


-- Question 2
-- Add the `Notes` column with data type `VARCHAR(20)`
-- to the `PRODUCTS` table.

ALTER TABLE PRODUCTS
	ADD Notes VARCHAR(20);
GO


-- Question 3
-- Add the `CustomerType` column with data type `TINYINT`
-- to the `CUSTOMERS` table.

ALTER TABLE CUSTOMERS
	ADD CustomerType TINYINT;
GO


-- Question 4
-- Alter the data type of the `Notes` column
-- in the `PRODUCTS` table to `VARCHAR(100)`.

ALTER TABLE PRODUCTS
	ALTER COLUMN Notes VARCHAR(100);
GO


-- Question 5
-- Drop the `Notes` column from the `PRODUCTS` table.

ALTER TABLE PRODUCTS
	DROP COLUMN Notes;
GO


-- Question 6
-- Configure the `CustomerType` column in the `CUSTOMERS` table
-- to store values such as `'Vang lai'`,
-- `'Thuong xuyen'`, `'Vip'`, etc.

ALTER TABLE CUSTOMERS
	ADD CONSTRAINT CHK_CustomerType
		CHECK(CustomerType IN('Vang lai','Thuong xuyen','Vip'));
GO


-- Question 7
-- Restrict product units (`Unit`) to only allow:
-- `('Cây', 'hop', 'cai', 'quyen', 'chuc')`.

ALTER TABLE PRODUCTS
	ADD CONSTRAINT CHK_Unit
		CHECK(Unit IN('Cây','hop','cai','quyen','chuc'));
GO


-- Question 8
-- Ensure the selling price (`Price`) of a product
-- is 500 VND or higher.

ALTER TABLE PRODUCTS
	ADD CONSTRAINT CHK_Price
		CHECK(Price>=500);
GO


-- Question 9
-- Each purchase must include at least one product.

CREATE TRIGGER TRG_PreventDeletingLastProduct
ON INVOICE_DETAILS
AFTER DELETE
AS
BEGIN
    DECLARE @DeletedProduct VARCHAR(4);
    DECLARE @RemainingCount INT;

    SELECT @DeletedProduct = ProductID
    FROM deleted;

    SELECT @RemainingCount = COUNT(*)
    FROM INVOICE_DETAILS
    WHERE ProductID = @DeletedProduct;

    IF (@RemainingCount = 0)
    BEGIN
        PRINT 'Error: The purchase must include at least one product. Deletion not allowed!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 10
-- A member customer's registration date (`RegistrationDate`) must be later than
-- their date of birth (`DateOfBirth`).

ALTER TABLE CUSTOMERS
    ADD CONSTRAINT CHK_RegistrationDate_DateOfBirth
        CHECK (RegistrationDate > DateOfBirth);
GO


-- Question 11
-- An invoice date (`InvoiceDate`) for a member customer
-- must be greater than or equal to their registration date
-- (`RegisteredDate`).

CREATE TRIGGER TRG_CheckInvoiceDate_CustomerReg
ON INVOICES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted AS i
        JOIN CUSTOMERS AS c
            ON i.CustomerID = c.CustomerID
        WHERE i.InvoiceDate < c.RegisteredDate
    )
    BEGIN
        PRINT 'Error: Invoice date cannot be earlier than the customer registration date!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 12
-- An invoice date (`InvoiceDate`) created by an employee
-- must be greater than or equal to their hire date (`HireDate`).

CREATE TRIGGER TRG_CheckInvoiceDate_EmployeeHire
ON INVOICES
AFTER INSERT, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT 1
        FROM inserted AS i
        JOIN EMPLOYEES AS e
            ON i.EmployeeID = e.EmployeeID
        WHERE i.InvoiceDate < e.HireDate
    )
    BEGIN
        PRINT 'Error: Sale date cannot be earlier than the employee hire date!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 13
-- Each invoice must contain at least one invoice detail item.

CREATE TRIGGER TRG_EnsureAtLeastOneDetail
ON INVOICE_DETAILS
AFTER DELETE, UPDATE
AS
BEGIN
    IF EXISTS
    (
        SELECT d.InvoiceID
        FROM deleted AS d
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM INVOICE_DETAILS AS c
            WHERE c.InvoiceID = d.InvoiceID
        )
    )
    BEGIN
        PRINT 'Error: Each invoice must have at least one detail item. Deleting the last detail is not allowed!';
        ROLLBACK TRANSACTION;
    END;
END;
GO


-- Question 14
-- The total value of an invoice (`TotalAmount`) must equal
-- the sum of line amounts (`Quantity * Price`) of its items.

CREATE TRIGGER TRG_UpdateInvoiceTotalValue
ON INVOICE_DETAILS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE i
    SET i.TotalAmount = ISNULL(InvoiceCalculation.TotalAmount, 0)
    FROM INVOICES AS i
    LEFT JOIN
    (
        SELECT id.InvoiceID, SUM(id.Quantity * sp.Price) AS TotalAmount
        FROM INVOICE_DETAILS AS id
        JOIN PRODUCTS AS sp
            ON id.ProductID = sp.ProductID
        GROUP BY id.InvoiceID
    ) AS InvoiceCalculation ON i.InvoiceID = InvoiceCalculation.InvoiceID
    WHERE i.InvoiceID IN
    (
        SELECT InvoiceID FROM inserted
        UNION
        SELECT InvoiceID FROM deleted
    );
END;
GO


-- Question 15
-- A customer's revenue/sales total (`SalesAmount`) must equal
-- the sum of invoice values (`TotalAmount`) they have purchased.

CREATE TRIGGER TRG_UpdateCustomerSales
ON INVOICES
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    UPDATE c
    SET c.SalesAmount = ISNULL(SalesCalculation.TotalSales, 0)
    FROM CUSTOMERS AS c
    LEFT JOIN
    (
        SELECT CustomerID, SUM(TotalAmount) AS TotalSales
        FROM INVOICES
        GROUP BY CustomerID
    ) AS SalesCalculation ON c.CustomerID = SalesCalculation.CustomerID
    WHERE c.CustomerID IN
    (
        SELECT CustomerID FROM inserted
        UNION
        SELECT CustomerID FROM deleted
    );
END;
GO