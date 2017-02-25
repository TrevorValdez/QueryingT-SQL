--Challenge 1: Retrieve Product Information
--1. Retrieve the name and approximate weight of each product 
SELECT ProductID, 
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight
FROM SalesLT.Product;

--2. Retrieve the year and month in which products were first sold
SELECT ProductID, 
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) AS SellStartYear,
		DATENAME(m, SellStartDate) AS SellStartMonth
FROM SalesLT.Product;

--3. Extract product types from product numbers
SELECT ProductID, 
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) AS SellStartYear,
		DATENAME(m, SellStartDate) AS SellStartMonth,
		LEFT(Product, 2) AS ProductType
FROM SalesLT.Product;

--4. Retrieve only products with a numeric size
SELECT ProductID, 
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) AS SellStartYear,
		DATENAME(m, SellStartDate) AS SellStartMonth,
		LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(Size)=1;

--Challenge 2: Rank customers by revenue
--1. Retrieve companies ranked by sales totals
SELECT c.CompanyName, oh.TotalDue AS Revenue,
	RANK() OVER (ORDER BY TotalDue DESC) AS RankByRevenue  
FROM SalesLT.SalesOrderHeader AS oh
JOIN SalesLT.Customer AS c
ON oh.CustomerID = c.CustomerID;

--Challenge 3: Aggregate Product Sales
--1. Retrieve total sales by product
SELECT p.Name, SUM(LineTotal) AS TotalRevenue 
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

--2. Filter the product sales list to include only products that cost over $1,000
SELECT p.Name, SUM(LineTotal) AS TotalRevenue 
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
ORDER BY TotalRevenue DESC;

--3. Filter the product sales groups to include only total sales over $20,000
SELECT p.Name, SUM(LineTotal) AS TotalRevenue 
FROM SalesLT.SalesOrderDetail AS od
JOIN SalesLT.Product AS p
ON od.ProductID = p.ProductID
WHERE p.ListPrice > 1000
GROUP BY p.Name
HAVING SUM(LineTotal) > 20000
ORDER BY TotalRevenue DESC;