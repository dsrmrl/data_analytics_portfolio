-- sql_query_d_hr_202503_14.sql scripts

USE d_hr ;

SELECT * FROM d_hr.employees;

-- checking and creating indexes 
SHOW INDEX FROM employees ;
CREATE INDEX idx_name ON employees(last_name,first_name) ;

-- return managers for each employees
-- order by manager and then salary in descending order
SELECT 
	e.employee_id
    , CONCAT(e.first_name,' ' ,e.last_name) AS employee
    , e.job_title
    , e.salary
    , m.first_name AS manager
FROM employees e
LEFT JOIN employees m 
ON e.reports_to = m.employee_id 
ORDER BY manager, salary DESC;

-- return employee count per manager
SELECT 
	DISTINCT manager
    , count(*) AS employee_count
FROM d_hr.records_of_managers_per_employee
WHERE  manager IS NOT NULL 
GROUP BY manager ;
	
-- employees with above average (overall) salary
SELECT 
	`employees`.`employee_id`,
   concat( `employees`.`first_name`, ' ',`employees`.`last_name`) AS employee ,
    `employees`.`job_title`,
    `employees`.`salary`
FROM d_hr.employees
WHERE salary > (
	SELECT AVG(salary)
    FROM d_hr.employees
    ) 
ORDER BY salary DESC;


-- retrieve employees with salary higher than the overall average and also higher than average salary per manager
WITH r AS (
		-- retrieve overall average salary and average salary per manager
		SELECT 
			* 
			, ROUND(AVG(salary) OVER(),0) AS avgsalary
			, ROUND(AVG(salary) OVER(PARTITION BY manager),0)  AS avgsalary_per_manager
		FROM d_hr.records_of_managers_per_employee
)
SELECT 
	`r`.`employee_id`,
    `r`.`employee`,
    `r`.`job_title`,
    `r`.`salary`,
    `r`.`avgsalary`,
    `r`.`avgsalary_per_manager`,
    `r`.`manager`
FROM  r
WHERE salary > avgsalary AND salary > avgsalary_per_manager;

