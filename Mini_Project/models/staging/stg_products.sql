{{
    config(
        tags=['basic', 'staging']
    )
}}


WITH

required_fields AS (

    SELECT

        product_id                
        , product_family
        , product_sub_family

    FROM {{ source('source_name', 'PRODUCTS') }}
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