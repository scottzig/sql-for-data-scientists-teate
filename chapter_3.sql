-- Exercises from Ch. 3 of SQL for Data Scientists by Teate

-- 1
/*	
SELECT 
	market_date,
	customer_id,
	vendor_id,
    product_id,
    quantity,
    quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE 
	customer_id = 4
    OR customer_id = 9
ORDER BY market_date, customer_id 
*/

-- 2
-- Part 1
/*
SELECT 
	market_date,
	customer_id,
	vendor_id,
    product_id,
    quantity,
    quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE 
	customer_id >= 8
    AND customer_id <= 10
ORDER BY market_date, customer_id 
*/
-- Part 2
/*
SELECT 
	market_date,
	customer_id,
	vendor_id,
    product_id,
    quantity,
    quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE 
	customer_id BETWEEN 8 and 10
ORDER BY market_date, customer_id 
*/

-- 3
/*
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE
	market_date IN
	(
	SELECT market_date
	FROM farmers_market.market_date_info
	WHERE market_rain_flag = 0
	)
LIMIT 5
*/
-- A different approach:
SELECT
	market_date,
	customer_id,
	vendor_id,
	quantity * cost_to_customer_per_qty AS price
FROM farmers_market.customer_purchases
WHERE
	market_date NOT IN
	(
	SELECT market_date
	FROM farmers_market.market_date_info
	WHERE market_rain_flag = 1
	)
LIMIT 5