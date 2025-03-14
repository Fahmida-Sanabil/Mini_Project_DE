


WITH

required_fields AS (

    SELECT

        product_id                
        , product_family
        , product_sub_family

    FROM MINI_PROJECT.RAW.PRODUCTS
    WHERE
    product_id is not null

),

optimized AS(
    SELECT
        product_id                
        , product_family
        , product_sub_family

    FROM required_fields
)
SELECT
    *
FROM optimized