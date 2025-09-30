with line_items as (
    select 
        orderkey,
        partkey,
        suppkey,
        linenumber,
        quantity,
        extendedprice,
        discount,
        tax,
        returnflag,
        linestatus,
        shipdate,
        commitdate,
        receiptdate,
        shipinstruct,
        shipmode,
        comment
    from {{ ref('stg_tchp_line_items') }}
),
orders as (
    select 
        orderkey,
        custkey,
        orderstatus,
        totalprice,
        orderdate,
        orderpriority,
        clerk,
        shippriority,
        comment
    from {{ ref("stg_tpch_orders") }}
)
select 
    concat(li.orderkey, '-', li.partkey, '-', li.suppkey, '-', li.linenumber) as transactionkey,
    li.orderkey,
    li.partkey,
    li.suppkey,
    li.linenumber,
    li.quantity,
    li.extendedprice,
    li.discount,
    li.tax,
    li.returnflag,
    li.linestatus,
    li.shipdate,
    li.commitdate,
    li.receiptdate,
    li.shipinstruct,
    li.shipmode,
    li.comment as lineitem_comment,
    o.custkey,
    o.orderstatus,
    o.totalprice,
    o.orderdate,
    o.orderpriority,
    o.clerk,
    o.shippriority,
    o.comment as order_comment
from line_items li
inner join orders o on li.orderkey = o.orderkey