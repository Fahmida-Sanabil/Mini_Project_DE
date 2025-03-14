
WITH InitialPurchase AS (
    SELECT
        customer_id,
        product_family,
        MIN(CAST(payment_month AS DATE)) AS first_purchase_date
    FROM
        mini_project.intermediate.master1
    GROUP BY
        customer_id,
        product_family
),
ProductSubFamilyCount AS (
    SELECT
        customer_id,
        product_family,
        DATE_TRUNC('month', CAST(payment_month AS DATE)) AS payment_month,
        COUNT(DISTINCT product_sub_family) AS sub_family_count
    FROM
        mini_project.intermediate.master1
    GROUP BY
        customer_id,
        product_family,
        DATE_TRUNC('month', CAST(payment_month AS DATE))
),
CrossSell AS (
    SELECT
        t.customer_id,
        t.customer_name,
        t.product_id,
        t.product_family,
        t.product_sub_family,
        t.payment_month,
        psf.sub_family_count,
        LAG(psf.sub_family_count) OVER (PARTITION BY t.customer_id, t.product_family ORDER BY t.payment_month) AS prev_sub_family_count
    FROM
        mini_project.intermediate.master1 t
    JOIN
        InitialPurchase ip ON t.customer_id = ip.customer_id AND t.product_family = ip.product_family
    JOIN
        ProductSubFamilyCount psf ON t.customer_id = psf.customer_id AND t.product_family = psf.product_family AND DATE_TRUNC('month', CAST(t.payment_month AS DATE)) = psf.payment_month
    WHERE
        t.payment_month >= ip.first_purchase_date
)
SELECT
    customer_id,
    customer_name,
    product_id,
    product_family,
    product_sub_family,
    payment_month,
    sub_family_count,
    prev_sub_family_count,
    CASE
        WHEN sub_family_count > prev_sub_family_count THEN 'Yes'
        ELSE 'No'
    END AS is_cross_sell
FROM
    CrossSell
WHERE
    prev_sub_family_count IS NOT NULL
ORDER BY
    customer_id,
    product_family,
    payment_month