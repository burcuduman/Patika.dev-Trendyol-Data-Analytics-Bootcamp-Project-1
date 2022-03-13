--> Promosyon çıkılmış fakat hiç satılmamış ürünleri tespit edebilir miyiz?
with Q1 as(select v2ProductName, visitId,ever_sold
from(select v2ProductName, visitId,sum(is_sold) over(partition by w.v2ProductName, w.visitId) as ever_sold 
    from(
    select distinct v2ProductName, visitId, eCommerceAction_type,
            case when eCommerceAction_type='6'then 1 else 0 end as is_sold
            from (
                select  distinct a.visitId,  b.v2ProductName, a.eCommerceAction_type 
                from ( select * from `data-to-insights.ecommerce.web_analytics` as wa
                    cross join unnest(wa.hits) as h 
                    cross join unnest(h.product) as products_unnest) as b
            full join `data-to-insights.ecommerce.all_sessions` a on a.visitId=b.visitId) 
            as products_unnest
        
    ) as w) group by 1,2,3
)



select distinct v2ProductName, ever_sold 
--,promoName 
from ( select * from(`data-to-insights.ecommerce.web_analytics` as wa
        cross join unnest(wa.hits) as h 
        cross join unnest(h.promotion) as promos_unnest
        join Q1 on Q1.visitId=wa.visitId) 
        where v2ProductName is not null AND promoName is not null AND ever_sold=0)
        order by v2ProductName
