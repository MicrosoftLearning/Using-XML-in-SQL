-- Create a table with XML data
IF EXISTS (SELECT * FROM sys.sysobjects
           WHERE name = 'SalesOrder')
	DROP TABLE dbo.SalesOrder;
GO

CREATE TABLE dbo.SalesOrder
(OrderID int IDENTITY PRIMARY KEY CLUSTERED,
 OrderDate date DEFAULT GETDATE(),
 OrderItems xml);

 INSERT INTO dbo.SalesOrder (OrderItems)
 VALUES
 ('<items count="2">
	<item id="561" quantity="1"></item>
	<item id="127" quantity="2"></item>
   </items>'),
 ('<items count="1">
	<item id="129" quantity="1"></item>
   </items>'),
 ('<items count="2">
	<item id="561" quantity="1"></item>
	<item id="167" quantity="1"></item>
   </items>') ;

SELECT * FROM dbo.SalesOrder;

-- use the query method to return XML fragments
SELECT	OrderID,
		OrderDate,
		OrderItems.query('/items/item') AS Items
FROM dbo.SalesOrder;

-- shorthand for all <item> descendants
SELECT	OrderID,
		OrderDate,
		OrderItems.query('//item') AS Items
FROM dbo.SalesOrder;

-- include literal XML tags
SELECT	OrderID,
		OrderDate,
		OrderItems.query('<products> {/items/item} </products>') AS Products
FROM dbo.SalesOrder;

-- Retrieve an attribute
SELECT	OrderID,
		OrderDate,
		OrderItems.query('<lineitems itemcount="{/items/@count}" />') AS LineItems
FROM dbo.SalesOrder;

-- attributes from multiple elements
SELECT	OrderID,
		OrderDate,
		OrderItems.query('<product id="{/items/item/@id}" />') AS Products
FROM dbo.SalesOrder;

-- attribute from a specific element instance
SELECT	OrderID,
		OrderDate,
		OrderItems.query('<product id="{/items/item[1]/@id}" />') AS Products
FROM dbo.SalesOrder;

-- Binding a column
SELECT	OrderID,
		OrderDate,
		OrderItems.query('<order orderid="{sql:column("OrderID")}" itemcount="{/items/@count}" />') AS SalesOrder
FROM dbo.SalesOrder;

-- Use FLWOR
SELECT OrderID,
	   OrderItems.query ('for $i in /items/item
						  where $i/@quantity = 1
						  order by $i/@id
						  return $i') As SingleItems
FROM dbo.SalesOrder;

-- use the value method to return a scalar value
SELECT	OrderID,
		OrderDate,
		OrderItems.value('/items[1]/@count', 'int') AS ItemCount
FROM dbo.SalesOrder;

-- Use exist method to check existence of a node
SELECT * FROM dbo.SalesOrder
WHERE OrderItems.exist('/items/item') = 1;

-- check for a specific node value
SELECT * FROM dbo.SalesOrder
WHERE OrderItems.exist('/items[@count > 1]') = 1;

SELECT * FROM dbo.SalesOrder
WHERE OrderItems.exist('/items/item[@id = 561]') = 1;

-- Cross apply nodes to generate relational results
SELECT OrderID,
	   itemsTable.itemXml.value('./@id', 'int') AS Product,
	   itemsTable.itemXml.value('./@quantity', 'int') AS Quantity
FROM dbo.SalesOrder
CROSS APPLY OrderItems.nodes('/items/item') AS itemsTable(itemXml);

-- Querying XML with namespaces
DECLARE @x XML;
SET @x =   '<?xml version="1.0" encoding="ISO-8859-1"?>
			<o:order o:id="123456" o:date="2015-01-01"
					 xmlns:o="http://aw/order" xmlns:s="http://aw/sales" 
					 xmlns:c="http://aw/customer" xmlns:p="http://aw/product">
				<s:salesperson s:id="123">
					<s:name>Naomi Sharp</s:name>
				</s:salesperson>
				<c:customer c:id="921">
					<c:name>Dan Drayton</c:name>
				</c:customer>
				<o:items>
					<o:item p:id="561" o:quantity="1"></o:item>
					<o:item p:id="127" o:quantity="2"></o:item>
				</o:items>
			 </o:order>';


SELECT @x.query('declare namespace ord="http://aw/order";
                 declare namespace sls="http://aw/sales";
				 <employee id="{/ord:order/sls:salesperson/@sls:id }" />') AS Employee;


WITH XMLNAMESPACES ('http://aw/order' AS ord,
					'http://aw/sales' AS sls,
					'http://aw/customer' AS cst)
SELECT	@x.value('/ord:order[1]/@ord:id', 'int') AS OrderID,
		@x.value('/ord:order[1]/sls:salesperson[1]/@sls:id', 'int') AS Employee,
	    @x.value('/ord:order[1]/cst:customer[1]/@cst:id', 'int') AS Customer;

