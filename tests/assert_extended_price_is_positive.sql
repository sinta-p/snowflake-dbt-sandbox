select
    extendedprice
from {{ ref('order_items') }}
having extendedprice < 0

