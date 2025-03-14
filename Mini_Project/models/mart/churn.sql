{{
    config(
        materialized='table',
        tags=['mart']
    )
}}
WITH LastTransaction AS (
    SELECT
 customer_id,
        customer_name,
        MAX(payment_month) AS last_transaction_date
    FROM
        {{ ref('master1') }}
    WHERE
        revenue_type = 1
    GROUP BY
        customer_id,
        customer_name
),
ChurnedCustomers AS (
    SELECT
        customer_id,
        customer_name,
        last_transaction_date,
        CASE
            WHEN last_transaction_date < DATEADD(month, -6, CURRENT_DATE()) THEN 'Yes'
            ELSE 'No'
        END AS is_churned
    FROM
        LastTransaction
)
SELECT
    customer_id,
    customer_name,
    last_transaction_date,
    is_churned
FROM
    ChurnedCustomers
WHERE
    is_churned = 'Yes'
ORDER BY
    last_transaction_date