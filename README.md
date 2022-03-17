# Project 1
# E-commerce analysis by using Google BigQuery
In this project I have used Google BigQuery’s sample dataset data-to-insights.ecommerce data. There were some business questions regarding this data which I have answered as a decision maker. The questions include detecting the products that has been promoted but never sold, top 10 most viewed but never sold products of specific months and shopping categories that have the most traffic in different parts of the day. The detail of this project can be found below.
To access the data:

Once BigQuery is open, click on the below direct link to bring in the public data-to-insights project into your BigQuery projects panel:
https://bigquery.cloud.google.com/table/data-to-insights:ecommerce.all_sessions_raw


## [Question 1](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Project-1/blob/master/HW1_Q1.sql)
From Google Analytics sample data-to-insights.ecommerce dataset, detect the products that have been promoted but never sold.

+ e-commerce dataset has different tables inside such as web_analytics and all_sessions. web_analytics table has nested table as hits and inside hits there are nested arrays as product and promotion. First, for finding the products that has never been sold regardless from the promotions I have chosen the product names which has eCommerceAction_type is 6 which means in a session checkout has happened, therefore the product name in the row is sold. For finding every row which includes the same product name and different action types, I created a flag column such as is_sold which is 1 if product is sold. By summing the is_sold column partitioned by product name I found the ones which has never been sold as sum of is_sold=0 
+ Then I have unnested the promotion array inside hits table again and inner joined with the above table where I found the products that have never been sold. By performing that inner join on product names, I got the products that have never been sold and have a promotion. I have found 599 unique products.


## [Question 2](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Project-1/blob/master/HW1_Q2.sql)
From Google Analytics sample data-to-insights.ecommerce dataset, find the top 10 most viewed but never sold products of specific months such as March, April and May.

+ In the same dataset again from Q1 eCommerceAction_type = 6 means product is sold in the session and eCommerceAction_type = 2 is viewed. By using that information, I again did the same flag operation where if sold and viewed I put 1 in columns “sold” and “viewed”. By summing the amount of viewed and counting distinct visitIds I approximated a traffic. By using that traffic as most viewed and choosing the products that have never been sold, I ranked the products partitioned by in March, April and May. By using this table, which is Q2, I selected the top 10 products that has the most view and never sold by using the rank that I have given such as nth < 10.


## [Question 3](https://github.com/burcuduman/Patika.dev-Trendyol-Data-Analytics-Bootcamp-Project-1/blob/master/HW1_Q3.sql)
From Google Analytics sample data-to-insights.ecommerce dataset, find the categories that interests the visitors most in different parts of the day.

+ First of all, I use international dayparts that I have found from Wikipedia which is between 6am and 10am the day part is Morning drive time, 10am to 3pm is Midday, 4pm to 7pm is Afternoon drive time, 8pm to 11pm is Prime time and rest is Night time. By using the count of distinct visitIDs, I estimated the interest of visitors since the variety of visitors determine a popularity, I have ranked the categories for each day part. Then, I have selected the number 1 category for each daypart.

