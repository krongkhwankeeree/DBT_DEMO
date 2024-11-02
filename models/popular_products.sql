{% set groups = ["batteries", "laptop", "headphone"] %}

with
    products_with_group as (
        select
            *,
            case
                {% for group in groups %}
                    when lower(product) like '%{{ group }}%' then '{{group}}'
                {% endfor %}
                else 'other'
            end as product_group
        from {{ ref("sales_table") }}
    )
select product_group, sum(`Quantity Ordered`) as sale_count
from products_with_group
group by 1
order by sale_count desc
