WITH required_fields AS (
    SELECT
        c.customer_id,
        c.customer_name,
        t.payment_month,
        t.revenue_type,
        t.revenue,
        t.quantity,
        p.product_id,
        p.product_family,
        p.product_sub_family

    FROM 
        {{ ref('stg_customers') }} c
    FULL JOIN
        {{ ref('stg_transaction') }} t ON t.customer_id = c.customer_id
    FULL JOIN
        {{ ref('stg_products') }} p ON p.product_id = t.product_id
)
SELECT * 
FROM required_fields