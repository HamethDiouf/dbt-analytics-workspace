{{ config(materialized='table') }}

with metrics as (
    select * from {{ ref('int_orders_metrics') }}
)
 
select
    customer_id,
    count(order_id) as total_orders,
    sum(case when is_successful then order_amount else 0 end) as total_revenue,
    min(order_date) as first_order_date,
    max(order_date) as last_order_date
from metrics
group by 1