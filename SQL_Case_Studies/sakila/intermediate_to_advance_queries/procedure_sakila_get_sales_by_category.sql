CREATE DEFINER=`root`@`localhost` PROCEDURE `get_sales_by_category`(
category_id TINYINT
)
BEGIN
	SELECT
		monthname(r.rental_date) as month,
		ct.name as category,
		count(*) AS rentals,
		sum(p.amount) AS total_amount
	FROM category ct
	JOIN film_category fc USING (category_id)
	JOIN inventory i USING (film_id)
	JOIN rental r USING (inventory_id)
	JOIN payment p USING (rental_id)
    WHERE category_id = ct.category_id
	GROUP BY month, category_id, name 
	ORDER BY total_amount desc;
END