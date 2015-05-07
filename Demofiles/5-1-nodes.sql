DECLARE @x xml;
SET @x = '<?xml version="1.0" encoding="ISO-8859-1"?>
<order id="123456" date="2015-01-01">
  <salesperson id="123">
    <name>Naomi Sharp</name>
  </salesperson>
  <customer id="921">
    <name>Dan Drayton</name>
  </customer>
  <!-- an order may contain multiple items -->
  <items>
    <item id="268" quantity="2"/> 
    <item id="561" quantity="1"/>
    <item id="127" quantity="2"/>
  </items>
</order>';

-- Get a rowset of XML elements
SELECT OrderTable.OrderXml.query('.') AS ItemXML
FROM @x.nodes('/order/items/item') AS OrderTable(OrderXml);


-- Get a rowset of values from XML
--SELECT OrderTable.OrderXml.value('./@id', 'int') AS OrderID,
--       OrderTable.OrderXml.value('./@date', 'date') AS OrderDate,
--	   OrderTable.OrderXml.value('./customer[1]/name[1]', 'nvarchar(25)') AS Customer
--FROM @x.nodes('/order') AS OrderTable(OrderXml);

--SELECT ItemsTable.ItemXml.value('../../@id', 'int') AS OrderID,
--	   ItemsTable.ItemXml.value('./@id', 'int') AS Product,
--	   ItemsTable.ItemXml.value('./@quantity', 'int') AS Quantity
--FROM @x.nodes('/order/items/item') AS ItemsTable(ItemXml);
