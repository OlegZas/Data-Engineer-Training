CREATE DATABASE StudentData; -- creating database
USE StudentData; -- making StudentData an active database
DROP DATABASE StudentData;
-- *****************************Creating Tables**********
Drop table Student;
CREATE TABLE Student (  
    Student_ID char(12) PRIMARY KEY CHECK (char_length(Student_ID) = 12), -- each consists of 12 characters 
    Survey_ID INT CHECK (Survey_ID >= 30000 AND Survey_ID <=39999),
	TestScore_ID INT CHECK (TestScore_ID >= 20000 AND TestScore_ID <=29999),
	Demographics_ID INT CHECK (Demographics_ID >= 10000 AND Demographics_ID <=19999),
    Firstname VARCHAR(255) DEFAULT 'First Name is Missing!',
    LastName VARCHAR(255)DEFAULT 'Last Name is Missing!',
    FOREIGN KEY (Survey_ID) REFERENCES Survey(Survey_ID) ON DELETE CASCADE,
    FOREIGN KEY (TestScore_ID) REFERENCES TestScore(TestScore_ID) ON DELETE CASCADE,
	FOREIGN KEY (Demographics_ID) REFERENCES Demographics(Demographics_ID) ON DELETE CASCADE)
    ;
Drop table Survey;
CREATE TABLE Survey (
    Survey_ID INT PRIMARY KEY CHECK (Survey_ID >= 30000 AND Survey_ID <=39999),
	DecID INT CHECK (DecID >= 40000 AND DecID <=49999),
    Parent_Education int DEFAULT 0 CHECK (Parent_Education >= 1 AND Parent_Education <= 6),
    Lunch_Plan int DEFAULT 0 CHECK (Lunch_Plan >= 1 AND Lunch_Plan <= 6),
    Test_Preparation int DEFAULT 0 CHECK (Test_Preparation >= 0 AND Test_Preparation <= 100),
    FOREIGN KEY (DecID) REFERENCES Decoded(DecID) ON DELETE CASCADE
);
Drop table TestScore;
CREATE TABLE TestScore (
    TestScore_ID INT PRIMARY KEY CHECK (TestScore_ID >= 20000 AND TestScore_ID <=29999),
    Math_Score INT CHECK (Math_Score >= 0 AND Math_Score <= 100),
    Reading_Score INT CHECK (Reading_Score >= 0 AND Reading_Score <= 100),
    Writing_Score INT CHECK (Writing_Score >= 0 AND Writing_Score <= 100)
);
Drop table Demographics;
CREATE TABLE Demographics (
    Demographics_ID INT PRIMARY KEY CHECK (Demographics_ID >= 10000 AND Demographics_ID <=19999),
    Gender ENUM('M', 'F', 'Undecided') DEFAULT 'Undecided', -- enum data types list a list of possible values 
    Year_Group CHAR(7) DEFAULT 'Retain' -- each group has 7 characters; default has to be retained for another year  
);
Drop table Decoded;
CREATE TABLE IF NOT EXISTS Decoded (
DecID INT PRIMARY KEY CHECK (DecID >= 40000 AND DecID <=49999),
Parent_Education VARCHAR(30) DEFAULT 'Aj Aj jaj!',
Lunch_Plan VARCHAR(12) DEFAULT 'Olegs work',
Test_Preparation VARCHAR(9) DEFAULT 'Donde?'
);
-- *****************************************************************************************
-- *************************************MY Queries****************************************************
-- Average scores for each subject grouped by year group 
Select d.year_Group AS Year, Avg(ts.math_score) AS MathScore, avg(ts.Reading_Score) AS ReadingScore, avg(ts.Writing_Score) as WritingScore
From Student st
Join demographics as d on st.demographics_id = d.demographics_id
Join testscore as ts on st.TestScore_ID = ts.testscore_id
Group by d.year_group;
-- Combined average scores for each year group 
Select d.year_Group AS Year, Format(Avg((ts.math_score +ts.Reading_Score+ts.Writing_Score)/3), 'xx') AS AverageScore 
From Student st
Join demographics as d on st.demographics_id = d.demographics_id
Join testscore as ts on st.TestScore_ID = ts.testscore_id
Group by d.year_group
Order by AverageScore desc;
-- average test scores goruped by parent educaiton level 
SELECT
  d.Parent_Education,
  AVG(ts.Math_Score) AS AvgMathScore,
  AVG(ts.Reading_Score) AS AvgReadingScore,
  AVG(ts.Writing_Score) AS AvgWritingScore
FROM
  Decoded d
JOIN
  Survey s ON d.DecID = s.DecID
JOIN
  Student st ON s.Survey_ID = st.Survey_ID
