--Challenge 1: Retrieve Customer Data
--1. Retrieve customer details
Select *
From SalesLT.Customer;

--2. Retrieve customer name data
Select Title, FirstName, MiddleName, LastName, Suffix
From SalesLT.Customer;

--3. Retrieve customer names and phone numbers
Select SalesPerson, Title + ' ' + LastName As CustomerName, Phone
From SalesLT.Customer;

--Challenge 2: Retrieve Customer and Sales Data
--1. Retrieve a list of customer companies
Select STR(CustomerID) + ': ' + CompanyName As CompanyList
From SalesLT.Customer;

--2. Retrieve a list of sales order revisions
Select Cast(SalesOrderNumber As varchar(20)) + ' (' + CAST(RevisionNumber AS VARCHAR (10)) + ')' As OrderNumberRevision, 
	Convert (nvarchar(30), OrderDate, 102) As ANSIStandardFormat 	
From SalesLT.SalesOrderHeader;

--Challenge 3: Retrieve Customer Contact Details
--1. Retrieve customer contact names with middle names if known
Select FirstName + ISNULL(' '+ MiddleName + ' ', '') + LastName AS CustomerName
From SalesLT.Customer;

--2. Retrieve primary contact details
/* UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1; */
SELECT CustomerID, ISNULL(EmailAddress, Phone)  AS PrimaryContact
FROM SalesLT.Customer;

--3. Retrieve shipping status
/* UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899; */
SELECT SalesOrderID, 
	CASE
		WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
		ELSE 'Shipped'
	END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;

