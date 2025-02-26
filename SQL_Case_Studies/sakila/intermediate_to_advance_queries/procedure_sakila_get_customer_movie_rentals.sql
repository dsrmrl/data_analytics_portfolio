CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customer_movie_rentals`(
customer_id SMALLINT
)
BEGIN
	SELECT	
	r.customer_id,
	c.first_name AS customer,
    f.title AS film,
    ct.name AS category,
    r.rental_date,
    r.return_date
	FROM rental r
	LEFT JOIN customer c USING (customer_id)
	LEFT JOIN inventory i USING(inventory_id)
	LEFT JOIN film f USING(film_id)
	LEFT JOIN film_category fc USING(film_id)
	LEFT JOIN category ct USING (category_id) 
    WHERE customer_id = r.customer_id
	ORDER BY rental_date ;

END