sakila_query1.sql

-- summarize customer rentals by total payment in descending order

USE sakila ;
SELECT
    c.customer_id
    ,concat(first_name," ", last_name) AS customer
    ,count(*) AS rentals_count
    ,SUM(amount) AS TotalPayment
FROM payment p
JOIN customer c USING(customer_id)
GROUP BY 
	customer_id 
ORDER BY TotalPayment DESC ;

-- total count of film rentals per category name 
SELECT 
		cg.category_id
        ,ct.name AS category_name
        ,count(*) AS count
FROM sakila.film_category cg
JOIN sakila.category ct USING(category_id)
GROUP BY 
	category_id
	,ct.name
ORDER BY 
	count DESC;
    
