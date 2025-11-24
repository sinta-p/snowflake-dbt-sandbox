{{ config(
    materialized="view", 
    meta={'required_test': None}
) }}
with customer_spending as (
    select
        custkey,
        sum(extendedprice) as total_spending,
        count(*) as total_transactions,
        count(distinct orderkey) as unique_orders
    from {{ ref('order_items') }}
    group by 1
)

select
    custkey,
    total_spending,
    total_transactions,
    unique_orders
from customer_spending
