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

SELECT * FROM OPENXML(@docHandle, 'order', 1)
WITH (id int,
	  date date,
	  customer varchar(25) 'customer/name');

SELECT * FROM OPENXML(@docHandle, 'order/items/item', 1)
WITH (orderid int '../../@id',
      id int,
	  quantity int);

SELECT * FROM OPENXML(@docHandle, 'order/salesperson', 3)
WITH (id int,
	  name varchar(25));

EXEC sp_xml_removedocument @docHandle;


