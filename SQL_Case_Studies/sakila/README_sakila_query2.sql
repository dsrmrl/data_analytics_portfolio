sakila_query2.sql

# average rental interval (in days) per customer
# first and last rental dates
SELECT
	c.customer_id
    , concat(c.first_name," ", c.last_name) AS client
    , first_rental
    , last_rental
    , count(*) AS rentals
	, ROUND(AVG(DATEDIFF(next_rental,rental_date)),2) AS avg_rental_interval
FROM (

	SELECT 
		customer_id
		,rental_date
		,LEAD(rental_date) OVER(PARTITION BY customer_id ORDER BY rental_date) next_rental
        ,MIN(rental_date) OVER(PARTITION BY customer_id) first_rental
		,MAX(rental_date) OVER(PARTITION BY customer_id) last_rental
	FROM
		sakila.rental
	) t
JOIN customer c USING(customer_id) 
GROUP BY 
	customer_id
	,first_rental
    ,last_rental;
    
# top 10 films per category
SELECT
	rn
    ,category
    ,film_id
    ,title
    ,rentals
FROM (
		SELECT 
			f.film_id
			, f.title
			, c.name AS category
			, count(r.rental_id) AS rentals
            ,ROW_NUMBER() OVER(PARTITION BY c.name ORDER BY count(r.rental_id) DESC) rn
		FROM
			sakila.film f 
		LEFT JOIN inventory i USING(film_id) 
		LEFT JOIN rental r ON r.inventory_id = i.inventory_id
		LEFT JOIN film_category fc USING(film_id)
		LEFT JOIN category c ON c.category_id = fc.category_id
		GROUP BY
			 film_id
			, title
			, name 
	) t
WHERE rn <= 10;

# actors with most number of films
SELECT 
    DISTINCT a.actor_id
    ,concat(first_name," ", last_name) AS actor
    ,count(*) AS film_count
    ,DENSE_RANK() OVER(ORDER BY count(*) DESC) AS _rank
FROM
    sakila.film_actor fa
JOIN actor a USING(actor_id)
GROUP BY 
	actor_id
    ,concat(first_name," ", last_name)