JOIN
  TestScore ts ON st.TestScore_ID = ts.TestScore_ID
GROUP BY
  d.Parent_Education
ORDER BY
  d.Parent_Education;
--
-- will create some views and indices 
  CREATE INDEX IDtestScore -- not supported in BigQuery
  ON TestScore (TestScore_ID); -- index created for practice; this column is used very often in join clauses not just select; 
-- View
CREATE VIEW AverageTestScores AS
SELECT Round(Avg(ts.math_score),2) AS MathScore, Round(avg(ts.Reading_Score),2) AS ReadingScore, Round(avg(ts.Writing_Score),2) as WritingScore
FROM  TestScore ts; 

---
SELECT
  d.Parent_Education, s.Parent_Education,
  AVG(ts.Math_Score) AS AvgMathScore,
  AVG(ts.Reading_Score) AS AvgReadingScore,
  AVG(ts.Writing_Score) AS AvgWritingScore
FROM
  Student st
JOIN
  Survey s ON st.Survey_ID = s.Survey_ID
JOIN
  decoded d ON s.DecID = d.DecID
JOIN
  TestScore ts ON st.TestScore_ID = ts.TestScore_ID
GROUP BY
  d.Parent_Education, s.Parent_Education
ORDER BY
  s.Parent_Education desc;
  --
  -- 10. Test scores grouped by parent level of education and both YES prep and YES lunch 
  SELECT d.Parent_Education,
       AVG(CASE WHEN d.Lunch_Plan = 'Standard' AND d.Test_Preparation = 'Completed' THEN ts.Math_Score END) AS Avg_Math_Standard_Completed,
       AVG(CASE WHEN d.Lunch_Plan = 'Standard' AND d.Test_Preparation = 'Completed' THEN ts.Reading_Score END) AS Avg_Reading_Standard_Completed,
       AVG(CASE WHEN d.Lunch_Plan = 'Standard' AND d.Test_Preparation = 'Completed' THEN ts.Writing_Score END) AS Avg_Writing_Standard_Completed,
       AVG(CASE WHEN d.Lunch_Plan = 'Free/Reduced' AND d.Test_Preparation = 'none' THEN ts.Math_Score END) AS Avg_Math__Free_None,
       AVG(CASE WHEN d.Lunch_Plan = 'Free/Reduced' AND d.Test_Preparation = 'none' THEN ts.Reading_Score END) AS Avg_Reading_Free_None,
       AVG(CASE WHEN d.Lunch_Plan = 'Free/Reduced' AND d.Test_Preparation = 'none' THEN ts.Writing_Score END) AS Avg_Writing_Free_None
FROM Student st
JOIN Survey s ON st.Survey_ID = s.Survey_ID
JOIN TestScore ts ON st.TestScore_ID = ts.TestScore_ID
JOIN Decoded d ON s.DecID = d.DecID
GROUP BY d.Parent_Education;


  
  -- Integrity check 
  Select * 
  from student 
  join survey on student.survey_ID = survey.survey_ID
  join testscore on student.testscore_id = testscore.testscore_id
  join decoded on survey.decid = decoded.decid
  order by testscore.math_score desc;
-- *****************************************************************************************
-- *****************************************************************************************
-- not everything was imported, stated data too long in Parent_Education, so i will alter that column here: 
Alter table decoded
drop column Parent_Education;
Alter table decoded 
add column Parent_Education VARCHAR(30) DEFAULT 'Aj Aj jaj!';
Alter table Decoded
MODIFY COLUMN Parent_Education VARCHAR(30) DEFAULT 'AJ AJ AJ';
Truncate table Decoded; 
-- Altering Survey table: 1. create a new foreign key 
ALTER TABLE Survey 
DROP COLUMN DecID; 
Alter table Survey
Add column DecID INT DEFAULT 0 CHECK (DecID >= 40000 AND DecID <=49999);  
ALTER TABLE Survey
ADD FOREIGN KEY (DecID) REFERENCES Decoded(DecID);
ALTER TABLE Survey
MODIFY COLUMN DECID INT DEFAULT NULL CHECK (DecID >= 40000 AND DecID <=49999);
SHOW CREATE TABLE Survey;
ALTER TABLE Survey
DROP FOREIGN KEY DecID;

Select count(Parent_Education)from Decoded;
select * from Survey;
Select * from Demographics;
Select * from TestScore;
Select * from Student;
select count(TestScore_ID)from student;
--
SELECT *
FROM Student
JOIN Demographics ON Student.Student_ID = Demographics.Student_ID
JOIN TestScore ON Student.Student_ID = TestScore.Student_ID
JOIN Survey ON Student.Student_ID = Survey.Student_ID;

--

select count(student_id)
from Student;
/*
alter table student
drop column iddata_id;  */


