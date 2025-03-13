CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customers_by_state`(
state CHAR(2)
)
BEGIN
	SELECT 
	`c`.`customer_id`,
    `c`.`first_name`,
    `c`.`last_name`,
    `c`.`city`,
    `c`.`state`,
    `c`.`points`
FROM `d_store`.`customers` c
WHERE state = c.state 
ORDER BY `customer_id` ;

END