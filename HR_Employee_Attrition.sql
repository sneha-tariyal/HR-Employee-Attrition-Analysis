--HR Employee Attrition Analysis:

Create Table Employee_Attrition (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(50),
    EmployeeCount INT,
    EmployeeNumber INT PRIMARY KEY,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

Create Table Department(
EmployeeNumber Int References Employee_Attrition(EmployeeNumber),
Department Varchar(50),
ManagerName Varchar(50),
Location Varchar(50)
);

-- Import Data into Employee_Attrition Table
-- CSV file used: HR-Employee-Attrition.csv
-- Data imported using PostgreSQL COPY command.

-- Import Data into Department Table
-- CSV file used: Department.csv
-- Data imported using PostgreSQL COPY command.


Select * From Employee_Attrition;
Select * From Department ;

-- ==============================
-- 1. Workforce Overview
-- ==============================

-- Q1. What is the total workforce size of the organization?
       Select Count(*) AS Total_Employees From Employee_Attrition;
	  
-- Q2. What are the different departments within the organization?
       Select Distinct Department From Employee_Attrition ;
	  
-- Q3. What is the average age of employees in the organization?	  
       Select Avg(Age) AS Average_Age From Employee_Attrition;

-- Q4. How many employees are working in each location?
       SELECT d.Location, Count(*) AS Total_Employees From Employee_Attrition e 
	   Join Department d On e.EmployeeNumber = d.EmployeeNumber Group by  d.Location;

-- ==============================
-- 2. Salary & Job Role Analysis
-- ==============================

-- Q5. How does average monthly income vary across different job roles?
       Select JobRole,Round(Avg(MonthlyIncome),2) AS Avg_Income From Employee_Attrition 
	   Group by JobRole Order by Avg_Income DESC;

-- Q6. Which job roles have an average monthly income above 10,000?
       Select JobRole , Round(Avg(MonthlyIncome),2) AS Avg_Income From Employee_Attrition 
	   Group by JobRole Having Avg(MonthlyIncome) >10000;

-- Q7. Which employees have a monthly income above the company average?
       Select EmployeeNumber,MonthlyIncome From Employee_Attrition Where MonthlyIncome>
	   (Select Avg(MonthlyIncome) AS Avg_Income From Employee_Attrition);

-- Q8. What is the second-highest monthly income among employees?
       With Salary_Rank AS(Select EmployeeNumber,MonthlyIncome,
	   Dense_Rank() Over(Order by MonthlyIncome DESC) AS Salary_Rank
	   From Employee_Attrition ) Select * From Salary_Rank Where Salary_Rank =2;

-- Q9. Who is the highest-paid employee in each department?
       Select e.EmployeeNumber,e.Department,e.MonthlyIncome From Employee_Attrition e  
	   Where e.MonthlyIncome = (Select Max(e2.MonthlyIncome) From Employee_Attrition e2 
	   Where e2.Department = e.Department);
	   
-- ==============================
-- 3. Attrition Analysis
-- ==============================

-- Q10. How many employees have left the organization compared with those who stayed?	  
        Select Attrition, Count(*) AS Employee_Count From Employee_Attrition Group by Attrition;

-- Q11. What is the overall employee attrition rate?
        Select Round(100.0*count(*) Filter(Where Attrition ='Yes') /count(*),2) As Attrition_Rate 
        From Employee_Attrition;

-- Q12. How does average distance from home differ between employees who left and those who stayed?
        Select  Attrition, Round(Avg(DistanceFromHome),2) AS Avg_Distance From Employee_Attrition Group by Attrition;

-- Q13. What is the attrition rate in each department?
        Select Department, Round(100.0*Count(*) Filter(Where Attrition ='Yes')/ Count(*),2) AS Attrition_Rate 
	    From Employee_Attrition Group by Department Order by Attrition_Rate DESC;

-- Q14. What is the attrition rate for employees working overtime compared with those who do not?
        SELECT OverTime, ROUND(100.0 * Count(*) Filter (Where Attrition = 'Yes')/Count(*),2) AS Attrition_Rate
        From Employee_Attrition Group by OverTime Order by Attrition_Rate DESC;

-- ==============================
-- 4. Advanced SQL Analysis
-- ==============================

-- Q15. How are employees ranked by monthly income within each department?
        Select EmployeeNumber,Department,MonthlyIncome,Rank() Over(Partition by Department Order by MonthlyIncome DESC) 
	    AS Salary_Rank From Employee_Attrition;
	   
-- Q16. Which employees are older than the average age of their department?
        With Department_Avg_Age AS(Select Department,Avg(Age) AS Avg_Age From Employee_Attrition 
	    Group by Department) Select e.EmployeeNumber,e.Department,e.Age, Round(d.Avg_Age,2) AS Department_Avg_Age
	    From Employee_Attrition e join Department_Avg_Age d on e.Department=d.Department
	    Where e.Age > d.Avg_Age;

-- Q17. How can employee details be linked with department and manager information?
        Select e.EmployeeNumber,e.Department,d.ManagerName,d.Location From Employee_Attrition e 
	    Join Department d on e.EmployeeNumber=d.EmployeeNumber;

/* Key Findings:
1. Workforce size: 1,470 employees across three departments.
2. Overall attrition rate: 16.12%.
3. Sales has the highest attrition at 20.63%.
4. Overtime employees show higher attrition: 30.53%.
5. Manager and Research Director have the highest average income.
*/

/* Business Recommendations:
1. Focus retention efforts on Sales and HR.
2. Review overtime workload and employee support.
3. Review compensation and career-growth opportunities.
*/
