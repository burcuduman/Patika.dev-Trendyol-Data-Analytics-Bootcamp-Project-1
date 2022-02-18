/* Mart, nisan, mayıs aylarında ziyaretçilerin en çok görüntülediği fakat 
satın alınmamış ürünlere ihtiyacımız var.
 Her ayın top 10 ürününü gösterebilir misiniz? (Tarih yıl - ay olarak gösterilmeli.)*/


with Q2 as(
select product, Year, Month,Total_View,visited,row_number() over(partition by Year,Month order by Total_View desc, visited desc) as nth, Total_soldTimes 
from(
    select distinct product, Year, Month,visited, Total_View, Total_soldTimes,
    from(
        select distinct product, Year, Month, count(visitId) as visited,
        sum(viewed) as  Total_View, sum(sold) as Total_soldTimes, 
        from (
            select distinct visitId, v2ProductName as product, 
            extract (year from PARSE_DATE("%Y%m%d", date)) as Year,
            FORMAT_DATE("%B", PARSE_DATE("%Y%m%d", date)) as Month,
            if(eCommerceAction_type='2',1,0) as viewed,
            if(eCommerceAction_type='6',1,0) as sold
            from `data-to-insights.ecommerce.all_sessions` all_ses
            group by 1,2,3,4,5,6
            )
        group by 1,2,3
        )
    )
    where Total_soldTimes=0 
    and Year = 2017
    and Month in ('March','April','May')
)

select distinct product, concat(Year, ' ',Month) as Date , visited, Total_View,nth, Total_soldTimes from Q2 
  where nth<11
  order by Date,nth