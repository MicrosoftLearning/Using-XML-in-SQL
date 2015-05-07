SELECT o.SalesOrderID AS '@invoiceno',
	   o.OrderDate AS '@date',
	   o.CustomerID AS 'customer/@id',
	   c.CompanyName AS 'customer',
	   o.TotalDue AS 'totaldue'
FROM SalesLT.SalesOrderHeader AS o
JOIN SalesLT.Customer AS c
ON o.CustomerID = c.CustomerID
WHERE SalesOrderID = 71774
FOR XML PATH('invoice');

-- Nested subelememnts
SELECT SalesOrderID AS 'invoiceno',
	   OrderDate AS 'date',
	   CustomerID AS 'customer/@id',
	   (SELECT ProductID AS 'item/@productid',
	           OrderQty AS 'item/@quantity',
	           UnitPrice AS 'item/@unitprice'
		FROM SalesLT.SalesOrderDetail AS sod
		WHERE sod.SalesOrderID = soh.SalesOrderID
		FOR XML PATH(''), ROOT('items')),
	    TotalDue AS 'totaldue'
FROM SalesLT.SalesOrderHeader AS soh
WHERE SalesOrderID = 71774
FOR XML PATH(''), ROOT('invoice');
