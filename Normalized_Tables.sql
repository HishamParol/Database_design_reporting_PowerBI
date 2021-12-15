USE AssignmentPart1

SELECT * FROM INFORMATION_SCHEMA.TABLES

SELECT * FROM CustomerCity
SELECT * FROM Product
SELECT * FROM OrderItem

/*--2NF FOR PRODUCT TABLE----------------------------------------------------------------------------------------*/
CREATE TABLE NProduct 
(ProductCode NVARCHAR(1000), VariantCode NVARCHAR(1000), Name NVARCHAR(1000),Size NVARCHAR(50),Price Money, 
PRIMARY KEY (ProductCode,VariantCode))

INSERT INTO NProduct
SELECT DISTINCT ProductCode,VariantCode,Name,Size,Price 
FROM Product

SELECT * FROM NProduct

/*--2NF FOR PRODUCTGROUP TABLE----------------------------------------------------------------------------------------*/
CREATE TABLE NProductGroup 
(ProductGroup NVARCHAR(1000), VariantCode NVARCHAR(1000), Features NVARCHAR(4000), Description NVARCHAR(4000), 
PRIMARY KEY (ProductGroup,VariantCode))

INSERT INTO NProductGroup
SELECT ProductGroup,VariantCode,Features,Description 
FROM Product

SELECT * FROM NProductGroup

/*--2NF FOR ORDERITEMS TABLE-------------------------------------------------------------------------------------*/
CREATE TABLE NOrderItem
(OrderItemNumber NVARCHAR(32), CustomerCityId INT,ProductGroup NVARCHAR(1000),ProductCode NVARCHAR(1000), VariantCode NVARCHAR(1000), 
PRIMARY KEY (OrderItemNumber))

INSERT INTO NOrderItem
SELECT OrderItemNumber,CustomerCityId,ProductGroup,ProductCode,VariantCode
FROM OrderItem

SELECT * FROM NOrderItem
/*--2NF FOR ORDERGROUP TABLE------------------------------------------------------------------------------------*/
CREATE TABLE NOrderGroup
(OrderItemNumber NVARCHAR(32), OrderNumber NVARCHAR(50),OrderCreateDate DATETIME,OrderStatusCode INT, 
BillingCurrency NVARCHAR(8),Quantity INT,UnitPrice MONEY, LineItemTotal MONEY, 
PRIMARY KEY (OrderItemNumber))

INSERT INTO NOrderGroup
SELECT OrderItemNumber, OrderNumber,OrderCreateDate,OrderStatusCode, 
BillingCurrency,Quantity,UnitPrice, LineItemTotal
FROM OrderItem

SELECT * FROM NOrderGroup
/*--3NF FOR CUSTOMERCITY TABLE----------------------------------------------------------------------------------*/
CREATE TABLE NCustomerDetails (CustomerId INT,Gender NVARCHAR(255),CustomerName NVARCHAR (750), DateRegistered DATETIME, City NVARCHAR (255), 
PRIMARY KEY(CustomerId))

INSERT INTO NCustomerDetails 
SELECT Id,Gender,FirstName + ' ' + LastName AS CustomerName,DateRegistered,City 
FROM CustomerCity

SELECT * FROM NCustomerDetails

/*--3NF FOR CITY TABLE----------------------------------------------------------------------------------*/
CREATE TABLE NCity (City NVARCHAR(255),County NVARCHAR(255), 
PRIMARY KEY(City))

INSERT INTO NCity
SELECT DISTINCT City,County
FROM CustomerCity

SELECT * FROM NCity
/*--3NF FOR COUNTY TABLE----------------------------------------------------------------------------------*/
CREATE TABLE NCounty (County NVARCHAR(255),Region NVARCHAR(255), 
PRIMARY KEY(County))

INSERT INTO NCounty
SELECT DISTINCT County,Region
FROM CustomerCity

SELECT * FROM NCounty
/*--3NF FOR REGION TABLE----------------------------------------------------------------------------------*/
CREATE TABLE NRegion (Region NVARCHAR(255),Country NVARCHAR(255), 
PRIMARY KEY(Region))

INSERT INTO NRegion
SELECT DISTINCT Region,Country
FROM CustomerCity

SELECT * FROM NRegion