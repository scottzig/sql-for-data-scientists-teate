-- Exercises from Ch. 10 of SQL for Data Scientists by Teate

-- 1
-- Create the view of sales by day by vendor:
/*
CREATE VIEW farmers_market.vw_sales_by_day_vendor AS
    SELECT 
        cp.market_date,
        md.market_day,
        md.market_week,
        md.market_year,
        cp.vendor_id,
        v.vendor_name,
        v.vendor_type,
        ROUND(SUM(cp.quantity * cp.cost_to_customer_per_qty), 2) AS sales
    FROM
        farmers_market.customer_purchases AS cp
            LEFT JOIN
        farmers_market.market_date_info AS md ON cp.market_date = md.market_date
            LEFT JOIN
        farmers_market.vendor AS v ON cp.vendor_id = v.vendor_id
    GROUP BY cp.market_date , cp.vendor_id
    ORDER BY cp.market_date , cp.vendor_id
    */
    
/*
SELECT 
    s.vendor_name, 
    s.market_week,
    SUM(s.sales) AS weekly_sales
FROM
    farmers_market.vw_sales_by_day_vendor AS s
GROUP BY s.vendor_name, s.market_week
ORDER BY s.market_week
*/

-- 2
/*
WITH vendor_booth_number AS
(
SELECT
	market_date,
	vendor_id,
	booth_number,
	LAG(booth_number,1) OVER (PARTITION BY vendor_id ORDER BY market_date, vendor_id) AS previous_booth_number
FROM farmers_market.vendor_booth_assignments
ORDER BY market_date, vendor_id, booth_number
)
SELECT *
FROM vendor_booth_number AS vbn
WHERE 
	vbn.market_date = '2019-04-10' AND (vbn.booth_number <> vbn.previous_booth_number OR vbn.previous_booth_number IS NULL)
*/

-- 3
SELECT 
    cp.market_date,
    md.market_day,
    md.market_week,
    md.market_year,
    cp.vendor_id,
    v.vendor_name,
    v.vendor_type,
    vba.booth_number,
    b.booth_type,
    ROUND(SUM(cp.quantity * cp.cost_to_customer_per_qty), 2) AS sales
FROM farmers_market.customer_purchases AS cp
        LEFT JOIN
    farmers_market.market_date_info AS md ON cp.market_date = md.market_date
        LEFT JOIN
    farmers_market.vendor AS v ON cp.vendor_id = v.vendor_id
		LEFT JOIN
	farmers_market.vendor_booth_assignments AS vba ON cp.vendor_id = vba.vendor_id AND cp.market_date = vba.market_date
        LEFT JOIN
	farmers_market.booth AS b ON vba.booth_number = b.booth_number
GROUP BY cp.market_date, cp.vendor_id, vba.booth_number, b.booth_type
ORDER BY cp.market_date, cp.vendor_id, vba.booth_number, b.booth_type
