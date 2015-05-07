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

SELECT @x;

CREATE TABLE #SalesOrder
(OrderID int IDENTITY,
 OrderDate datetime DEFAULT GETDATE(),
 OrderItems xml);

 INSERT INTO #SalesOrder (OrderItems)
 VALUES
 ('<item id="561" quantity="1"></item>
   <item id="127" quantity="2"></item>');

SELECT * FROM #SalesOrder;
