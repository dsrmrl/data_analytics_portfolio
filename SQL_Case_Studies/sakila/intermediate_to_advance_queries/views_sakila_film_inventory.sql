CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sakila`.`film_inventory` AS
    SELECT 
        `i`.`film_id` AS `film_id`,
        `f`.`title` AS `title`,
        `i`.`store_id` AS `store_id`,
        COUNT(`i`.`film_id`) AS `inventory`,
        MAX(`i`.`last_update`) AS `last_update`
    FROM
        (`sakila`.`inventory` `i`
        JOIN `sakila`.`film` `f` ON ((`i`.`film_id` = `f`.`film_id`)))
    GROUP BY `i`.`film_id` , `f`.`title` , `i`.`store_id`
    ORDER BY `i`.`film_id`