select 
    S_SUPPKEY as suppkey,
    S_NAME as name,
    S_ADDRESS as address,
    S_NATIONKEY as nationkey,
    S_PHONE as phone,
    S_ACCTBAL as acctbal,
    S_COMMENT as comment
from {{ source('tpch_sf001', 'supplier') }}