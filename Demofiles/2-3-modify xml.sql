-- Use modify to insert XML
UPDATE dbo.SalesOrder
SET OrderItems.modify('insert <item id="100" quantity="3"/>
					   as last 
					   into (/items[1])')
WHERE OrderID = 3;

SELECT * FROM dbo.SalesOrder
WHERE OrderID = 3;

-- insert element with text value
UPDATE dbo.SalesOrder
SET OrderItems.modify('insert element order {sql:column("OrderID")}
					   as first
					   into (/items[1])');

SELECT * FROM dbo.SalesOrder;

-- insert attribute
DECLARE @now DATETIME = GETDATE();

UPDATE dbo.SalesOrder
SET OrderItems.modify('insert attribute lastupdated {sql:variable("@now")}
					   into (/items[1])');

SELECT * FROM dbo.SalesOrder;


-- Use modify to update XML
UPDATE dbo.SalesOrder
SET OrderItems.modify('replace value of (/items[1]/@count)
					   with "4"')
WHERE OrderID = 3;

SELECT * FROM dbo.SalesOrder
WHERE OrderID = 3;

-- Use a function
DECLARE @itemcount int;
SELECT @itemcount = OrderItems.value ('count(/items[1]/item)', 'int')
FROM dbo.SalesOrder
WHERE OrderID = 3;

PRINT @itemcount;

UPDATE dbo.SalesOrder
SET OrderItems.modify('replace value of (/items[1]/@count)
					   with sql:variable("@itemcount")')
WHERE OrderID = 3;

SELECT * FROM dbo.SalesOrder
WHERE OrderID = 3;


-- Use modify to delete XML
UPDATE dbo.SalesOrder
SET OrderItems.modify('delete /items/order');

SELECT * FROM dbo.SalesOrder;