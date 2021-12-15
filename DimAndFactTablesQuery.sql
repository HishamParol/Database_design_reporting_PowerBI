USE AssignmentPart1

SET SHOWPLAN_TEXT OFF

SELECT OrderItemNumber, CustomerName, County
FROM NOrderItem 
JOIN NCustomerDetails 
ON NOrderItem.CustomerCityId = NCustomerDetails.CustomerId
JOIN NCity 
ON NCustomerDetails.City=NCity.City

/*--FACT TABLE--------------------------------------------------------------*/
CREATE TABLE FACTOrder
(OrderItemNumber NVARCHAR(32), CustomerCityId INT,ProductGroup NVARCHAR(1000),ProductCode NVARCHAR(1000),
VariantCode NVARCHAR(1000), Quantity INT,UnitPrice MONEY, LineItemTotal MONEY,
PRIMARY KEY (OrderItemNumber))

INSERT INTO FACTOrder
SELECT OrderItemNumber,CustomerCityId,ProductGroup,ProductCode,VariantCode,Quantity,UnitPrice,LineItemTotal
FROM OrderItem

SELECT * FROM FACTOrder

/*--DIMENSION TABLES-------------------------------------------------------*/


/*--PRODUCT DIM TABLES-------------------------------------------------------*/
CREATE TABLE ProductDIM 
(ProductCode NVARCHAR(1000), VariantCode NVARCHAR(1000), Name NVARCHAR(1000),Size NVARCHAR(50),Price Money, 
PRIMARY KEY (ProductCode,VariantCode))

INSERT INTO ProductDIM
SELECT DISTINCT ProductCode,VariantCode,Name,Size,Price 
FROM Product

SELECT * FROM ProductDIM

/*--PRODUCTGROUP DIM TABLE----------------------------------------------------------------------------------------*/
CREATE TABLE ProductGroupDIM
(ProductGroup NVARCHAR(1000), VariantCode NVARCHAR(1000), Features NVARCHAR(4000), Description NVARCHAR(4000), 
PRIMARY KEY (ProductGroup,VariantCode))

INSERT INTO ProductGroupDIM
SELECT ProductGroup,VariantCode,Features,Description 
FROM Product

SELECT * FROM ProductGroupDIM


/*--ORDERGROUP DIM TABLE------------------------------------------------------------------------------------*/
CREATE TABLE OrderGroupDIM
(OrderItemNumber NVARCHAR(32), OrderNumber NVARCHAR(50),OrderCreateDate DATETIME,OrderStatusCode INT, 
BillingCurrency NVARCHAR(8),
PRIMARY KEY (OrderItemNumber))

INSERT INTO OrderGroupDIM
SELECT OrderItemNumber, OrderNumber,OrderCreateDate,OrderStatusCode, 
BillingCurrency
FROM OrderItem

SELECT * FROM OrderGroupDIM
/*--CUSTOMERCITY DIM TABLE----------------------------------------------------------------------------------*/
CREATE TABLE CustomerDetailsDIM
(CustomerId INT,Gender NVARCHAR(255),CustomerName NVARCHAR (750), DateRegistered DATETIME, City NVARCHAR (255), 
PRIMARY KEY(CustomerId))

INSERT INTO CustomerDetailsDIM 
SELECT Id,Gender,FirstName + ' ' + LastName AS CustomerName,DateRegistered,City 
FROM CustomerCity

SELECT * FROM CustomerDetailsDIM

/*--CITY DIM TABLE----------------------------------------------------------------------------------*/
CREATE TABLE CityDIM (City NVARCHAR(255),County NVARCHAR(255), 
PRIMARY KEY(City))

INSERT INTO CityDIM
SELECT DISTINCT City,County
FROM CustomerCity

SELECT * FROM CityDIM
/*--COUNTY DIM TABLE----------------------------------------------------------------------------------*/
CREATE TABLE CountyDIM (County NVARCHAR(255),Region NVARCHAR(255), 
PRIMARY KEY(County))

INSERT INTO CountyDIM
SELECT DISTINCT County,Region
FROM CustomerCity

SELECT * FROM CountyDIM
/*--REGION DIM TABLE----------------------------------------------------------------------------------*/
CREATE TABLE RegionDIM (Region NVARCHAR(255),Country NVARCHAR(255), 
PRIMARY KEY(Region))

INSERT INTO RegionDIM
SELECT DISTINCT Region,Country
FROM CustomerCity

SELECT * FROM RegionDIM