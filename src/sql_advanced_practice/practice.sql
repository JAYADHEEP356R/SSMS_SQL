USE SQL_PRACTICE;

GO

/*

CREATE TABLE Employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    hire_date DATE
);

INSERT INTO Employees VALUES
(1, 'Ravi', 'IT', 10000, '2021-01-10'),
(2, 'Meena', 'IT', 9000, '2021-03-15'),
(3, 'Karthik', 'IT', 9000, '2022-07-20'),
(4, 'Arjun', 'HR', 8000, '2020-05-12'),
(5, 'Divya', 'HR', 7000, '2021-08-01'),
(6, 'Sneha', 'HR', 7000, '2022-09-17'),
(7, 'Vikram', 'Finance', 12000, '2019-11-11'),
(8, 'Priya', 'Finance', 11000, '2020-02-25'),
(9, 'Ajay', 'Finance', NULL, '2023-01-01'),
(10, 'Anu', 'IT', 10000, '2023-04-10');

--- TABLE 2: Orders ---

CREATE TABLE Orders (
    order_id INT,
    customer_name VARCHAR(50),
    order_date DATE,
    amount INT
);

INSERT INTO Orders VALUES
(101, 'Ravi', '2023-01-01', 500),
(102, 'Ravi', '2023-01-05', 700),
(103, 'Meena', '2023-02-01', 1000),
(104, 'Meena', '2023-02-10', 1200),
(105, 'Meena', '2023-03-01', 800),
(106, 'Arjun', '2023-01-15', 400),
(107, 'Divya', '2023-02-20', 900),
(108, 'Sneha', '2023-03-25', 600);
*/




--LEVEL 1 – Basics & Ranking
--1. Find the 3rd highest distinct salary.
--2. Find the 2nd highest salary per department.
--3. List employees with salary higher than department average.
--4. Find duplicate salaries.
--5. Find employees hired in the last 2 years.

--LEVEL 2 – Window Functions
--6. Assign row number per department based on salary.
--7. Show running total of salary per department.
--8. Find top 2 highest paid employees per department.
--9. Show previous employee salary using LAG().
--10. Find salary difference between current and previous employee (by hire date).

--LEVEL 3 – Edge Cases
--11. If no 3rd highest salary exists, return NULL.
--12. Remove duplicate salary rows but keep one record.
--13. Delete duplicate salary records (keep highest emp_id).
--14. Find departments where average salary > 9000.
--15. Replace NULL salaries with department average.

--LEVEL 4 – Orders Table
--16. Find total amount spent by each customer.
--17. Find customer with highest total purchase.
--18. Find running total of amount per customer.
--19. Find first order per customer.
--20. Find customers who ordered more than once in same month.

--BONUS HARD
--21. Find consecutive order dates.
--22. Find gap between two orders per customer.
--23. Find median salary.
--24. Find salary percentile (Top 10%).
--25. Find employees earning more than 70% of department.





--L1 1.

Select distinct salary from (

Select salary,DENSE_RANK() over (order by salary desc) as ranks from Employees 

) t

where ranks=3

--L1 2
Select distinct salary,department from (

Select salary,department,DENSE_RANK() over (partition by department order by salary desc) as ranks from Employees 

) t

where ranks=2;


--L1 3

Select * from Employees e where salary > (

Select avg(salary) from Employees o where o.department = e.department

)


--using windows functions

--L1 4

Select emp_name,salary from (


Select emp_name,salary,avg(salary) over (partition by department) as avg_dept_salary from Employees 


) t 

where salary  > avg_dept_salary;

--L1 5 find duplicates for every department's salary


Select department,salary from Employees group by salary,department having count(*)>1; 

--USING WINDOWS FUNCTIONS AND IF CASE


Select department,  count(case when counts  >1 then 1 end) from (

Select department,salary,count(*) over (partition by department,salary) as counts from Employees


)
t

group by department


