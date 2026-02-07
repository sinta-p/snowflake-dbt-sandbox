-- check if there is any reprocess_date variable which should trigger the delete post hook to happen
{% set pre_hook_statements = [] %}
{% if env_var('DBT_REPROCESS_DATE', none) is not in ['', 'none', 'null'] %}
    {% do pre_hook_statements.append(
    """
    DELETE FROM {{ this }} 
    WHERE modified_at = '{{ env_var('DBT_REPROCESS_DATE') }}';
    """
  ) %}
{% endif %}


{{
    config(
        materialized='incremental',
        unique_key='order_id',
        tags=["inc"],
        pre_hook=pre_hook_statements
    )
}}

select * from {{ source('inc_sources', 'inc_raw_orders',) }}

{% if is_incremental() %}
    -- this filter will only be applied on an incremental run
    where modified_at > (select max(modified_at) from {{ this }}) 
{% endif %}