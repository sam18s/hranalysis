create database hranalysis;
use hranalysis;

select * from hrdata1;

-- Retrieve the total number of employees in the dataset-- 
SELECT COUNT(*) AS TotalEmployees
FROM hrdata1;


-- 2. List all unique job roles in the dataset-- 
SELECT DISTINCT(JobRole) , COUNT(JobRole)
FROM hrdata1
GROUP BY JobRole;


-- 3. Find the average age of employees.-- 
SELECT AVG(age) AS AverageAge 
FROM hrdata1;


-- 4. Retrieve the names and ages of employees who have worked at the company for more than 5 years.-- 
SELECT Employe, Age 
FROM hrdata1 
WHERE YearsAtCompany >5;


-- 5. Get a count of employees grouped by their department-- 
SELECT  Department, COUNT(Employe) AS No_of_employee
From hrdata1
GROUP BY Department;


-- 6. List employees who have 'High' Job Satisfaction, 5 = high -- 
SELECT EmployeeID  ,Employe , JobLevel 
FROM hrdata1
WHERE JobLevel = 5;


-- 7. Find the highest Monthly Income in the dataset.-- 
SELECT MAX(MonthlyIncome)
From hrdata1;


-- 8. List employees who have 'Travel_Rarely' as their BusinessTravel type.-- 
SELECT EmployeeID, Employe, BusinessTravel
FROM hrdata1
WHERE BusinessTravel = 'Travel_Rarely';


-- 9. Retrieve the distinct MaritalStatus categories in the dataset.-- 
SELECT  MaritalStatus, COUNT(Employe) AS count
From hrdata1
GROUP BY MaritalStatus;


-- 10. Get a list of employees with more than 2 years of work experience but less than 4 years in their current role.-- 
SELECT Employe, TotalWorkingYears
FROM hrdata1
WHERE TotalWorkingYears >2 AND TotalWorkingYears < 4;


-- 11. List employees who have changed their job roles within the company (JobLevel and JobRole differ from their previous job).--
SELECT
    EmployeeID,
    Employe,
    CurrentJobRole,
    PreviousJobRole,
    CurrentJobLevel,
    PreviousJobLevel
FROM (
    SELECT
        EmployeeID,
        Employe,
        JobRole AS CurrentJobRole,
        JobLevel AS CurrentJobLevel,
        LAG(JobRole) OVER (PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS PreviousJobRole,
        LAG(JobLevel) OVER (PARTITION BY EmployeeID ORDER BY YearsAtCompany) AS PreviousJobLevel
    FROM hrdata1
) AS JobChanges
WHERE CurrentJobRole <> PreviousJobRole OR CurrentJobLevel <> PreviousJobLevel;


-- 12. Find the average distance from home for employees in each department.-- 
SELECT  Department, COUNT(Employe) AS No_of_employee, AVG(DistanceFromHome)
From hrdata1
GROUP BY Department;


-- 13. Retrieve the top 5 employees with the highest MonthlyIncome.-- 
SELECT Employe, MonthlyIncome
FROM hrdata1
ORDER BY MonthlyIncome DESC
LIMIT 5;


-- 14. Calculate the percentage of employees who have had a promotion in the last year.-- 
SELECT 
	COUNT(CASE WHEN YearsSinceLastPromotion <= 1 THEN 1 END) AS YearsSinceLastPromotion,
    COUNT(*) AS TotalEmploye,
    (COUNT( CASE WHEN YearsSinceLastPromotion <= 1 THEN 1 END) *100.0/ COUNT(*)) AS Percentage
FROM hrdata1;


-- 15. List the employees with the highest and lowest EnvironmentSatisfaction.
SELECT EmployeeID, Employe,EnvironmentSatisfaction
FROM hrdata1
WHERE EnvironmentSatisfaction = (
    SELECT MAX(EnvironmentSatisfaction)
    FROM hrdata1
)
UNION
SELECT EmployeeID,Employe,EnvironmentSatisfaction
FROM hrdata1
WHERE EnvironmentSatisfaction = (
    SELECT MIN(EnvironmentSatisfaction)
    FROM hrdata1
);


-- 15. List the employees with the highest and lowest EnvironmentSatisfaction in total count
SELECT 'high' AS Satisfaction_Level, COUNT(*) AS Count_of_Employees, EnvironmentSatisfaction
FROM hrdata1
WHERE EnvironmentSatisfaction = (
    SELECT MAX(EnvironmentSatisfaction)
    FROM hrdata1
)
GROUP BY EnvironmentSatisfaction

UNION

SELECT 'low' AS Satisfaction_Level, COUNT(*) AS Count_of_Employees, EnvironmentSatisfaction
FROM hrdata1
WHERE EnvironmentSatisfaction = (
    SELECT MIN(EnvironmentSatisfaction)
    FROM hrdata1
)
GROUP BY EnvironmentSatisfaction;


-- 16. Find the employees who have the same JobRole and MaritalStatus.
SELECT JobRole, MaritalStatus, COUNT(*) as NumEmployees
FROM hrdata1
GROUP BY JobRole, MaritalStatus
HAVING COUNT(*) > 1
ORDER BY MaritalStatus ASC;


-- 17. List the employees with the highest TotalWorkingYears who also have a PerformanceRating of 4.
select EmployeeID, Employe, TotalWorkingYears, PerformanceRating
from hrdata1
where TotalWorkingYears = (
		select max(TotalWorkingYears)
        from hrdata1
        where PerformanceRating = 4)
	AND PerformanceRating = 4;


-- 18. CalCulate the average Age and JobSatisfaction for each BusinessTravel type.-- 
select avg(age)AS Age, JobSatisfaction, BusinessTravel
FROM hrdata1
group by BusinessTravel,JobSatisfaction
ORDER BY Age;


-- 19. Retrieve the most common EducationField among employees.
select EducationField, count(*) as count
from hrdata1
group by EducationField;


-- 20. List the employees who have worked for the company the longest but haven't had a promotion.
SELECT EmployeeID, Employe, YearsAtCompany, YearsSinceLastPromotion
FROM hrdata1
WHERE YearsAtCompany = (
        SELECT MAX(YearsAtCompany)
        FROM hrdata1
        WHERE YearsSinceLastPromotion = 0
    )
    AND YearsSinceLastPromotion = 0;


-- THANK YOU
