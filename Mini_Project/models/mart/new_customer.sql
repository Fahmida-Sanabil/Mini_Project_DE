{{
    config(
        materialized='table',
        tags=['mart']
    )
}}
WITH new_customer AS (
    SELECT
        customer_id,
        customer_name,
        CAST(MIN(payment_month) AS DATE) AS first_order_date
    FROM
       {{ref('master1')}}
    GROUP BY
        customer_id,
        customer_name
)
SELECT
    YEAR(first_order_date) AS fiscal_year,
    COUNT(customer_id) AS No_of_new_customers
FROM
    new_customer
GROUP BY
    fiscal_year
ORDER BY
    fiscal_year
 