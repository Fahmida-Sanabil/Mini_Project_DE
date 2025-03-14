
  
    

        create or replace transient table mini_project.staging.stg_region
         as
        (


WITH

required_fields AS (

    SELECT

        customer_id             
        , country
        , region

    FROM MINI_PROJECT.RAW.REGION

),

optimized AS(
    SELECT
        CAST(customer_id AS INT)     AS customer_id            
        , country
        , region

    FROM required_fields

)
SELECT
    *
FROM optimized
        );
      
  