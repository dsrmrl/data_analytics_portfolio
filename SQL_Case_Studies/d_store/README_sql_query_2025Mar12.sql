sql_query_2025Mar12.sql

USE d_store;

-- check for duplicate customers
SELECT 
	DISTINCT concat(first_name, " ", last_name) AS customer
    , count(*) AS count
FROM d_store.customers
GROUP BY customer 
HAVING count > 1 -- customer name occuring more than once
ORDER BY customer ;

-- show indexes on customers table
SHOW INDEXES FROM customers;

-- creating indexes for more efficient queries
CREATE INDEX idx_last_name ON customers(last_name) ;
CREATE INDEX idx_name ON customers(last_name, first_name) ;
CREATE INDEX idx_location ON customers(state,city) ;	
 
-- dropping duplicate indexes 
DROP INDEX idx_last_name ON customers ;

-- list distinct cities
SELECT DISTINCT city
FROM d_store.customers
ORDER BY city ;

-- list distinct states
SELECT DISTINCT state
FROM d_store.customers
ORDER BY state ;                   

-- customer demographic by state
SELECT 
	state
    , count(*) AS count
FROM d_store.customers
GROUP BY state 
ORDER BY count DESC ;

-- customer demographic by city
SELECT 
	city
    , count(*) AS count
FROM d_store.customers
GROUP BY city 
ORDER BY count DESC ;

-- breakdown of customers by decade of birth
SELECT 
CASE 
	WHEN Year(birth_date) < '1960'THEN '60s'
    WHEN Year(birth_date) < '1970'THEN '70s'
    WHEN Year(birth_date) < '1980'THEN '80s'
    WHEN Year(birth_date) < '1990'THEN '90s'
    WHEN Year(birth_date) < '2000'THEN '00s'
    ELSE '10s'
END AS decade
, count(*) AS count
FROM d_store.customers
GROUP BY decade
ORDER BY FIELD(decade, '60s', '70s', '80s', '90s', '00s', '10s');

-- breakdown of customers per membership category
-- divided into 4 membership categories; Gold, Silver , Bronze and Basic
SELECT 
	CASE
		WHEN points >= 3000 THEN 'Gold' -- 3000 and above
        WHEN points >= 2000 THEN 'Silver' -- 2000 to 2999
        WHEN points >= 1000 THEN 'Bronze' -- 1000 to 1999
        ELSE 'Basic' -- below 1000
	END AS membership
    , count(*) AS count
FROM d_store.customers
GROUP BY membership 
ORDER BY FIELD( membership, 'Gold','Silver','Bronze','Basic');

-- manual check for membership = Silver
SELECT 
	count(*) AS Silver -- specify membership
FROM d_store.customers
WHERE points BETWEEN 2000 AND 2999 ; -- check specific range for membership points

-- products without orders
SELECT p.product_id
	, p.name AS product
    , p.quantity_in_stock AS qty_in_stock
    , p.unit_price
FROM  products p
LEFT JOIN order_items oi USING (product_id)
WHERE order_id IS NULL ;

-- customers without orders
SELECT 	
	c.customer_id
    , concat(c.first_name," ", c.last_name) AS customer
FROM  customers c 
LEFT JOIN orders o USING (customer_id)
WHERE order_id IS NULL ;

-- retrieve order_items with the following details; 
	-- product_id, count and quantity * unit_price (total_sales)
-- return only rows with total_sales > 80
SELECT 
	oi.product_id
    , p.name AS product
    , count(*) AS count
    , sum(oi.quantity * oi.unit_price) AS total_sales
FROM d_store.order_items oi
LEFT JOIN products p USING(product_id)
GROUP BY product_id
HAVING total_sales > 80 ;

-- retrieve top 3 products
SELECT 
	DISTINCT product_id
    , p.name AS product
    , count(*) AS order_count
FROM d_store.order_items oi
JOIN  products p USING(product_id)
GROUP BY product_id 
ORDER BY count DESC
LIMIT 3 ;

-- Customer Segmentation
-- identify high-value customers by grouping customers by state and loyalty points
SELECT 
	*
    , DENSE_RANK() OVER(PARTITION BY state ORDER BY count DESC) AS _rank
FROM
(
		SELECT 
			state
			, CASE
					WHEN points >= 3000 THEN 'Gold' -- 3000 and above
					WHEN points >= 2000 THEN 'Silver' -- 2000 to 2999
					WHEN points >= 1000 THEN 'Bronze' -- 1000 to 1999
					ELSE 'Basic' -- below 1000
			 END AS membership
			, count(*) AS count
		FROM d_store.customers
		GROUP BY 
				state 
				, membership 
) t ;


-- identify high-value customers by grouping customers by age and loyalty points
SELECT 
	*
    , DENSE_RANK() OVER(PARTITION BY age_group ORDER BY count DESC) AS _rank
FROM
(
		SELECT 
				CASE 
					WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) < 25 THEN 'Under 25'
					WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 25 AND 44 THEN '25-44'
					WHEN TIMESTAMPDIFF(YEAR, birth_date, CURDATE()) BETWEEN 45 AND 64 THEN '45-64'
					ELSE '65+'
				END AS age_group
			, CASE
					WHEN points >= 3000 THEN 'Gold' -- 3000 and above
					WHEN points >= 2000 THEN 'Silver' -- 2000 to 2999
					WHEN points >= 1000 THEN 'Bronze' -- 1000 to 1999
					ELSE 'Basic' -- below 1000
			 END AS membership
			, count(*) AS count
		FROM d_store.customers
		GROUP BY age_group 
				, membership 
) t 
ORDER BY FIELD(age_group,'Under 25', '25-44', '45-64' ,'65+');


-- return orders that have been shipped ; shipping status = 2
-- indicate customer name 
SELECT 
	`o`.`order_id`,
    concat(`c`.`first_name`," ", `c`.`last_name`) AS customer ,
    `o`.`order_date`,
    `os`.`name` AS status ,
    `o`.`shipped_date`,
    `o`.`shipper_id`
FROM `d_store`.`orders` o
JOIN order_statuses os ON o.status = os.order_status_id
JOIN customers c USING(customer_id) 
WHERE shipped_date IS NOT NULL 
ORDER BY order_id ;

-- identify shippers without order transaction
SELECT 
	s.shipper_id
    , s.name AS shipper
FROM shippers s
LEFT JOIN orders o USING(shipper_id) 
WHERE o.shipper_id IS NULL ;


