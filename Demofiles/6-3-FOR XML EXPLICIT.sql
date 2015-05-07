SELECT 1 AS Tag, NULL AS Parent,
       SalesOrderID AS [Invoice!1!InvoiceNo],
	   OrderDate AS [Invoice!1!Date],
	   CustomerID AS [Invoice!1!CustomerID!Element],
	   TotalDue AS [Invoice!1!TotalDue!Element]
FROM SalesLT.SalesOrderHeader
WHERE SalesOrderID = 71774
FOR XML EXPLICIT;

-- Mulitple tables/elements
SELECT 1 AS Tag, NULL AS Parent,
       SalesOrderID AS [Invoice!1!InvoiceNo],
	   OrderDate AS [Invoice!1!Date],
	   CustomerID AS [Invoice!1!CustomerID!Element],
	   TotalDue AS [Invoice!1!TotalDue!Element],
	   NULL AS [Item!2!ProductID],
	   NULL AS [Item!2!OrderQty],
	   NULL AS [Item!2!UnitPrice]
FROM SalesLT.SalesOrderHeader
WHERE SalesOrderID = 71774
UNION ALL
SELECT 2 AS Tag, 1 AS Parent,
       SalesOrderID AS [Invoice!1!InvoiceNo],
	   NULL AS [Invoice!1!Date],
	   NULL AS [Invoice!1!CustomerID!Element],
	   NULL AS [Invoice!1!TotalDue!Element],
	   ProductID AS ProductID,
	   OrderQty AS OrderQty,
	   UnitPrice AS UnitPrice
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 71774
FOR XML EXPLICIT;


-- Creating a container element
SELECT 1 AS Tag, NULL AS Parent,
       SalesOrderID AS [Invoice!1!InvoiceNo],
	   OrderDate AS [Invoice!1!Date],
	   CustomerID AS [Invoice!1!CustomerID!Element],
	   TotalDue AS [Invoice!1!TotalDue!Element],
	   NULL AS [Items!2],
	   NULL AS [Item!3!ProductID],
	   NULL AS [Item!3!OrderQty],
	   NULL AS [Item!3!UnitPrice]
FROM SalesLT.SalesOrderHeader
WHERE SalesOrderID = 71774
UNION ALL
SELECT 2 AS Tag, 1 AS Parent,
	   SalesOrderID AS [Invoice!1!InvoiceNo],
	   NULL AS [Invoice!1!Date],
	   NULL AS [Invoice!1!CustomerID!Element],
	   NULL AS [Invoice!1!TotalDue!Element],
	   NULL AS [Invoice!2],
	   NULL AS [Item!3!ProductID],
	   NULL AS [Item!3!OrderQty],
	   NULL AS [Item!3!UnitPrice]
FROM SalesLT.SalesOrderHeader
WHERE SalesOrderID = 71774
UNION ALL
SELECT 3 AS Tag, 2 AS Parent,
       SalesOrderID AS [Invoice!1!InvoiceNo],
	   NULL AS [Invoice!1!Date],
	   NULL AS [Invoice!1!CustomerID!Element],
	   NULL AS [Invoice!1!TotalDue!Element],
	   'Items' AS [Invoice!2!Items!Element],
	   ProductID AS ProductID,
	   OrderQty AS OrderQty,
	   UnitPrice AS UnitPrice
FROM SalesLT.SalesOrderDetail
WHERE SalesOrderID = 71774
FOR XML EXPLICIT;
