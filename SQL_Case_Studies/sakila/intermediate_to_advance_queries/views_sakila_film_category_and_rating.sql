CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sakila`.`film_category_and_rating` AS
    SELECT 
        `c`.`category_id` AS `category_id`,
        `c`.`name` AS `category`,
        COUNT(`fc`.`film_id`) AS `film_count`,
        `f`.`rating` AS `rating`
    FROM
        ((`sakila`.`category` `c`
        JOIN `sakila`.`film_category` `fc` ON ((`c`.`category_id` = `fc`.`category_id`)))
        JOIN `sakila`.`film` `f` ON ((`fc`.`film_id` = `f`.`film_id`)))
    GROUP BY `c`.`category_id` , `c`.`name` , `f`.`rating` WITH ROLLUP