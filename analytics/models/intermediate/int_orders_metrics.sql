with orders as (
    select * from {{ ref('stg_orders') }}
),

transformed as (
    select
        order_id, 
        customer_id,
        order_amount,
        order_status,
        order_date,
        case 
            when order_status = 'completed' then true 
            else false 
        end as is_successful,
        case 
            when order_amount > 100 then 'High' 
            else 'Standard' 
        end as amount_tier
    from orders
)

select * from transformed