CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `sakila`.`out_of_stock_films` AS
    SELECT 
        `f`.`film_id` AS `film_id`, `f`.`title` AS `title`
    FROM
        `sakila`.`film` `f`
    WHERE
        EXISTS( SELECT 
                `i`.`film_id`
            FROM
                `sakila`.`inventory` `i`
            WHERE
                (`f`.`film_id` = `i`.`film_id`))
            IS FALSE