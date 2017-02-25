--Challenge 1: Retrieve Product Price Information
--1. Retrieve products whose list price is higher than the average unit price  
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product AS p
WHERE ListPrice >
(SELECT AVG(UnitPrice)
FROM SalesLT.SalesOrderDetail)
ORDER BY ProductID;

--2. Retrieve products with a list price of $100 or more that have been sold for less than $100
SELECT ProductID, Name, ListPrice
FROM SalesLT.Product
WHERE ProductID IN
(SELECT ProductID
FROM SalesLT.SalesOrderDetail
WHERE UnitPrice < 100)
AND ListPrice >= 100
ORDER BY ProductID;

--3. Retrieve the cost, list price, and average selling price for each product
SELECT ProductID, Name, StandardCost, ListPrice,
		(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail AS oh
		WHERE p.ProductID = oh.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS p
ORDER BY p.ProductID;

--4. Retrieve products that have an average selling price that is lower than the cost
SELECT ProductID, Name, StandardCost, ListPrice,
		(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail AS oh
		WHERE p.ProductID = oh.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS p
WHERE StandardCost >
(SELECT AVG(UnitPrice)
		FROM SalesLT.SalesOrderDetail AS oh
		WHERE p.ProductID = oh.ProductID)
ORDER BY p.ProductID;

--Challenge 2: Retrieve Customer Information
--1. Retrieve customer information for all sales orders
SELECT oh.SalesOrderID, oh.CustomerID, ci.FirstName, ci.LastName, oh.TotalDue
FROM SalesLT.SalesOrderHeader AS oh
CROSS APPLY dbo.ufnGetCustomerInformation(oh.CustomerID) AS ci
ORDER BY oh.SalesOrderID;

--2. Retrieve customer address information
SELECT ca.CustomerID, ci.FirstName, ci.LastName, a.AddressLine1, a.City
FROM SalesLT.Address AS a
JOIN SalesLT.CustomerAddress AS ca
ON a.AddressID = ca.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(ca.CustomerID) AS ci
ORDER BY ca.CustomerID;