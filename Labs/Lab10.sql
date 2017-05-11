--Challenge 1: Creating scripts to insert sales orders
--1. Write code to insert an order header
DECLARE @OrderDate DateTime = GETDATE();
DECLARE @DueDate DateTime = DATEADD(dd, 7, GETDATE());
DECLARE @CustomerID int = 1;
DECLARE @OrderID int;

SET @OrderID = NEXT VALUE FOR SalesLT.SalesOrderNumber;

INSERT INTO SalesLT.SalesOrderHeader (SalesOrderID, OrderDate, DueDate, CustomerID, ShipMethod)
VALUES
(@OrderID, @OrderDate, @DueDate, @CustomerID, 'CARGO TRANSPORT 5');

PRINT @OrderID;

--2. Write code to insert an order detail
DECLARE @SalesOrderID int;
DECLARE @ProductID int = 760;
DECLARE @Quantity int = 1;
DECLARE @UnitPrice money = 782.99;

SET @SalesOrderID = 0;
---SET @SalesOrderID = 1; 

IF EXISTS (SELECT * FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID)
BEGIN
	INSERT INTO SalesLT.SalesOrderDetail (SalesOrderID, OrderQty, ProductID, UnitPrice)
	VALUES
	(@SalesOrderID, @Quantity, @ProductID, @UnitPrice)
END
ELSE
BEGIN
	PRINT 'The order does not exist'
END

--Challenge 2: Updating Bike Prices
--1. Write WHILE loop update bike prices
DECLARE @MktAvg money = 2000;
DECLARE @MktMax money = 5000;
DECLARE @AWAvg money;
DECLARE @AWMax money;

SELECT @AWAvg = AVG(ListPrice), @AWMax = MAX(ListPrice)
FROM SalesLT.Product
WHERE ProductCategoryID IN
	(SELECT DISTINCT ProductCategoryID
	 FROM SalesLT.vGetAllCategories
	 WHERE ParentProductCategoryName = 'Bikes');

WHILE @AWAvg < @MktAvg
BEGIN
	UPDATE SalesLT.Product
	SET ListPrice = ListPrice * 1.1
	WHERE ProductCategoryID IN
		(SELECT DISTINCT ProductCategoryID 
		 FROM SalesLT.vGetAllCategories
		 WHERE ParentProductCategoryName = 'Bikes');

		 SELECT @AWAvg = AVG(ListPrice), @AWMax = MAX(ListPrice)
		 FROM SalesLT.Product
		 WHERE ProductCategoryID IN
		 (SELECT DISTINCT ProductCategoryID
		  FROM SalesLT.vGetAllCategories
		  WHERE ParentProductCategoryName = 'Bikes')

IF @AWMax >= @MktMax
	BREAK
ELSE
	CONTINUE
END

PRINT 'New avg bike price:' + CONVERT(varchar, @AWAvg);
PRINT 'New max bike price:' + CONVERT(varchar, @AWMax);
