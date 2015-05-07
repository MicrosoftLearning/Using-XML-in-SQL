-- Create a schema collection
CREATE XML SCHEMA COLLECTION AWItems
AS
N'<xs:schema targetNamespace="http://aw/items"
             xmlns="http://aw/items"
             xmlns:xs="http://www.w3.org/2001/XMLSchema"
             elementFormDefault="qualified">
  <xs:element name="items">
    <xs:complexType>
      <xs:sequence>
        <xs:element name="item" minOccurs="1" maxOccurs="unbounded">
          <xs:complexType>
            <xs:attribute name="id" type="xs:positiveInteger"/>
            <xs:attribute name="quantity" type="xs:positiveInteger"/>
          </xs:complexType>
        </xs:element>
      </xs:sequence>
      <xs:attribute name="count" type="xs:positiveInteger" use="required"/>
    </xs:complexType>
  </xs:element>
</xs:schema>';
GO

SELECT cp.*
FROM sys.xml_schema_components cp
JOIN sys.xml_schema_collections c
ON cp.xml_collection_id = c.xml_collection_id
WHERE c.name = 'AWItems';

--Drop and recreate SalesOrder table with schema collection
IF EXISTS (SELECT * FROM sys.sysobjects
           WHERE name = 'SalesOrder')
	DROP TABLE dbo.SalesOrder;
GO

CREATE TABLE dbo.SalesOrder
(OrderID int IDENTITY PRIMARY KEY CLUSTERED,
 OrderDate date DEFAULT GETDATE(),
 OrderItems xml (AWItems));

-- try to insert unqualified XML
INSERT INTO dbo.SalesOrder (OrderItems)
VALUES
 ('<items count="2">
	<item id="561" quantity="1"></item>
	<item id="127" quantity="2"></item>
   </items>');

-- Insert qualified XML
INSERT INTO dbo.SalesOrder (OrderItems)
VALUES
 ('<items xmlns="http://aw/items" count="2">
	<item id="561" quantity="1"></item>
	<item id="127" quantity="2"></item>
   </items>');

-- Try to insert invalid XML
INSERT INTO dbo.SalesOrder (OrderItems)
VALUES
 ('<items xmlns="http://aw/items" count="2">
	<item id="561" quantity="1" price="2.99"></item>
	<item id="127" quantity="2" price="3.99"></item>
   </items>');

-- Insert a fragment
INSERT INTO dbo.SalesOrder (OrderItems)
VALUES
 ('<items xmlns="http://aw/items" count="2">
	<item id="561" quantity="1"></item>
	<item id="127" quantity="2"></item>
   </items>
   <items xmlns="http://aw/items" count="1">
	<item id="129" quantity="1"></item>
   </items>');

-- Restrict to well-formed documents only
DELETE dbo.SalesOrder
WHERE OrderID = SCOPE_IDENTITY();

ALTER TABLE dbo.SalesOrder
	ALTER COLUMN OrderItems xml (DOCUMENT AWItems);

INSERT INTO dbo.SalesOrder (OrderItems)
VALUES
 ('<items xmlns="http://aw/items" count="2">
	<item id="561" quantity="1"></item>
	<item id="127" quantity="2"></item>
   </items>
   <items xmlns="http://aw/items" count="1">
	<item id="129" quantity="1"></item>
   </items>');