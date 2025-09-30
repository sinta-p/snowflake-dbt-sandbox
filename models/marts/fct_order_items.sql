with order_items as (
    select 
        transactionkey,
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
        lineitem_comment,
        custkey,
        orderstatus,
        totalprice,
        orderdate,
        orderpriority,
        clerk,
        shippriority,
        order_comment
    from {{ ref('order_items') }}
),
part_suppliers as (
    select 
        partkey,
        suppkey,
        availqty,
        supplycost,
        part_supplier_comment, 
        part_name, 
        part_mfgr, 
        part_brand, 
        part_type, 
        part_size, 
        part_container, 
        part_retailprice, 
        part_comment, 
        supplier_name, 
        supplier_address, 
        supplier_nationkey, 
        supplier_phone, 
        supplier_acctbal, 
        supplier_comment
    from {{ ref('part_suppliers') }}
)
select 
    oi.transactionkey,
    oi.quantity,
    oi.custkey,
    oi.extendedprice,
    oi.orderdate,
    ps.part_name as partname,
    ps.supplier_name as suppliername,
from order_items oi
inner join part_suppliers ps on oi.partkey = ps.partkey and oi.suppkey = ps.suppkey