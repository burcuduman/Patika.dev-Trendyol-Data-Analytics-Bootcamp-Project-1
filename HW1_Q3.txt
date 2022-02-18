/* E ticaret sitemiz için günün bölümlerinde, en fazla ilgi gören kategorileri öğrenmek istiyoruz. */
with Q3 as(    
    select distinct v2ProductCategory as Product_Category,count(visitId) as visited_x_times, dayPart, row_number() over(partition by dayPart order by -count(visitId)) as numbered 
    from(
        select distinct v2ProductCategory, visitId,  h.hour,
        case when h.hour between 6 and 10 then 'Morning drive time 6AM-10AM'
            when h.hour between 10 and 15 then 'Midday 10AM-3PM'
            when h.hour between 16 and 19 then 'Afternoon drive time 4PM-7PM'
            when h.hour between 20 and 23 then 'Prime time 8PM-11PM'
            else 'Night time 00 -5AM'
        end as dayPart
        from `data-to-insights.ecommerce.web_analytics` as wa
        cross join unnest(wa.hits) as h 
        cross join unnest(h.product) as products
        where v2ProductCategory!='(not set)'
        group by 1,2,3,4
        
    )
    group by 1,3
    order by 2 desc
)

select * from Q3 
where numbered =1


