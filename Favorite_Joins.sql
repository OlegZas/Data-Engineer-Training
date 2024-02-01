SELECT * FROM pwpslidepractice.title;
create database favoriteJoins; -- created database
Drop database favoriteJoins;
use favoritejoins;
-- ****************************************************************************
-- ****************************SELF-JOIN************************************************
-- ****************************************************************************
CREATE TABLE EmployeeOleg ( -- created the table 
EmployeeID INT NOT NULL PRIMARY KEY auto_increment,
EmpName CHAR(25) NOT NULL,
ManagerID INT,	
FOREIGN KEY (ManagerID)
REFERENCES EmployeeOleg (EmployeeID)
ON DELETE SET NULL); -- will set foreign key to null if employee gets fired 
-- 1) first inserting employees; empid autoincrements 

INSERT INTO EmployeeOleg
(EmpName, ManagerID) VALUES
('Jorge', NULL),
('Cat', 1),
('Dog', 1),
('Table', NULL),
('Laptop', 4);
SELECT * 
FROM EMPLOYEEOLEG;
-- 2) creating an left self-join to view employees and their respective managers 
SELECT e.EmployeeID, e.EmpName, e.ManagerID, m.EmpName ManagerName
FROM EmployeeOleg e
LEFT JOIN employeeOleg m
ON e.ManagerID = m.Employeeid; 

/* *********************************************************************** 
/* *********************************************************************** */
CREATE TABLE Bonus (
BONUS_ID int not null primary key, 
BONUS_AMOUNT INT (10),
BONUS_DATE DATETIME);
INSERT INTO Bonus
(BONUS_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
(843, 5000, '16-02-20'),
(32, 3000, '16-06-11'),
(36, 4000, '16-02-20'),
(3, 4500, '16-02-20'),
(2, 3500, '16-06-11');

SELECT * 
FROM EMPLOYEEOLEG
CROSS JOIN BONUS;