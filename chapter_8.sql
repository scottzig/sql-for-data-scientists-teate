-- Exercises from Ch. 8 of SQL for Data Scientists by Teate

-- 1
/*
SELECT
	customer_id,
    EXTRACT(MONTH FROM market_date) AS market_month,
    EXTRACT(YEAR FROM market_date) as market_year
FROM farmers_market.customer_purchases
*/
-- 2
/*
SELECT
	MIN(market_date) AS sales_since_date,
    SUM(quantity * cost_to_customer_per_qty) AS total_spent
FROM farmers_market.customer_purchases
WHERE DATEDIFF('2019-09-25', market_date) <= 14 AND DATEDIFF('2019-09-25', market_date) >= 0
*/
-- 3
SELECT
	market_date,
    market_day,
    DAYNAME(market_date) AS calculated_market_day,
    CASE
		WHEN DAYNAME(market_date) = market_day THEN 'Yes'
        ELSE 'No'
	END AS check_market_day
FROM farmers_market.market_date_info
