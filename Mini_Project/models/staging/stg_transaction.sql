with required_fields as (
  select *
  from {{ source('source_name', 'TRANSACTION') }}
),
 
cleaned_transations as (
  select DISTINCT
    trim(customer) as customer_id,
    trim(product_id) as product_id,
    payment_month,
    revenue_type,
    cast(revenue as numeric) as revenue,
    quantity,
    trim(dimension1) as dimension1,
    trim(dimension2) as dimension2,
    trim(dimension3) as dimension3,
    trim(dimension4) as dimension4,
    trim(dimension5) as dimension5,
    trim(dimension6) as dimension6,
    trim(dimension7) as dimension7,
    trim(dimension8) as dimension8,
    trim(dimension9) as dimension9,
    trim(dimension10) as dimension10,
    trim(companies) as companies
   
  from required_fields
  where customer_id is not null
)
 
select *
from cleaned_transations