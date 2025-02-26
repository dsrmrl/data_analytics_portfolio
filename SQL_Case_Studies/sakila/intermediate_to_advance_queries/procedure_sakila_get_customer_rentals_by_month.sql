CREATE DEFINER=`root`@`localhost` PROCEDURE `get_customer_rentals_by_month`(
customer_id SMALLINT
)
BEGIN
	SELECT 
	DISTINCT customer_id,
    year(rental_date) as year,
    monthname(rental_date) as month,
    count(customer_id) as total_rentals,
    sum(p.amount) as total_amount,
    max(rental_date) AS last_rental_date
	FROM rental r
	JOIN payment p USING (customer_id)
    WHERE r.customer_id = customer_id
	GROUP BY customer_id, year, month
	ORDER BY customer_id ;
END