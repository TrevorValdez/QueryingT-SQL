--Challenge 1: Retrieve Data for Transportation Reports
--1. Retrieve a list of cities 
SELECT DISTINCT City, StateProvince
FROM SalesLT.Address;

--2. Retrieve the heaviest products
SELECT TOP 10 PERCENT Name
FROM SalesLT.Product
ORDER BY Weight DESC;

--3. Retrieve the heaviest 100 products not including the heaviest ten
SELECT Name
FROM SalesLT.Product
ORDER BY Weight DESC 
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;

--Challenge 2: Retrieve Product Data
--1. Retrieve product details for product model 1
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE Product.ProductModelID = 1;

--2. Filter products by color and size
SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color IN ('black','red','white')
AND Size IN ('S', 'M');

--3. Filter products by product number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK%';

--4. Retrieve specific products by product number
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product
WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';