
{{
    config(
        materialized='table',
        tags=['mart']
    )
}}
WITH ranking AS (
    SELECT
        customer_id,
        customer_name,
        SUM(revenue) AS total_revenue,
        RANK() OVER (ORDER BY SUM(revenue) DESC) AS revenue_rank
    FROM {{ ref('master1') }}
    GROUP BY customer_id, customer_name
    having customer_id is not null
)
SELECT * FROM ranking
 