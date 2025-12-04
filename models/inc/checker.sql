{{
    config(
        tags=["inc"]
    )
}}

select * from {{ ref("inc_orders")}}

