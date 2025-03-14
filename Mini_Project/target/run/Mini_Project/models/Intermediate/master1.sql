
  
    

        create or replace transient table mini_project.intermediate.master1
         as
        (WITH required_fields AS (
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
        mini_project.staging.stg_customers c
    FULL JOIN
        mini_project.staging.stg_transaction t ON t.customer_id = c.customer_id
    FULL JOIN
        mini_project.staging.stg_products p ON p.product_id = t.product_id
)
SELECT * 
FROM required_fields
        );
      
  