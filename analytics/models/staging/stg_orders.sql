with source as (
    select * from {{ source('public', 'raw_orders') }}
),

renamed as (
    select
        order_id,
        customer_id,
        cast(amount as numeric(10,2)) as order_amount,
        lower(status) as order_status,
        order_date
    from source
) 

select * from renamed