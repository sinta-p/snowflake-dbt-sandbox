select
    extendedprice
from {{ ref('fct_order_items') }}
having extendedprice < 0

