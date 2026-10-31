--stage 2--
CREATE TABLE Departments
(
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
SELECT * FROM Departments;

CREATE TABLE Students
(
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    GPA DECIMAL(3,2),
    DepartmentID INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
CREATE TABLE StudentProfiles
(
    ProfileID INT PRIMARY KEY,
    StudentID INT UNIQUE,
    Address VARCHAR(200),
    EmergencyPhone VARCHAR(20),
    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID)
);

CREATE TABLE Courses
(
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT,
    DepartmentID INT,

    FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);

CREATE TABLE StudentCourses
(
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE DEFAULT GETDATE(),

    PRIMARY KEY (StudentID, CourseID),

    FOREIGN KEY (StudentID)
        REFERENCES Students(StudentID),

    FOREIGN KEY (CourseID)
        REFERENCES Courses(CourseID)
);
ALTER TABLE Students
ADD Age INT;

DROP TABLE TempInstructors;

--stage 3--
INSERT INTO Departments VALUES
(1, 'Computer Science'),
(2, 'Software Engineering'),
(3, 'Business Administration');

INSERT INTO Students
(StudentID, FullName, Email, GPA, DepartmentID, Age)
VALUES
(101, 'Ali Smadi', 'ali@coursehub.com', 3.80, 1, 22),
(102, 'Omar Ahmad', 'omar@coursehub.com', 2.90, 1, 21),
(103, 'Laila Hassan', 'laila@coursehub.com', 3.50, 2, 23),
(104, 'Tariq Zaid', 'tariq@coursehub.com', 2.10, 3, 20);

INSERT INTO StudentProfiles
(ProfileID, StudentID, Address, EmergencyPhone)
VALUES
(1, 101, 'Amman, Jordan', '0791111111'),
(2, 102, 'Irbid, Jordan', '0792222222'),
(3, 103, 'Zarqa, Jordan', '0793333333');

INSERT INTO Courses VALUES
(201, 'Database Systems', 3, 1),
(202, 'Web Development', 3, 1),
(203, 'Software Architecture', 3, 2);

INSERT INTO StudentCourses
(StudentID, CourseID)
VALUES
(101, 201),
(101, 202),
(102, 201),
(103, 203);

UPDATE Students SET GPA = 2.50 WHERE StudentID = 104;

DELETE FROM Students WHERE StudentID = 104;

SELECT * FROM Departments;

SELECT * FROM Students;

SELECT * FROM StudentProfiles;

SELECT * FROM Courses;

SELECT * FROM StudentCourses;

--stage 4--

SELECT S.FullName,S.GPA, D.DepartmentName
FROM Students S JOIN Departments D
ON S.DepartmentID = D.DepartmentID;

SELECT D.DepartmentName,S.FullName
FROM Departments D LEFT JOIN Students S
ON D.DepartmentID = S.DepartmentID;

SELECT S.FullName,P.Address,P.EmergencyPhone
FROM Students S JOIN StudentProfiles P
ON S.StudentID = P.StudentID;

SELECT S.FullName,C.CourseName,SC.EnrollmentDate
FROM Students S JOIN StudentCourses SC
ON S.StudentID = SC.StudentID JOIN Courses C
ON SC.CourseID = C.CourseID;

--stage 5--
SELECT COUNT(*) AS TotalStudents,AVG(GPA) AS AverageGPA,
MAX(GPA) AS HighestGPA,MIN(GPA) AS LowestGPA
FROM Students;


SELECT DepartmentID,AVG(GPA) AS AverageGPA,COUNT(*) AS TotalStudents
FROM Students
GROUP BY DepartmentID;

SELECT DepartmentID,AVG(GPA) AS AverageGPA
FROM Students
GROUP BY DepartmentID
HAVING AVG(GPA) > 3.00;

SELECT DepartmentID,COUNT(*) AS TotalStudents
FROM Students
WHERE GPA >= 2.50
GROUP BY DepartmentID
HAVING COUNT(*) > 1;

--stage 6--
--StudentID--

CREATE NONCLUSTERED INDEX IX_Students_Email
ON Students(Email);

EXEC sp_helpindex 'Students';

--stage 7--

SELECT * FROM Students
WHERE GPA > (SELECT AVG(GPA) FROM Students);

CREATE VIEW StudentAcademicDetails AS
SELECT S.StudentID,S.FullName,S.GPA,D.DepartmentName
FROM Students S
JOIN Departments D ON S.DepartmentID = D.DepartmentID;

CREATE PROCEDURE GetStudentByDep @DeptID INT
AS
BEGIN
    SELECT * FROM Students
    WHERE DepartmentID = @DeptID;
END;

EXEC GetStudentByDep @DeptID = 1;