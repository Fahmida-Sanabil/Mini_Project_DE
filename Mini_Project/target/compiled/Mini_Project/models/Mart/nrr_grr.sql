
WITH RevenueData AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', CAST(payment_month AS DATE)) AS month,
        SUM(revenue) AS total_revenue
    FROM
        mini_project.intermediate.master1
    WHERE
        revenue_type = 'True'
    GROUP BY
        customer_id,
        DATE_TRUNC('month', CAST(payment_month AS DATE))
),
MonthlyRevenue AS (
    SELECT
        month,
        SUM(total_revenue) AS monthly_revenue
    FROM
        RevenueData
    GROUP BY
        month
),
PreviousMonthRevenue AS (
    SELECT
        month,
        LAG(monthly_revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM
        MonthlyRevenue
),
NRR_GRR_Calculation AS (
    SELECT
        mr.month,
        mr.monthly_revenue,
        pmr.previous_month_revenue,
        (mr.monthly_revenue / pmr.previous_month_revenue) * 100 AS NRR,
        (mr.monthly_revenue / pmr.previous_month_revenue) * 100 AS GRR
    FROM
        MonthlyRevenue mr
    JOIN
        PreviousMonthRevenue pmr ON mr.month = pmr.month
    WHERE
        pmr.previous_month_revenue IS NOT NULL
)
SELECT
    month,
    monthly_revenue,
    previous_month_revenue,
    NRR,
    GRR
FROM
    NRR_GRR_Calculation
ORDER BY
    month