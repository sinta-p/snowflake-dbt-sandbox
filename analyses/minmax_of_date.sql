select 
    min(orderdate) as min_orderdate,
    max(orderdate) as max_orderdate
from 
    {{ ref('fct_order_items') }}

