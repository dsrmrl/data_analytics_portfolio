CREATE DEFINER=`root`@`localhost` PROCEDURE `get_employees_per_office_id`(
office_id INT
)
BEGIN
	SELECT 
	`e`.`employee_id`,
    concat(`e`.`first_name`, '  ', `e`.`last_name`) AS employee ,
    `e`.`job_title`,
    `e`.`office_id`
FROM d_hr.employees e
JOIN employees m ON e.reports_to = m.employee_id
WHERE office_id = e.office_id;
END