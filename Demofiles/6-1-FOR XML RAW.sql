-- RAW Mode
SELECT 	c.CustomerID AS CustID, c.CompanyName,
        soh.SalesOrderID, soh.OrderDate, soh.TotalDue
FROM SalesLT.Customer AS c 
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY c.CustomerID
FOR XML RAW;

-- Named row tags
SELECT 	c.CustomerID AS CustID, c.CompanyName,
        soh.SalesOrderID, soh.OrderDate, soh.TotalDue
FROM SalesLT.Customer AS c 
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY c.CustomerID
FOR XML RAW('Order');

-- Root element
SELECT 	c.CustomerID AS CustID, c.CompanyName,
        soh.SalesOrderID, soh.OrderDate, soh.TotalDue
FROM SalesLT.Customer AS c 
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY c.CustomerID
FOR XML RAW('Order'), ROOT('Orders');

--Element-centric output
SELECT 	c.CustomerID AS CustID, c.CompanyName,
        soh.SalesOrderID, soh.OrderDate, soh.TotalDue
FROM SalesLT.Customer AS c 
INNER JOIN SalesLT.SalesOrderHeader AS soh
ON c.CustomerID = soh.CustomerID
ORDER BY c.CustomerID
FOR XML RAW('Order'), ROOT('Orders'), ELEMENTS;
