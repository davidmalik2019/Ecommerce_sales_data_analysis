

SELECT device_type,order_id,items_purchased,primary_product_id,product_name,price_usd
 FROM orders INNER JOIN website_sessions 
ON orders.website_session_id= website_sessions.user_id 
INNER JOIN products ON products.product_id= orders.primary_product_id;




SELECT device_type,SUM(price_usd) AS total_revenue FROM orders
INNER JOIN website_sessions ON orders.website_session_id= website_sessions.user_id 
INNER JOIN products ON products.product_id= orders.primary_product_id 
GROUP BY device_type ORDER BY total_revenue DESC;


SELECT
    -- Format the date to show Year and Month
    EXTRACT(YEAR FROM website_sessions.created_at) AS year,
    EXTRACT(MONTH FROM website_sessions.created_at) AS month,
    MIN(DATE(website_sessions.created_at)) AS month_started_at, -- To help with visualization
    COUNT(DISTINCT website_sessions.website_session_id) AS sessions,
    COUNT(DISTINCT orders.order_id) AS orders,
    -- Calculate conversion rate (orders divided by sessions)
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) AS session_to_order_conv_rt
FROM
    website_sessions 
LEFT JOIN
    orders ON website_sessions.website_session_id = orders.website_session_id
   
-- Optional: Filter for a specific date range or campaign
-- WHERE
--     ws.created_at >= '2025-01-01' AND ws.created_at < '2025-09-01'
GROUP BY
    year,
    month
ORDER BY
    year,
    month;
