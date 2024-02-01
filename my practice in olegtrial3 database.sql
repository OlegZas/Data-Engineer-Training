use olegtrial2;
create table Persons
(PersonID int primary key,
LastName varchar(255),
FirstName varchar(255),
Address varchar(255),
City varchar(255));
Insert INTO Persons (PersonID, FirstName,LastName, City)
Values (010,'West', 'George', 'Chicago');
create table Pokemon
(Name varchar(60) primary key,
Type1 varchar(60),
HP int, 
Attack int);
Select * from pokemon;
show databases;
Use olegtrial2;
DROP TABLE IF EXISTS Persons;
CREATE TABLE Persons (
    PersonID int NOT NULL,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (PersonID)
);
INSERT INTO Persons (PersonID,LastName,FirstName,Age)
VALUES (1,'Ola','Hansen',30);
INSERT INTO Persons (PersonID,LastName,FirstName,Age)
VALUES (2,'Svendson','Tove',23);
INSERT INTO Persons (PersonID,LastName,FirstName,Age)
VALUES (3,'Pettersen','Kari',20);
SELECT PersonID FROM persons;
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders (
OrderID int NOT NULL PRIMARY KEY,
OrderNumber int NOT NULL, 
PersonID int,
FOREIGN KEY(PersonID) REFERENCES Persons(PersonID)
);
INSERT INTO Orders (OrderID, OrderNumber, PersonID)
VALUES (1,77895,3);
SELECT * from orders;
INSERT INTO Orders (OrderID,OrderNumber,PersonID)
VALUES (2,44678,3);
INSERT INTO Orders (OrderID,OrderNumber,PersonID)
VALUES (3,22456,2);
INSERT INTO Orders (OrderID,OrderNumber,PersonID)
VALUES (4,24562,1);
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
	CustomerID int NOT NULL PRIMARY KEY,
    CustomerName varchar(255),
	ContactName varchar(255),
	Address varchar(255),
	City varchar(255),
	PostalCode varchar(255),
	Country varchar(255));
