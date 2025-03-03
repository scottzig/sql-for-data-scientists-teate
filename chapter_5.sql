-- Exercises from Ch. 5 of SQL for Data Scientists by Teate

-- 1
/*
SELECT *
FROM farmers_market.vendor as v
INNER JOIN farmers_market.vendor_booth_assignments as vba
	ON v.vendor_id = vba.vendor_id
ORDER BY v.vendor_name, vba.market_date
*/

-- 2
/*
SELECT *
FROM farmers_market.customer AS c
RIGHT JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
*/  
-- OR
/*
SELECT c.*, cp.*
FROM farmers_market.customer_purchases As cp
LEFT JOIN farmers_market.customer AS c
	ON cp.customer_id = c.customer_id
*/

-- 3
SELECT *
FROM farmers_market.product AS p
INNER JOIN farmers_market.product_category as pc
	ON p.product_category_id = pc.product_category_id
LEFT JOIN farmers_market.vendor_inventory as vi
	ON p.product_id = vi.product_id
