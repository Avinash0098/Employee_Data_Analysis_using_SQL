-- 											Employee Data Analysis

Create table EmployeeDetails (EmpID int unique primary Key, FullName varchar(50), ManagerID int, DateOfJoining date, city varchar(20));
select * from EmployeeDetails;
Insert into EmployeeDetails values (121, 'John Snow', 321, '2019-01-31', 'Toronto'),
(321, 'Walter White', 986, '2020-01-30', 'California'),
(421, 'Kuldeep Rana', 876, '2021-11-27', 'New Delhi');


create table EmployeeSalary (EmpID int unique primary key, Project varchar(10), Salary int Not Null, Variable int Not null);
select * from EmployeeSalary;
insert Into EmployeeSalary values (121, 'P1', 8000, 500),
(321, 'P2', 10000, 1000),
(421, 'P1', 12000, 0);

-- 1. Write an SQL query to fetch the EmpId and FullName of all the employees working under the Manager with id – ‘986’. 
    select * from employeedetails where ManagerID = 986;

-- 2. Write an SQL query to fetch the different projects available from the EmployeeSalary table.
select distinct (project) from EmployeeSalary;

-- 3. Write an SQL query to fetch the count of employees working on project P1
select Project, count(*) as numberofemployee from employeesalary group by Project having Project = 'P1';

-- 4. Write an SQL query to find the maximum, minimun and average salary of the employees
select max(salary) as Max_Salary, min(salary) as Min_Salary, avg(salary) as Avg_Salary from EmployeeSalary;

-- 5. Write an SQL query to find employee id whose salary lies in the range of 9000 and 15000
select * from EmployeeSalary;
select empid, salary from EmployeeSalary where salary between 9000 and 15000;

-- 6. Write an SQL query to fetch those employees who live in toronto and work under the manager with manager id -321
select * from employeedetails;
select * from employeedetails where city = 'toronto' and ManagerID=321;

-- 7. Write an SQL query to fetch all the employees who eith live in California or work under the manager with manager id - 321
select * from employeedetails where city = 'California' or ManagerID = 321;

-- 8. Write an SQL query to fetch all those employee who work on project other than P1 
use credfow;
select empID, project from EmployeeSalary where project !=  'P1'; -- Incomplete answer

select employeedetails.empid, employeedetails.fullname, EmployeeSalary.project from employeedetails  join employeesalary ON
employeedetails.empid = employeesalary.empid 
where not project = 'P1';

-- 9. Write an SQL query to display the total salary of each employee adding the salary with variable values
select EmpID, sum(salary + variable) as total_Salary from EmployeeSalary group by empid ;

-- 10. Write an SQL query to fetch the employee those names begins with any two character , followed by the text 'hn' and ends with any sequence of character
select * from employeedetails where fullname like "__hn%";

-- 11. Write an SQL query to fetch all the EmpIds which are present in either of the tables – ‘EmployeeDetails’ and ‘EmployeeSalary’.
-- select employeeDetails.EmpId, EmployeeSalary.EmpId from EmployeeDetails 
-- join EmployeeSalary ON										-- It give common value from both the table but it will not be Unique
-- employeeDetails.EmpId = employeeSalary.EmpId;

Select EmpId from EmployeeDetails 
union						-- UNION provide unique value from both the table
select EmpId from EmployeeSalary;


-- 12. Write an SQL query to fetch common records between two tables.
select * from EmployeeDetails where EmpID in (Select EmpID from EmployeeSalary) ;

-- 13. Write an SQL query to fetch records that are present in one table but not in another table.
select * from EmployeeDetails 
LEFT JOIN EmployeeSalary on 
EmployeeDetails.EmpID = EmployeeSalary.EmpID ;

-- 14. Write an SQL query to fetch the EmpIds that are present in both the tables - ‘EmployeeDetails’ and ‘EmployeeSalary’.
select EmpId from EmployeeDetails where EmpID in (select EmpID from EmployeeSalary);

-- 15. Write an SQL query to fetch the EmpIds that are present in EmployeeDetails but not in EmployeeSalary
SELECT EmpID FROM EmployeeDetails WHERE EmpID NOT IN (SELECT EmpID FROM EmployeeSalary);

-- 16. Write an SQL query to fetch the employee’s full names and replace the space with ‘-’
select fullname, replace(fullname, " ", "-")  from EmployeeDetails;

