select * from Employee

--phase 5--
Create table AccessCards(
CardID INT PRIMARY KEY,
CardNumber VARCHAR(50) NOT NULL UNIQUE,
EmpID INT UNIQUE FOREIGN KEY References Employee(EmployeeID)
);

CREATE TABLE Projects
(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL
);

CREATE TABLE EmployeeProjects
(
    EmployeeID INT,
    ProjectID INT,
    AssignedDate DATE,

    PRIMARY KEY (EmployeeID, ProjectID),

    FOREIGN KEY (EmployeeID)
        REFERENCES Employee(EmployeeID),

    FOREIGN KEY (ProjectID)
        REFERENCES Projects(ProjectID)
);

INSERT INTO AccessCards
VALUES
(101, '101', 1),
(102, '102', 2),
(103, '103', 3);

INSERT INTO Projects
VALUES
(1, 'AI & Security Training'),
(2, 'Cloud Migration');

INSERT INTO EmployeeProjects 
VALUES
(1, 1, '2026-10-01'),
(1, 2, '2026-10-02'),
(2, 1, '2026-10-03'),
(3, 2, '2026-10-04');

SELECT * FROM AccessCards;
SELECT * FROM Projects;
SELECT * FROM EmployeeProjects;
--Phase 6--
select Employee.FullName,Employee.Salary,Department.DepartmentName 
from Employee join Department on Employee.DepartmentID=Department.DepartmentID


select Employee.FullName,Department.DepartmentName 
from Department Left join
Employee on Department.DepartmentID=Employee.DepartmentID

select Employee.FullName,AccessCards.CardNumber from Employee join AccessCards on Employee.EmployeeID=AccessCards.EmpID

select Employee.FullName,Projects.ProjectName,EmployeeProjects.AssignedDate
from Employee join EmployeeProjects on Employee.EmployeeID=EmployeeProjects.EmployeeID
join Projects on EmployeeProjects.ProjectID=Projects.ProjectID
--phase 7--
SELECT DepartmentID,SUM(Salary) AS TotalSalary,COUNT(*) AS EmployeeCount
FROM Employee
GROUP BY DepartmentID;

SELECT DepartmentID,AVG(Salary) AS AvgSalary
FROM Employee
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;


SELECT *
FROM Employee
WHERE Salary > (SELECT AVG(Salary)
FROM Employee
);


CREATE VIEW vw_EmployeeDetails AS
SELECT
    E.EmployeeID,
    E.FullName,
    E.Email,
    D.DepartmentName
FROM Employee E
INNER JOIN Department D
    ON E.DepartmentID = D.DepartmentID;



CREATE PROCEDURE GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Employee
    WHERE DepartmentID = @DeptID;
END;


CREATE TABLE EmployeeAudit
(
    AuditID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);

CREATE TRIGGER EmployeeDelete
ON Employee
AFTER DELETE
AS
BEGIN
    INSERT INTO EmployeeAudit
        (EmployeeID, Action, ActionDate)
    SELECT
        EmployeeID,
        'DELETE',
        GETDATE()
    FROM deleted;
END;