-- changing datatype of student_id from int to char(12)
-- ALTER TABLE Student 
-- MODIFY COLUMN Student_ID char(12);


select st.Student_ID, st.FirstName, st.LastName,ts.Math_score, ts.Reading_score, ts.Writing_score, avg((ts.Math_score + ts.Reading_score + ts.Writing_score)/3) as CombinedAverage
 from student as st
join testscore as ts
on st.TestScore_ID = ts.TestScore_ID
Group by Student_ID -- in select using aggregate function in conjunction with non-aggregate, so group by is necessary to 
-- group the results for non-aggregated columns; 
order by CombinedAverage desc 
limit 10;

/*
-- modifying survey table 
ALTER TABLE `studentdata`.`survey` 
DROP FOREIGN KEY `survey_ibfk_1`;
ALTER TABLE `studentdata`.`survey` 
CHANGE COLUMN `DecID` `DecID` INT NOT NULL COMMENT 'DecID is a foreign key that links this table to the Decoded table ' ,
ADD UNIQUE INDEX `Survey_ID_UNIQUE` (`Survey_ID` ASC) VISIBLE,
ADD UNIQUE INDEX `DecID_UNIQUE` (`DecID` ASC) VISIBLE;
;
-- surveyID
ALTER TABLE `studentdata`.`survey` 
ADD CONSTRAINT `survey_ibfk_1`
  FOREIGN KEY (`DecID`)
  REFERENCES `studentdata`.`decoded` (`DecID`)
  ON DELETE CASCADE;
  ALTER TABLE `studentdata`.`survey` 
CHANGE COLUMN `Survey_ID` `Survey_ID` INT NOT NULL COMMENT 'Primary key, links this table with Student table ' ;*/

/* Modifying testScore table
ALTER TABLE `studentdata`.`testscore` 
ADD UNIQUE INDEX `TestScore_ID_UNIQUE` (`TestScore_ID` ASC) VISIBLE;
;
ALTER TABLE `studentdata`.`testscore` 
CHANGE COLUMN `Math_Score` `Math_Score` INT NULL DEFAULT NULL COMMENT 'Student\'s score on Math test 0-100%' ;

/*

/*
-- Modifying Student table; editing key constraints; adding discriptions to all columns 
ALTER TABLE `studentdata`.`student` 
DROP FOREIGN KEY `student_ibfk_1`,
DROP FOREIGN KEY `student_ibfk_2`,
DROP FOREIGN KEY `student_ibfk_3`;
ALTER TABLE `studentdata`.`student` 
CHANGE COLUMN `Student_ID` `Student_ID` CHAR(12) NOT NULL COMMENT 'Unique ID of each student' ,
CHANGE COLUMN `Survey_ID` `Survey_ID` INT NOT NULL COMMENT 'Foreign key refers to the Survey table' ,
CHANGE COLUMN `TestScore_ID` `TestScore_ID` INT NOT NULL COMMENT 'Foreign key refers to the TestScore table' ,
CHANGE COLUMN `Demographics_ID` `Demographics_ID` INT NOT NULL COMMENT 'Foreign key refers to the Demographics table' ,
CHANGE COLUMN `Firstname` `Firstname` VARCHAR(255) NULL DEFAULT 'First Name is Missing!' COMMENT 'student\'s first name ' ,
CHANGE COLUMN `LastName` `LastName` VARCHAR(255) NULL DEFAULT 'Last Name is Missing!' COMMENT 'student\'s last name ' ,
ADD UNIQUE INDEX `Student_ID_UNIQUE` (`Student_ID` ASC) VISIBLE,
ADD UNIQUE INDEX `Survey_ID_UNIQUE` (`Survey_ID` ASC) VISIBLE,
ADD UNIQUE INDEX `Demographics_ID_UNIQUE` (`Demographics_ID` ASC) VISIBLE,
ADD UNIQUE INDEX `TestScore_ID_UNIQUE` (`TestScore_ID` ASC) VISIBLE;
;
ALTER TABLE `studentdata`.`student` 
ADD CONSTRAINT `student_ibfk_1`
  FOREIGN KEY (`Survey_ID`)
  REFERENCES `studentdata`.`survey` (`Survey_ID`)
  ON DELETE CASCADE,
ADD CONSTRAINT `student_ibfk_2`
  FOREIGN KEY (`TestScore_ID`)
  REFERENCES `studentdata`.`testscore` (`TestScore_ID`)
  ON DELETE CASCADE,
ADD CONSTRAINT `student_ibfk_3`
  FOREIGN KEY (`Demographics_ID`)
  REFERENCES `studentdata`.`demographics` (`Demographics_ID`)
  ON DELETE CASCADE;
*/