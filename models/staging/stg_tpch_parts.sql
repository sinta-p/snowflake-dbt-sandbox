select 
    P_PARTKEY as partkey,
    P_NAME as name,
    P_MFGR as mfgr,
    P_BRAND as brand,
    P_TYPE as type,
    P_SIZE as size,
    P_CONTAINER as container,
    P_RETAILPRICE as retailprice,
    P_COMMENT as comment
from {{ source('tpch_sf001', 'part') }}