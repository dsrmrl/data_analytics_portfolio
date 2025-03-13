CREATE DEFINER=`root`@`localhost` PROCEDURE `get_orders_by_status`(
status TINYINT
)
BEGIN
	SELECT 
		`o`.`order_id`,
		`o`.`customer_id`,
		`o`.`order_date`,
		`o`.`status` AS id,
		`os`.`name` AS status,
		`o`.`shipped_date`,
		`o`.`shipper_id`
	FROM `d_store`.`orders` o
	JOIN order_statuses os ON o.status = os.order_status_id 
	WHERE status = `o`.`status`;

END