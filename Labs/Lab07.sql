--Challenge 1: Retrieve Product Information
--1. Retrieve product model descriptions
SELECT p.ProductID, p.Name AS ProductName, v.Name AS ModelName, v.Summary 
FROM SalesLT.Product AS p
JOIN SalesLT.vProductModelCatalogDescription AS v
ON p.ProductModelID = v.ProductModelID
ORDER BY ProductID;

--2. Create a table of distinct colors
DECLARE @Colors AS TABLE (Color varchar(15));

INSERT INTO @Colors
SELECT DISTINCT Color 
FROM SalesLT.Product;

SELECT ProductID, Name, Color 
FROM SalesLT.Product
WHERE Color IN (SELECT Color FROM @Colors);

--3. Retrieve product parent categories
SELECT c.ParentProductCategoryName AS ParentCategory, 
		c.ProductCategoryName AS Category,
		p.ProductID, p.Name AS ProductName	
FROM SalesLT.Product AS p
JOIN dbo.ufnGetAllCategories() AS c
ON p.ProductCategoryID = c.ProductCategoryID
ORDER BY ParentCategory, Category, ProductName;

--Challenge 2: Retrieve customer sales revenue
--1. Retrieve sales revenue by customer and contact
SELECT CompanyContact, SUM(SalesAmount) AS Revenue
FROM
	(SELECT CONCAT(c.CompanyName, CONCAT(' (' + c.FirstName + ' ', + c.LastName + ')')), oh.TotalDue
	 FROM SalesLT.SalesOrderHeader AS oh
	 JOIN SalesLT.Customer AS c
	 ON oh.CustomerID = c.CustomerID) AS CustomerSales(CompanyContact, SalesAmount) 
GROUP BY CompanyContact
ORDER BY CompanyContact;