INSERT INTO customers (CustomerID, CustomerName, ContactName, Address, City, PostalCOde, Country)
VALUES (1,'Alfreds Futterkiste','Maria Anders','Obere Str. 57','Berlin','12209','Germany');
INSERT INTO Customers (CustomerID,CustomerName,ContactName,Address,City,PostalCode,Country)
VALUES (2,'Ana Trujillo','Emparedados','Avda. de la Constitución','México D.F.','05021','Mexico');
INSERT INTO Customers (CustomerID,CustomerName,ContactName,Address,City,PostalCode,Country)
VALUES (3,'Antonio Moreno','Taquería','Antonio Moreno Mataderos','México D.F.','05023','Mexico');
INSERT INTO Customers (CustomerID,CustomerName,ContactName,Address,City,PostalCode,Country)
VALUES (4,'Around the Horn','Thomas Hardy','120 Hanover Sq.','London','WA1 1DP','UK');
INSERT INTO Customers (CustomerID,CustomerName,ContactName,Address,City,PostalCode,Country)
VALUES (5,'Berglunds snabbköp','Christina','Berguvsvägen 8','Luleå','S-958 22','Sweden');
DESCRIBE customers;
SELECT * FROM CUSTOMERS;
SELECT DISTINCT Country from customers; -- select all distinct countreis 
SELECT COUNT(DISTINCT COUNTRY) FROM customers; -- count the number of distinct countries 
SELECT * 
FROM customers
WHERE country ='Mexico'; -- show all the rows and columns where country is mexico
SELECT * FROM CUSTOMERS WHERE COUNTRY='GERMANY' AND CITY ='BERLIN';
SELECT * FROM Customers 
WHERE NOT Country ='Germany';
SELECT * 
FROM customers
WHERE Country ='Germany' AND (City ='Berlin' OR 'Munchen');
SELECT *
FROM customers
ORDER BY Country ASC, CustomerName DESC;
SELECT CustomerName, ContactName, Address
FROM customers 
WHERE Address IS NOT NULL;
UPDATE customers SET ContactName ='Alfred Schmidt', City ='Frankfurt' WHERE CustomerID = 1;
UPDATE customers SET ContactName ='Juan' WHERE Country ='Mexico';
SELECT * FROM CUSTOMERS;
DELETE FROM Customers WHERE CustomerName ='Alfreds Futterkiste';
SELECT * FROM Customers;
SELECT * FROM Customers LIMIT 3;
DROP TABLE IF EXISTS Products;
CREATE TABLE Products(
	ProductID int NOT NULL,
	ProductName varchar(255),
	SupplierID int,
	CategoryID int,
	Unit varchar(255),
	Price float,
	Primary Key(ProductID)
);
INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES (1,'Chais',1,1,'10 boxes x 20 bags',18);
INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES (2,'Chang',1,1,'24 12 oz bottles',19);
INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES (3,'Aniseed Syrup',1,2,'12 - 550 ml bottles',10);
INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES (4,'Chef Anton`s Cajun Seasoning',2,2,'48 - 6 oz jars',22);
INSERT INTO Products(ProductID, ProductName, SupplierID, CategoryID, Unit, Price)
VALUES (5,'Chef Anton`s Gumbo Mix',2,2,'36 boxes',21.35);
SELECT MIN(Price) AS SmallestPrice -- minimum price; aggregate function MIN 
FROM Products; 
SELECT * FROM PRODUCTS;
SELECT COUNT(ProductID) FROM Products;
CREATE TABLE OrderDetails(
	OrderDetailID int NOT NULL,
	OrderID int,
	ProductID int,
	Quantity int,
	PRIMARY KEY(OrderDetailID)
);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (1,10248,11,12);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (2,10248,42,10);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (3,10248,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (4,10249,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (5,10249,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (6,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (7,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (8,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (9,10251,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (10,10251,72,5);
SELECT * FROM OrderDetails;
SELECT AVG(QUANTITY) FROM OrderDetails;
SELECT SUM(QUANTITY) FROM OrderDetails;
Select * From Customers;
SELECT * 
From customers
Where CustomerName Like '%o'; /* Select all customers where customer name ends with o*/
Select *
From customers 
Where CustomerName Like '%or%'; /*-------- selects all customers with a CustomerName 
that have "or" in any position*/
/* -------- selects all customers with a CustomerName that have "r" in the second */
Select *
From customers
Where CustomerName Like "_r%";
/* -------- selects all customers with a CustomerName that starts with "a" and are at least 3 characters in length: */
SELECT *
FROM customers
-- OR like this : WHERE CustomerName LIKE 'a%' AND CustomerName LIKE '___%'; 
 WHERE CustomerName LIKE 'a__%';
/* --------- selects all customers with a ContactName that starts with "a" and ends with "o": */
Select * 
From customers 
Where CustomerName LIKE 'a%o';
-- --------- selects all customers with a CustomerName that does NOT start with "a":
Select * 
From customers 
where customername NOT LIKE 'a%';
 -- ---------selects all customers with a City starting with "b", "s", or "p":
SELECT * 
FROM customers 
WHERE CustomerName RLIKE '^[bsp]';
-- ---------selects all customers with a City starting with "a - l ":
Select * 
from customers 
where City RLIKE '^[a-l]';
-- ---------select all customers with a City NOT starting with "l":
select * 
from customers 
Where city RLIKE '^[^l]';
select * from customers;
SELECT * FROM CUSTOMERS 
WHERE COUNTRY IN ('GERMANY','FRANCE','UK');
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;
select * from PRODUCTS;
SELECT CustomerID AS ID, CustomerName AS Customer FROM Customers;
-- Joins/Injections-->Assignment
-- --------Returns the cities (only distinct values) from both the "Customers" and the "Suppliers" table:
CREATE TABLE Suppliers(
	SupplierID int NOT NULL,
	SupplierName varchar(255),
	ContactName varchar(255),
	Address varchar(255),
	City varchar(255),
	PostalCode varchar(255),
	Country varchar(255),
	PRIMARY KEY(SupplierID)
);


INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Address,City, PostalCode, Country)
VALUES (1,'Exotic Liquid','Charlotte Cooper','49 Gilbert St.','London','EC1 4SD','UK');

INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Address,City, PostalCode, Country)
VALUES (2,'New Orleans Cajun Delights','Shelley Burke','P.O. Box 78934','New Orleans','70117','USA');

INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, Address, City, PostalCode, Country)
VALUES (3,'Grandma Kelly`s Homestead','Regina Murphy','07 Oxford Rd.','Ann Arbor','48104','USA');

SELECT CITY 
FROM CUSTOMERS 
UNION 
SELECT CITY
FROM SUPPLIERS;
-- ---------returns the cities (duplicate values also) from both the "Customers" and the "Suppliers" table:
SELECT CITY AS OLEG_CITIES
FROM CUSTOMERS 
UNION ALL 
SELECT CITY 
FROM SUPPLIERS;

SELECT COUNT(CUSTOMERid), COUNTRY
FROM CUSTOMERS 
GROUP BY COUNTRY;
-- COUNTING CUSTOMER IDS AND GROUPING THEM BY COUNTRY THEN ORDERING BASED ON COUNT FROM HIGHEST
SELECT COUNT(CustomerID), Country 
FROM Customers 
GROUP BY Country 
ORDER BY COUNT(CustomerID) DESC;
SELECT COUNT(CUSTOMERid), COUNTRY 
FROM CUSTOMERS 
GROUP BY COUNTRY 
HAVING COUNT(CUSTOMERID)>1;
-- -------- SQL statement lists the number of customers in each country,
-- sorted high to low (Only include countries with more than 1 customers):
SELECT * FROM CUSTOMERS;
SELECT COUNT(CUSTOMERID), COUNTRY
FROM CUSTOMERS
GROUP BY COUNTRY 
HAVING COUNT(CUSTOMERID)>1
ORDER BY COUNT(CUSTOMERid) DESC;
-- ------SQL statement returns TRUE and lists the suppliers with a product price less than 20:
SELECT SUPPLIERNAME 
FROM SUPPLIERS 
WHERE EXISTS(SELECT PRODUCTNAME 
FROM PRODUCTS 
WHERE PRODUCTS.SUPPLIERID = SUPPLIERS.SUPPLIERID AND PRICE < 20);
--
DROP TABLE IF EXISTS orderdetails;
CREATE TABLE OrderDetails(
	OrderDetailID int NOT NULL,
	OrderID int,
	ProductID int,
	Quantity int,
	PRIMARY KEY(OrderDetailID));
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (1,10248,11,12);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (2,10248,42,10);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (3,10248,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (4,10249,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (5,10249,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (6,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (7,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (8,10250,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (9,10251,72,5);
INSERT INTO OrderDetails(OrderDetailID, OrderID,ProductID, Quantity)
VALUES (10,10251,72,5);
-- -------SQL goes through conditions and returns a value when the first condition is met:
SELECT ORDERID, Quantity,
CASE 
	WHEN Quantity > 5 THEN 'The quantity is greater than 5'
    WHEN Quantity = 5 THEN 'The quantity is 5'
    ELSE 'The quanityt is under 5' 
END AS QuanityText
FROM OrderDetails; 
-- ----SQL statement creates a stored procedure named "TestProc2" that selects all records from the "Customers" table:
Delimiter //
CREATE PROCEDURE TestProc2()
BEGIN
	SELECT * FROM Customers;
END //
DELIMITER ;
CALL TestProc2() ;
-- Alter table by adding columns 
ALTER TABLE CUSTOMERS ADD EMAIL VARCHAR(255);
ALTER TABLE CUSTOMERS DROP EMAIL; 
SELECT * FROM Customers;
ALTER TABLE CUSTOMERS 
MODIFY CUSTOMERNAME CHAR(25);
-- CREATING AN INDEX 
CREATE INDEX idx_lastname ON Persons (LastName); 
--
--
CREATE TABLE test(name varchar(50), attack int, defence int);
select * from test;

CREATE TABLE Increments (
    Personid int NOT NULL AUTO_INCREMENT,
    LastName varchar(255) NOT NULL,
    FirstName varchar(255),
    Age int,
    PRIMARY KEY (Personid));
-- DATA TYPES -- DATA TYPES -- 
ALTER TABLE Orders ADD OrderDate date;
UPDATE Orders set OrderDate=('2008-11-11');
SELECT * FROM Orders WHERE OrderDate='2008-11-11';
--
--
-- CREATING A VIEW -- 
CREATE VIEW G AS
SELECT CustomerName, ContactName
FROM Customers
WHERE Country = 'Mexico';
Drop view G;
--
--
-- Ranking window functions and over and partition
-- Find average salary of employees for each department and order employees within a department by age.

CREATE TABLE Employee2(
Name varchar(255), 
Age int , 
Department varchar(255), 
Salary float);

SELECT * FROM Employee2;
INSERT INTO Employee2 Values ("Jon",20,"Sales",40000),("James",25,"Sales",20000),("Jake",35,"Delivery",30000),("Luke",40,"Delivery",1000000);
SELECT Name, Age, Department, Salary, 
 AVG(Salary) OVER( PARTITION BY Department) AS Avg_Salary
 FROM Employee2;
 
