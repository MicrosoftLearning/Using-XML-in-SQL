-- using a namespace with RAW mode
WITH XMLNAMESPACES ('http://aw/order' AS ord)
SELECT SalesOrderID AS 'ord:SalesOrderID',
	   OrderDate AS 'ord:OrderDate',
	   CustomerID AS 'ord:CustomerID',
	   TotalDue AS 'ord:TotalDue'
FROM SalesLT.SalesOrderHeader
WHERE SalesOrderID = 71774
FOR XML RAW('ord:order'), ELEMENTS;

-- using a namespace with AUTO mode
WITH XMLNAMESPACES ('http://aw/order' AS ord)
SELECT [ord:order].SalesOrderID AS 'ord:SalesOrderID',
	   [ord:order].OrderDate AS 'ord:OrderDate',
	   [ord:order].CustomerID AS 'ord:CustomerID',
	   [ord:order].TotalDue AS 'ord:TotalDue',
	   [ord:LineItem].ProductID AS 'ord:ProductID',
	   [ord:LineItem].OrderQty AS 'ord:OrderQty',
	   [ord:LineItem].UnitPrice AS 'ord:UnitPrice'
FROM SalesLT.SalesOrderHeader AS [ord:order]
INNER JOIN SalesLT.SalesOrderDetail AS [ord:LineItem]
ON [ord:LineItem].SalesOrderID = [ord:order].SalesOrderID
WHERE [ord:order].SalesOrderID = 71774
FOR XML AUTO, ELEMENTS;

-- using a namespace with PATH mode
WITH XMLNAMESPACES ('http://aw/order' AS ord)
SELECT o.SalesOrderID AS '@ord:invoiceno',
	   o.OrderDate AS '@ord:date',
	   o.CustomerID AS 'ord:customer/@ord:id',
	   c.CompanyName AS 'ord:customer',
	   o.TotalDue AS 'ord:totaldue'
FROM SalesLT.SalesOrderHeader AS o
JOIN SalesLT.Customer AS c
ON o.CustomerID = c.CustomerID
WHERE SalesOrderID = 71774
FOR XML PATH('ord:invoice');