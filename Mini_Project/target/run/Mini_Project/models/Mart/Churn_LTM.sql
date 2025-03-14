
  
    

        create or replace transient table mini_project.mart.Churn_LTM
         as
        (
WITH customer_year_churn_calculation AS (
    SELECT
        customer_id,
        revenue_type,
        revenue,
        payment_month,
        MAX(payment_month) OVER (PARTITION BY customer_id ORDER BY payment_month DESC) AS last_payment_month
    FROM
        mini_project.intermediate.master1
    WHERE
        revenue_type = 'True'
),
compare AS (
    SELECT
        *,
        DATEDIFF(year, last_payment_month, '2020-01-05') AS Churn_year_period,
        CASE
            WHEN DATEDIFF(year, last_payment_month, '2020-01-05') > 1 THEN 'Customer_churn'
            ELSE 'Active_customer'
        END AS LTM_Churn
    FROM
        customer_year_churn_calculation
),
final_year AS (
    SELECT
        LTM_Churn,
        SUM(revenue) AS LTM_Revenue,
        COUNT(LTM_Churn) AS LTM_Count
    FROM
        compare
    GROUP BY
        LTM_Churn
)
SELECT
    *
FROM
    final_year
        );
      
  