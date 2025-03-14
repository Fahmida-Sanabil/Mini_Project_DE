WITH required_fields AS (
    SELECT
        c.*,
        t.t_customer_id,
        t.t_product_id,
        t.payment_month,
        t.revenue_type,
        t.revenue,
        t.quantity,
        p.*
    FROM 
        MINI_PROJECT.RAW.stg_customers c
    FULL JOIN
        MINI_PROJECT.RAW.stg_transaction t ON t.t_customer_id = c.customer_id
    FULL JOIN
        MINI_PROJECT.RAW.stg_products p ON p.product_id = t.t_product_id
)
SELECT * 
FROM required_fields