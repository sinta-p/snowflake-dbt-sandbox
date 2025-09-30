with part_suppliers as (
    select 
        partkey,
        suppkey,
        availqty,
        supplycost,
        comment
    from {{ ref('stg_tpch_part_suppliers') }}
),
parts as (
    select 
        partkey,
        name,
        mfgr,
        brand,
        type,
        size,
        container,
        retailprice,
        comment
    from {{ ref('stg_tpch_parts') }}
),
suppliers as (
    select 
        suppkey,
        name,
        address,
        nationkey,
        phone,
        acctbal,
        comment
    from {{ ref('stg_tpch_suppliers') }}
)
select 
    ps.partkey,
    ps.suppkey,
    ps.availqty,
    ps.supplycost,
    ps.comment as part_supplier_comment,
    p.name as part_name,
    p.mfgr as part_mfgr,
    p.brand as part_brand,
    p.type as part_type,
    p.size as part_size,
    p.container as part_container,
    p.retailprice as part_retailprice,
    p.comment as part_comment,
    s.name as supplier_name,
    s.address as supplier_address,
    s.nationkey as supplier_nationkey,
    s.phone as supplier_phone,
    s.acctbal as supplier_acctbal,
    s.comment as supplier_comment
from part_suppliers ps
inner join parts p on ps.partkey = p.partkey
inner join suppliers s on ps.suppkey = s.suppkey