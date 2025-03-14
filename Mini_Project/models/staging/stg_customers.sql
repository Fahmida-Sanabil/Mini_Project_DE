{{
    config(
        tags=['basic', 'staging']
    )
}}


WITH

required_fields AS (

    SELECT

        customer_id                
        , customer_name
        , company

    FROM {{ source('source_name', 'CUSTOMERS') }}
    WHERE
    customer_id is not null

),

datatype_conversion AS (

    SELECT 

        CAST(customer_id AS INT)    AS customer_id
        , customer_name
        , company

    FROM required_fields

),

optimized AS(
    SELECT
        DISTINCT customer_id
        , customer_name
        , company

    FROM datatype_conversion
)
SELECT
    *
FROM optimized             