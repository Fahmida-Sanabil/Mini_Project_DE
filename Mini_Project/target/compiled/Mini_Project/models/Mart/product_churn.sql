
WITH LastSale AS (
    SELECT
        product_id, 
        product_family,
        product_sub_family,
        CAST(MAX(payment_month) AS DATE) AS last_sale_date
    FROM
        mini_project.intermediate.master1
    GROUP BY
        product_id,
        product_family, 
        product_sub_family
),
ChurnedProducts AS (
    SELECT
        product_id,
        product_family, 
        product_sub_family,
        last_sale_date,
        YEAR(last_sale_date) AS last_sale_year
    FROM
        LastSale
    WHERE
        last_sale_date < DATEADD(year, -1, CURRENT_DATE())
)
SELECT
    last_sale_year AS fiscal_year,
    product_family, 
    product_sub_family,
    COUNT(product_id) AS No_of_churned_products
FROM
    ChurnedProducts
GROUP BY
    fiscal_year, product_family, product_sub_family
ORDER BY
    fiscal_year