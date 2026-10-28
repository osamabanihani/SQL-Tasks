CREATE DATABASE TechWorldHRDB;

USE TechWorldHRDB;

CREATE TABLE TemporaryStaff (
    StaffID INT PRIMARY KEY,
    StaffName VARCHAR(50),
    HireDate DATE
);

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID INT
);

ALTER TABLE Employees
ADD PhoneNumber VARCHAR(20);

DROP TABLE TemporaryStaff;

INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

SELECT * FROM Departments;

INSERT INTO Employees VALUES
(1, 'Ahmad Ali', 'ahmad@techworld.com', 1200, 1, '0791111111'),
(2, 'Sara Hassan', 'sara@techworld.com', 950, 2, '0792222222'),
(3, 'Zaid Omar', 'zaid@techworld.com', 1500, 1, '0793333333'),
(4, 'Mona Khaled', 'mona@techworld.com', 800, 3, '0794444444');

UPDATE Employees
SET Salary = 1350
WHERE EmployeeID = 1;

DELETE FROM Employees
WHERE EmployeeID = 4;

SELECT * FROM Employees;

SELECT FullName, Salary FROM Employees;

SELECT SUM(Salary) AS TotalSalaries FROM Employees;

SELECT AVG(Salary) AS AverageSalary FROM Employees;

SELECT MAX(Salary) AS HighestSalary,
       MIN(Salary) AS LowestSalary
FROM Employees;

SELECT COUNT(*) AS TotalEmployees FROM Employees;