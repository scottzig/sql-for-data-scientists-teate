-- Exercises from Ch. 9 of SQL for Data Scientists by Teate

-- 1
/*
SELECT
	MIN(market_date) AS earliest_market_date,
    MAX(market_date) AS latest_market_date
FROM farmers_market.customer_purchases
LIMIT 10
*/
-- 2
/*
SELECT
	DAYNAME(market_date) AS market_day,
    EXTRACT(HOUR FROM transaction_time) AS market_hour,
    COUNT(DISTINCT customer_id) AS different_customers
FROM farmers_market.customer_purchases
GROUP BY DAYNAME(market_date), EXTRACT(HOUR FROM transaction_time)
*/
-- 3
/*
-- Count number of distinct products at the farmers market
SELECT
	COUNT(DISTINCT product_name) AS number_of_products
FROM farmers_market.product
*/

-- Return average sales of each product for each vendor per month
SELECT
	vendor_id,
    product_id,
    EXTRACT(MONTH FROM market_date) AS sale_month,
    AVG(quantity * original_price) AS average_per_month
FROM farmers_market.vendor_inventory
GROUP BY vendor_id, product_id, EXTRACT(MONTH FROM market_date)

