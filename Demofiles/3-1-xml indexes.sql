-- Include Actual Execution Plan

-- Query with no XML indexes
SELECT OrderID,
	   OrderItems.query ('for $i in /items/item
						  where $i/@quantity > 0
						  order by $i/@id
						  return $i') As Items
FROM dbo.SalesOrder
WHERE OrderItems.exist('/items[@count > 1]') = 1;

-- Create primary XML index
CREATE PRIMARY XML INDEX XML_Order_Items
ON dbo.SalesOrder (OrderItems);

SELECT OrderID,
	   OrderItems.query ('for $i in /items/item
						  where $i/@quantity > 0
						  order by $i/@id
						  return $i') As Items
FROM dbo.SalesOrder
WHERE OrderItems.exist('/items[@count > 1]') = 1;

-- Create secondary XML indexes
CREATE XML INDEX XML_Order_Items_Path
ON dbo.SalesOrder (OrderItems)
USING XML INDEX XML_Order_Items FOR PATH;
GO

CREATE XML INDEX XML_Order_Items_Value
ON dbo.SalesOrder (OrderItems)
USING XML INDEX XML_Order_Items FOR VALUE;
GO

CREATE XML INDEX XML_Order_Items_Property
ON dbo.SalesOrder (OrderItems)
USING XML INDEX XML_Order_Items FOR PROPERTY;
GO

SELECT OrderID,
	   OrderItems.query ('for $i in /items/item
						  where $i/@quantity > 0
						  order by $i/@id
						  return $i') As Items
FROM dbo.SalesOrder
WHERE OrderItems.exist('/items[@count > 1]') = 1;

