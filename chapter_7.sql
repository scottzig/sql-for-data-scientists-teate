-- Exercises from Ch. 7 of SQL for Data Scientists by Teate

-- 1a
/*
SELECT
	market_date,
	customer_id,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date ASC) as visit_number
FROM farmers_market.customer_purchases
*/
-- another solution:
/*
SELECT
	cp.*,
    DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY market_date ASC) as visit_number
FROM farmers_market.customer_purchases AS cp
ORDER BY customer_id, market_date
*/

-- 1b
/*
SELECT
	market_date,
	customer_id,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) as visit_number
FROM farmers_market.customer_purchases
*/

/*
SELECT * FROM
(
SELECT
	market_date,
	customer_id,
    ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY market_date DESC) as visit_number
FROM farmers_market.customer_purchases
) x
WHERE x.visit_number = 1
*/

-- 2
/*
SELECT
	cp.*,
    COUNT(customer_id) OVER (PARTITION BY product_id, customer_id) as times_purchased
FROM farmers_market.customer_purchases as cp
*/

-- 3
SELECT
	market_date,
	SUM(quantity * cost_to_customer_per_qty) AS market_date_total_sales,
	LEAD(SUM(quantity * cost_to_customer_per_qty), 1) OVER (ORDER BY market_date DESC) AS previous_market_date_total_sales
FROM farmers_market.customer_purchases
GROUP BY market_date
ORDER BY market_date
