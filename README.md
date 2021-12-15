# Database_design_reporting_PowerBI
This project demonstrates the practical experience of designing database systems, data modelling using ER Diagram, normalization of historic data, ETL Technologies, Designing multidimensional CUBE structures and Dashboard reports using PowerBI. 
Key Tools: Microsoft SQL Server Management studio, SSIS and PowerBI.
# About the Dataset - MumsNet 
MumsNet was founded in 2003 and has grown over the last years to become a UK leading specialist brand for mothers-to-be and mothers of babies and pre-school children. They offer a collection of maternity clothes, nursery equipment, accessories and toys for babies and toddlers, as well as baby clothes from new-born to 3 years old. MumsNet markets and sells its products through its own retail stores and online via its own website MumsNet.com. The company launched its online store at the start of 2005 and has done significantly well as online sales have grown every year since then.

The following three tables were used in this project and contain historic order,product and customer information from January 2005 until December 2009.
![GitHub Logo](/Diagrams/OriginalTables.png)

## Data Modelling - ER Diagram
## Database design and optimization - Normalisation
### Normalisation
Normalisation is a process for evaluating and correcting table structures.Its purpose is to remove the data redundancies, data inconsistencies and inefficient data structures. After careful observation from ER Model, ikt was found that the  given three tables were not normalised to the third normal form (3NF). However there should be a trade-off between correctness and efficiency. A high level normal form will introduce performance degradation as the database management system will need to join more tables together to produce query results. 
### Characteristics of normalisation
* First normal form (1NF) - Identified Primary keys and no repeating groups
* Second normal form (2NF) - Eliminated partial dependencies
* Third normal form (3NF) - Eliminated transitive dependencies. 

### Observations:
**First normal form (1NF):**
* Table CustomerCity (Primary key = id)
* Table Product (Composite Key = ProductGroup,ProductCode,VariantCode)
* Table OrderItem (Primary Key= OrderItemNumber)

**Second normal form (2NF):**
Dependency based on only a part of composite PK is a partial; dependency.
* Table CustomerCity - Primary Key (id) can be used to determine all other attributes of this table. (id,Gender,FirstName,LastName,DateRegistered,City,County,Region,Country)

* Table Product - Composite keys(ProductCode and VariantCode is used to determine Name,Size and Price), Composite Key ProductGroup and VariantCode is used to determine Features and Description. Thus I divided this table into two based on partial dependency. I split the Product table into NProduct and NProductGroup.


* Table OrderItem - Primary Key (OrderItemNumber) can be used to determine OrderNumber, OrderCreateDate , OrderStatusCode, BillingCurrency, Quantity,UnitPrice and LineItemTotal.I split the OrderItem table into NOrderItem and NorderGroup. 

![GitHub Logo](/Diagrams/2NF_Order.png)

**Third noormal form (3NF):**
Eliminated the transitive dependencies. 
* Table CustomerCity - [Country → Region], [Region → County], [County → City]

![GitHub Logo](/Diagrams/3NF_CustomerCity.png)
* Table OrderItem - [OrderCreateDate → Day], [Day → Month], [Month → Quarter], [Quarter → Year]

### Final Normalised Table: 

The proposed normalised table consists of 8 independent tables and the data model is shown in the diagram below. The SQL Query I did for the normalisation task is available here. Relationships between tables are added through database diagram properties. 

![GitHub Logo](/Diagrams/Normalized_Table.png)
