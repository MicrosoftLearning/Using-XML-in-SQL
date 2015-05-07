DECLARE @x varchar(max);
SET @x = '<?xml version="1.0" encoding="ISO-8859-1"?>
<order id="123456" date="2015-01-01">
  <salesperson id="123">
    <name>Naomi Sharp</name>
  </salesperson>
  <customer id="921">
    <name>Dan Drayton</name>
  </customer>
  <items>
    <item id="268" quantity="2"/> 
    <item id="561" quantity="1"/>
    <item id="127" quantity="2"/>
  </items>
</order>';

DECLARE @docHandle int;
EXEC sp_xml_preparedocument @docHandle OUTPUT, @x;

-- Retrieve XML metadata
SELECT * FROM OPENXML(@docHandle, 'order/salesperson', 3)
WITH (NodeID int '@mp:id',
	  NodeName varchar(25) '@mp:localname',
	  ParentNode varchar(25) '@mp:parentLocalName');

-- Retrieve overflow data
--SELECT * FROM OPENXML(@docHandle, 'order', 9)
--WITH (id int,
--	  date varchar(25),
--	  orderdetails nvarchar(max) '@mp:xmltext');

-- Retrieve an edge table
--SELECT * FROM OPENXML(@docHandle, 'order');

EXEC sp_xml_removedocument @docHandle;