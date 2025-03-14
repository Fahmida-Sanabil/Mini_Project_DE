{{
    config(
        materialized='table',
        tags=['mart']
    )
}}
WITH Churne AS (
    SELECT 
        customer_id,
        customer_name,
        CAST(MAX(payment_month) AS DATE) AS last_transaction_date,
        
    FROM
        {{ ref('master1') }}
    WHERE
        revenue_type = 'True'
    GROUP BY
        customer_id,
        customer_name
    HAVING
        last_transaction_date < ADD_MONTHS(CURRENT_DATE, -6)
)
SELECT
    *
FROM
    Churne