
WITH ranking AS (
    SELECT
        product_id,product_family,
        COALESCE(SUM(revenue), 0) AS total_revenue,
        RANK() OVER (ORDER BY(total_revenue) DESC) AS revenue_rank
    FROM mini_project.intermediate.master1
    GROUP BY product_id,product_family
)
SELECT * FROM ranking