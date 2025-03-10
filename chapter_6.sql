-- Exercises from Ch. 6 of SQL for Data Scientists by Teate

-- 1
/*
SELECT
	vendor_id,
    count(vendor_id) AS assignment_counts
FROM farmers_market.vendor_booth_assignments
GROUP BY vendor_id
*/

-- 2
/*
SELECT
	pc.product_category_name,
    p.product_name,
    MIN(vi.market_date) AS first_date_available,
    MAX(vi.market_date) AS last_date_available
FROM farmers_market.vendor_inventory AS vi
INNER JOIN farmers_market.product AS p
	ON vi.product_id = p.product_id
INNER JOIN farmers_market.product_category AS pc
	ON p.product_category_id = pc.product_category_id
WHERE pc.product_category_name = 'Fresh Fruits & Vegetables'
GROUP BY pc.product_category_name, p.product_name, vi.market_date
*/

-- 3
SELECT
	c.customer_id,
	c.customer_last_name,
    c.customer_first_name,
    SUM(cp.cost_to_customer_per_qty*cp.quantity) AS total_spent
FROM farmers_market.customer AS c
INNER JOIN farmers_market.customer_purchases AS cp
	ON c.customer_id = cp.customer_id
GROUP BY c.customer_id, c.customer_last_name, c.customer_first_name
HAVING total_spent > 50
ORDER BY c.customer_last_name, c.customer_first_name