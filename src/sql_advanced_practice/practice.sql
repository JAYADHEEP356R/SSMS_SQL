USE SQL_PRACTICE;

GO

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


--L1 5 find employees hired in last 2 years

Select * 
from Employees
where hire_date > = DATEADD(year,-2,GETDATE())


--L2 1 Assign row number per department based on salary

Select emp_name,department,row_number()

over (partition by department order by salary) as number

from Employees;

--L2 2 show running of salary per department

Select emp_name,department,sum(salary)

over (partition by department) as total_dept_salary 

from Employees;


--L2 3 find top 2 highest paid Employee per department 


Select  emp_name,salary,department 

from

(

Select emp_name,salary,department,dense_rank()

over (partition by department order by salary desc) as ranks

from Employees

) t

where ranks <=2

--L2 4 show previous salary

Select emp_name,salary, lag(salary) -- lag needs order by compulsorily

over (partition by department order by salary) as previous_salary

from Employees


--l2 5 show salary difference of previous employees

Select emp_name,salary, salary-lag(salary)

over (partition by department order by salary) as salary_diff

from employees;


--l3 1 if no third highest salary exist return null


Select emp_name,department, salary

from (

Select emp_name,department,salary,dense_rank() 

over (partition by department order by salary desc) as ranks

from Employees

) d

where ranks = 3

--l3 2 remove duplicate salaries but keep one recored...


Select department,salary 

from 
(

Select department,salary,row_number() 

over (partition by department,salary order by salary ) as counts 

from Employees
)t

where counts = 1





