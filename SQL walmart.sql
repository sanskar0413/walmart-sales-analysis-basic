1. TOP 5 Performing Branch by Total Sales

SELECT TOP 5 Branch, 
       ROUND(SUM(unit_price * quantity), 2) AS total_sales
FROM df_walmart
GROUP BY Branch
ORDER BY total_sales DESC;

2. Lowest Performing Branch by Average Profit Margin

SELECT TOP 1 Branch, 
       ROUND(AVG(profit_margin), 2) AS avg_profit_margin
FROM df_walmart
GROUP BY Branch
ORDER BY avg_profit_margin ASC;

3.City Sales Leader

SELECT TOP 5 City, 
       ROUND(SUM(unit_price * quantity), 2) AS total_sales
FROM df_walmart
GROUP BY City
ORDER BY total_sales DESC;


4.Category Trend Analysis — total sales / month, 3-month moving avg, trend last 6 months

;WITH cat_month AS (
    SELECT
        [category],
        CONVERT(CHAR(7), TRY_CONVERT(DATE, [date], 103), 120) AS ym,
        SUM(CAST(REPLACE([unit_price], '$', '') AS DECIMAL(12,2)) * [quantity]) AS total_sales
    FROM df_walmart
    WHERE TRY_CONVERT(DATE, [date], 103) IS NOT NULL
    GROUP BY [category], CONVERT(CHAR(7), TRY_CONVERT(DATE, [date], 103), 120)
),
cat_mv AS (
    SELECT
        [category], ym, total_sales,
        AVG(total_sales) OVER (PARTITION BY [category] ORDER BY ym ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS mv_3
    FROM cat_month
),
ranked AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY [category] ORDER BY ym DESC) AS rn
    FROM cat_mv
)
SELECT
    c.[category],
    ROUND(AVG(CASE WHEN rn BETWEEN 1 AND 3 THEN total_sales END),2) AS avg_last_3_months,
    ROUND(AVG(CASE WHEN rn BETWEEN 4 AND 6 THEN total_sales END),2) AS avg_prev_3_months,
    CASE 
        WHEN AVG(CASE WHEN rn BETWEEN 1 AND 3 THEN total_sales END) IS NULL THEN 'insufficient data'
        WHEN AVG(CASE WHEN rn BETWEEN 4 AND 6 THEN total_sales END) IS NULL 
             AND AVG(CASE WHEN rn BETWEEN 1 AND 3 THEN total_sales END) > 0 THEN 'new/upswing'
        WHEN AVG(CASE WHEN rn BETWEEN 1 AND 3 THEN total_sales END) 
             >= 1.05 * AVG(CASE WHEN rn BETWEEN 4 AND 6 THEN total_sales END) THEN 'UP'
        WHEN AVG(CASE WHEN rn BETWEEN 1 AND 3 THEN total_sales END) 
             <= 0.95 * AVG(CASE WHEN rn BETWEEN 4 AND 6 THEN total_sales END) THEN 'DOWN'
        ELSE 'FLAT'
    END AS trend_last_6_months
FROM ranked c
GROUP BY c.[category];


 5. High-Value Transaction Detection (top 5% by sales amount) and compare avg profit margin

 ;WITH txn AS (
    SELECT
        *,
        CAST(REPLACE([unit_price], '$', '') AS DECIMAL(12,2)) * [quantity] AS sales_amount,
        (CAST(REPLACE([unit_price], '$', '') AS DECIMAL(12,2)) * [quantity]) * [profit_margin] AS profit_amount
    FROM df_walmart
),
p95 AS (
    SELECT 
        PERCENTILE_CONT(0.95) WITHIN GROUP (ORDER BY sales_amount) OVER () AS cutoff_95
    FROM txn
),
labeled AS (
    SELECT 
        t.*,
        CASE 
            WHEN t.sales_amount >= (SELECT TOP 1 cutoff_95 FROM p95) THEN 'Top 5%' 
            ELSE 'Other 95%' 
        END AS group_label
    FROM txn t
)
SELECT
    group_label,
    COUNT(*) AS cnt,
    ROUND(AVG(sales_amount), 2) AS avg_sales,
    ROUND(AVG(profit_amount / NULLIF(sales_amount, 0)), 4) AS avg_profit_margin
FROM labeled
GROUP BY group_label;

6.Yearly Profitability by Payment Method and Customer Rating Segment

;WITH txn AS (
    SELECT
        City,
        payment_method,
        CASE 
            WHEN rating >= 8 THEN 'High Rating (8-10)'
            WHEN rating >= 5 THEN 'Medium Rating (5-7.9)'
            ELSE 'Low Rating (<5)'
        END AS rating_segment,
        YEAR(TRY_CONVERT(DATE, [date], 103)) AS sales_year,
        CAST(REPLACE([unit_price], '$', '') AS DECIMAL(12,2)) * quantity AS sales_amount,
        (CAST(REPLACE([unit_price], '$', '') AS DECIMAL(12,2)) * quantity) * profit_margin AS profit_amount
    FROM df_walmart
)
SELECT
    sales_year,
    payment_method,
    rating_segment,
    ROUND(SUM(sales_amount), 2) AS total_sales,
    ROUND(SUM(profit_amount), 2) AS total_profit,
    ROUND(AVG(profit_amount / NULLIF(sales_amount, 0)), 4) AS avg_profit_margin,
    COUNT(*) AS transactions
FROM txn
GROUP BY
    sales_year,
    payment_method,
    rating_segment
ORDER BY
    sales_year,
    payment_method,
    rating_segment;
