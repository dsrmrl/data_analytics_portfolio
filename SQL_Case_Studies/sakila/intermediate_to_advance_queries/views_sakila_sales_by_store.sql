CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sakila`.`sales_by_store` AS
    SELECT 
        `s`.`store_id` AS `store_id`,
        CONCAT(`c`.`city`, _utf8mb4 ',', `cy`.`country`) AS `store`,
        CONCAT(`m`.`first_name`,
                _utf8mb4 ' ',
                `m`.`last_name`) AS `manager`,
        SUM(`p`.`amount`) AS `total_sales`
    FROM
        (((((((`sakila`.`payment` `p`
        JOIN `sakila`.`rental` `r` ON ((`p`.`rental_id` = `r`.`rental_id`)))
        JOIN `sakila`.`inventory` `i` ON ((`r`.`inventory_id` = `i`.`inventory_id`)))
        JOIN `sakila`.`store` `s` ON ((`i`.`store_id` = `s`.`store_id`)))
        JOIN `sakila`.`address` `a` ON ((`s`.`address_id` = `a`.`address_id`)))
        JOIN `sakila`.`city` `c` ON ((`a`.`city_id` = `c`.`city_id`)))
        JOIN `sakila`.`country` `cy` ON ((`c`.`country_id` = `cy`.`country_id`)))
        JOIN `sakila`.`staff` `m` ON ((`s`.`manager_staff_id` = `m`.`staff_id`)))
    GROUP BY `s`.`store_id`
    ORDER BY `s`.`store_id`