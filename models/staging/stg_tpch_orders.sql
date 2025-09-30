select 
    O_ORDERKEY as orderkey,
    O_CUSTKEY as custkey,
    O_ORDERSTATUS as orderstatus,
    O_TOTALPRICE as totalprice,
    O_ORDERDATE as orderdate,
    O_ORDERPRIORITY as orderpriority,
    O_CLERK as clerk,
    O_SHIPPRIORITY as shippriority,
    O_COMMENT as comment
from {{ source("tpch_now", "orders") }}