SELECT * FROM `online sales data`;
rename table `online sales data` to online_sales;
select * 
from online_sales
where ProdcutCategory is null;
alter table online_sales
rename column `Transaction ID` to transaction_ID,
rename column `Product Category` to product_category,
rename column `Units Sold` to units_sold,
rename column `Unit Price` to unit_price,
rename column `Total Revenue` to total_revenue,
rename column `Payment Method` to payment_method;

alter table online_sales
rename column `Date` to `date`,
rename column Region to region;

alter table online_sales2
rename column `Product Name` to product_name;

create table online_sales2
like online_sales;

insert into online_sales2
select *
from online_sales;

select region
from online_sales2
where region is null or '';

update  online_sales2
set region = trim(region);

alter table online_sales2
modify column `date` date;

-- Revenue by category
select product_category, sum(total_revenue)
from online_sales2
group by product_category
order by sum(total_revenue)desc;

-- Revenue by region
select region, sum(total_revenue)
from online_sales2
group by region
order by sum(total_revenue) desc;

-- Revenue by month 
select substring(`date`, 6,2) as `Month`, sum(total_revenue) as total_revenue
from online_sales2
group by `Month`
order by sum(total_revenue) desc;

-- Top 5 products by revenue 
select product_name, sum(total_revenue)
from online_sales2
group by product_name
order by sum(total_revenue) desc;

-- Best performing payment method
select payment_method, sum(total_revenue)
from online_sales2
group by payment_method
order by sum(total_revenue) desc;

-- Average order value by category 
select product_category, avg(total_revenue)
from online_sales2
group by product_category
order by  avg(total_revenue) desc;
 
-- Which category has highest average unit price 
select product_category, avg(unit_price)
from online_sales2
group by product_category
order by avg(unit_price) desc ;

-- Which month had lowest sales 
select substring(`date`, 6,2) as `Month`, sum(units_sold)
from online_sales2
group by `Month`
order by sum(units_sold) asc;

-- Which region generates the highest total revenue
select region, sum(total_revenue)
from online_sales2
group by region
order by sum(total_revenue) desc;

-- Which region has the highest average spending per transaction
select region, avg(unit_price)
from online_sales2
group by region
order by avg(unit_price) desc;

-- Units Sold VS Revenue Comparison by Category
select product_category, sum(units_sold) as units_sold, sum(total_revenue) as total_revenue
from online_sales2
group by product_category
order by total_revenue desc;






