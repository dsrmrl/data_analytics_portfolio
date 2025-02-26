CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sakila`.`top_categories` AS
    SELECT 
        `ct`.`category_id` AS `category_id`,
        `ct`.`name` AS `category`,
        COUNT(0) AS `rentals`,
        SUM(`p`.`amount`) AS `total_amount`
    FROM
        ((((`sakila`.`category` `ct`
        JOIN `sakila`.`film_category` `fc` ON ((`ct`.`category_id` = `fc`.`category_id`)))
        JOIN `sakila`.`inventory` `i` ON ((`fc`.`film_id` = `i`.`film_id`)))
        JOIN `sakila`.`rental` `r` ON ((`i`.`inventory_id` = `r`.`inventory_id`)))
        JOIN `sakila`.`payment` `p` ON ((`r`.`rental_id` = `p`.`rental_id`)))
    GROUP BY `ct`.`category_id` , `ct`.`name`
    ORDER BY `total_amount` DESC