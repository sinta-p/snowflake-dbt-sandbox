{{
    config(
        materialized = 'table',
    )
}}

with
base_dates as (
    {{
        dbt.date_spine(
            'day',
            "DATE('2019-03-04')",
            "DATE('2025-10-03')"
        )
    }}
),

final as (
    select
        cast(date_day as date) as date_day
    from base_dates
),

timeframe as (
    select *
    from final
    where date_day > dateadd(year, -5, current_date())  -- Keep recent dates only
    and date_day < dateadd(day, 30, current_date())
),

revenue as (
    select 
        cast(orderdate as date) as orderdate,
        sum(extendedprice) as daily_sales
    from {{ ref("fct_order_items") }}
    group by orderdate
    order by orderdate
)


select 
    tf.date_day as date,
    coalesce(rev.daily_sales, 0) as daily_sales
from revenue as rev
full outer join timeframe as tf
    on rev.orderdate = tf.date_day
order by date