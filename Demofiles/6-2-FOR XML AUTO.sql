-- attribute centric fragment
SELECT [Order].SalesOrderID,
	   [Order].OrderDate,
	   [Order].CustomerID,
	   [Order].TotalDue,
	   [LineItem].ProductID,
	   [LineItem].OrderQty,
	   [LineItem].UnitPrice
FROM SalesLT.SalesOrderHeader AS [Order]
INNER JOIN SalesLT.SalesOrderDetail AS LineItem
ON LineItem.SalesOrderID = [Order].SalesOrderID
ORDER BY [Order].SalesOrderID
FOR XML AUTO;

-- specify root element
SELECT [Order].SalesOrderID,
	   [Order].OrderDate,
	   [Order].CustomerID,
	   [Order].TotalDue,
	   [LineItem].ProductID,
	   [LineItem].OrderQty,
	   [LineItem].UnitPrice
FROM SalesLT.SalesOrderHeader AS [Order]
INNER JOIN SalesLT.SalesOrderDetail AS LineItem
ON LineItem.SalesOrderID = [Order].SalesOrderID
ORDER BY [Order].SalesOrderID
FOR XML AUTO, ROOT('Orders');

-- Element-centric
SELECT [Order].SalesOrderID,
	   [Order].OrderDate,
	   [Order].CustomerID,
	   [Order].TotalDue,
	   [LineItem].ProductID,
	   [LineItem].OrderQty,
	   [LineItem].UnitPrice
FROM SalesLT.SalesOrderHeader AS [Order]
INNER JOIN SalesLT.SalesOrderDetail AS LineItem
ON LineItem.SalesOrderID = [Order].SalesOrderID
ORDER BY [Order].SalesOrderID
FOR XML AUTO, ROOT('Orders'), ELEMENTS;
