--Challenge 1: Logging Errors
--1. Throw an error for non-existent orders
DECLARE @SalesOrderID int = 0;

--Selects minimum order ID
--SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader;

BEGIN TRY
	--Test to verify existence of order ID 
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		--Throw custom error
		DECLARE @Err varchar(25);
		SET @Err = 'Order ' + cast(@SalesOrderID as varchar) + ' does not exist.';
		THROW 50001, @Err, 0
	END
	ELSE
	BEGIN
		--Deletes existing order 
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
	END
END TRY

--2. Handle errors
DECLARE @SalesOrderID int = 0;

--Selects minimum order ID
--SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader;

BEGIN TRY
	--Test to verify existence of order ID 
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		--Throw custom error
		DECLARE @Err varchar(25);
		SET @Err = 'Order ' + cast(@SalesOrderID as varchar) + ' does not exist.';
		THROW 50001, @Err, 0
	END
	ELSE
	BEGIN
		--Deletes existing order 
		DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

		DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
	END
END TRY
BEGIN CATCH
	--Print error
	PRINT ERROR_MESSAGE();
END CATCH

--Challenge 2: Ensuring Data Consistency
--1. Implement a transaction
DECLARE @SalesOrderID int = 0;

--Selects minimum order ID
SELECT @SalesOrderID = MIN(SalesOrderID) FROM SalesLT.SalesOrderHeader;

BEGIN TRY
	--Test to verify existence of order ID 
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @SalesOrderID)
	BEGIN
		--Throw custom error
		DECLARE @Err varchar(25);
		SET @Err = 'Order ' + cast(@SalesOrderID as varchar) + ' does not exist.';
		THROW 50001, @Err, 0
	END
	ELSE
	BEGIN
		BEGIN TRANSACTION
			--Deletes existing order 
			DELETE FROM SalesLT.SalesOrderDetail WHERE SalesOrderID = @SalesOrderID;

			--Uncomment to test unexpected error
			--THROW 50001, 'Unexpected error', 0 

			DELETE FROM SalesLT.SalesOrderHeader WHERE SalesOrderID = @SalesOrderID;
		COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		--Rollback & re-throw error 
		ROLLBACK TRANSACTION;
		THROW;
	END
	ELSE
	BEGIN
		--Print error
		PRINT ERROR_MESSAGE();
	END
END CATCH