-- 17. Write an SQL query to fetch the position of a given character(s) in a field.
select fullname, instr(fullname, 'h') from EmployeeDetails;

-- 18. Write an SQL query to display both the EmpId and ManagerId together.
Select concat(EmpId, " ", ManagerId) as MergedID from EmployeeDetails;

-- 19. Write a query to fetch only the first name(string before space) from the FullName column of the EmployeeDetails table.
 Select LEFT(fullname, instr(fullname, ' ') -1) as firstName from EmployeeDetails ;
 
 -- 20. Write an SQL query to uppercase the name of the employee and lowercase the city values.
 select upper(FullName), lower(city) from EmployeeDetails;

-- 21. Write an SQL query to find the count of the total occurrences of a particular character – ‘n’ in the FullName field.
select fullname, length(FullName) - LENGTH(REPLACE(FullName, 'n', '')) as TotalOccurrence from EmployeeDetails;

-- 22. Write an SQL query to update the employee names by removing leading and trailing spaces.
Update EmployeeDetails SET FullName = LTRIM(RTRIM(FullName));

-- 23. Fetch all the employees who are not working on any project.
select * from EmployeeSalary where project is null;

-- 24. Write an SQL query to fetch employee names having a salary greater than or equal to 5000 and less than or equal to 10000.
select EmployeeDetails.EmpId, EmployeeDetails.FullName, EmployeeSalary.Salary from EmployeeDetails 
JOIN EmployeeSalary ON EmployeeDetails.EmpId=EmployeeSalary.EmpId
where salary >=5000 and salary <= 10000; -- OR Where EmployeeSalary.Salary between 5000 and 10000

-- 25. Write an SQL query to find the current date-time.
Select now() as Current_Date_Time;

-- 26. Write an SQL query to fetch all the Employee details from the EmployeeDetails table who joined in the Year 2020.
select * from EmployeeDetails where DateOfJoining between '2020-01-01' and '2020-12-31';

-- 27. Write an SQL query to fetch all employee records from the EmployeeDetails table who have a salary record in the EmployeeSalary table.
select EmployeeDetails.* from EmployeeDetails 
Join EmployeeSalary ON  EmployeeDetails.EmpId=EmployeeSalary.EmpId  Where EmployeeSalary.salary is Not Null;
			
            -- Using "Exists"
Select EmployeeDetails.* from EmployeeDetails 
where exists(select EmpID from EmployeeSalary where EmployeeDetails.EmpId = EmployeeSalary.EmpId);

-- 28. Write an SQL query to fetch the project-wise count of employees sorted by project’s count in descending order.
select Project, count(EmpId) as NumberOfEmp from EmployeeSalary group by Project order by NumberOfEmp desc;

-- 29.  Write a query to fetch employee names and salary records. Display the employee details even if the salary record is not present for the employee.
select EmployeeDetails.EmpId, EmployeeDetails.FullName, EmployeeDetails.city, EmployeeSalary.Salary from EmployeeDetails 
left join EmployeeSalary On EmployeeDetails.EmpId= EmployeeSalary.EmpId;

-- 30. Write an SQL query to fetch all the Employees who are also managers from the EmployeeDetails table.
select E.EmpId, E.FullName from EmployeeDetails E 
	Inner join EmployeeDetails F 
		on E.EmpId = F.ManagerID;
        
        
-- 31. Write an SQL query to fetch duplicate records from EmployeeDetails (without considering the primary key – EmpId).
select FullName, ManagerId, DateOfJoining, City, count(*) from EmployeeDetails group by FullName, ManagerId, DateOfJoining, City having count(*)>1;

-- 32. Write an SQL query to remove duplicates from a table without using a temporary table.
delete E1 from EmployeeDetails E1 INNER JOIN EmployeeDetails E2 
Where E1.EmpId > E2.EmpId
AND E1.FullName =  E2.FullName
AND E1.ManagerID = E2.ManagerID
AND E1.DateOfJoining = E2.DateOfJoining
AND E1.City = E2.City;

-- 33. Write an SQL query to fetch only odd rows from the table.
select * from EmployeeDetails Where MOD(EmpId, 2) <> 0;

-- 34. Write an SQL query to fetch only Even rows from the table.
select * from EmployeeDetails Where MOD (EmpId, 2) = 0;

-- 35. Write an SQL query to fetch top n records.
select * From EmployeeDetails order by EmpID desc limit 1;

