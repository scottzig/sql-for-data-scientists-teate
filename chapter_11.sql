-- Exercises from Ch. 11 of SQL for Data Scientists by Teate

-- 1
/*
WITH sales_per_market_date AS
(
SELECT
	market_date,
	ROUND(SUM(quantity * cost_to_customer_per_qty),2) AS sales
	FROM farmers_market.customer_purchases
	GROUP BY market_date
	ORDER BY market_date
),
record_sales_info AS
(
SELECT
	cm.market_date,
	cm.sales,
	MAX(pm.sales) AS previous_max_sales,
	CASE WHEN cm.sales > MAX(pm.sales)
		THEN "YES"
		ELSE "NO"
	END AS sales_record_set
FROM sales_per_market_date AS cm
	LEFT JOIN sales_per_market_date AS pm
		ON pm.market_date < cm.market_date
GROUP BY cm.market_date, cm.sales
)

SELECT 
	sales,
    market_date
FROM record_sales_info
WHERE sales_record_set = "YES"
ORDER BY market_date
*/

-- 2
WITH customer_markets_attended AS
(
SELECT DISTINCT
	customer_id,
	market_date,
	MIN(market_date) OVER(PARTITION BY cp.customer_id) AS first_purchase_date
FROM farmers_market.customer_purchases AS cp
)

SELECT
	md.market_year,
	md.market_week,
	COUNT(customer_id) AS customer_visit_count,
	COUNT(DISTINCT customer_id) AS distinct_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cma.market_date = cma.first_purchase_date
			THEN customer_id
			ELSE NULL
		END) AS new_customer_count,
	COUNT(DISTINCT 
		CASE WHEN cma.market_date = cma.first_purchase_date
			THEN customer_id
			ELSE NULL
		END)
	/ COUNT(DISTINCT customer_id) AS new_customer_percent
FROM customer_markets_attended AS cma
	LEFT JOIN farmers_market.market_date_info AS md
		ON cma.market_date = md.market_date
GROUP BY md.market_year, md.market_week
ORDER BY md.market_year, md.market_week