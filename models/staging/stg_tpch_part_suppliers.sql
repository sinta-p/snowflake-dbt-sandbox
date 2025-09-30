select 
    ps_partkey as partkey,
    ps_suppkey as suppkey,
    ps_availqty as availqty,
    ps_supplycost as supplycost,
    ps_comment as comment
from {{ source('tpch_sf001', 'partsupp') }}