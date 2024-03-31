use sales_ecom;
-- How many orders were placed in total?

select
   sum(Quantity_Ordered) as Total_order
from sales_ecom;

-- How many orders were placed in total?
select
   count(*) as Total_order
from sales_ecom;

-- How many distinct products were ordered?
select
   count(distinct Product) as Unique_product_order
from sales_ecom;

-- How many unique cities are associated with the orders?
select
   count(distinct Customer_City) as Unique_product_order
from sales_ecom;

-- What is the average price of each ordered product?
select
   avg(Price_Each) as avg_price
from sales_ecom;

-- How many orders were placed by female customers?
select
   Customer_Gender,
   count(Order_ID) as total_count
from sales_ecom
where Customer_Gender='Female'
group by Customer_Gender;

-- How many orders were placed in a specific city?
select
  Customer_City,
  count(Customer_City) as total_count
from sales_ecom
group by Customer_City
order by total_count desc;

-- How many different categories of products were ordered?
select
    count(distinct Category) as unique_category
from sales_ecom;

-- What is the average discount percentage applied to the orders?
select
    (avg(Discount)*100) as avg_discount
from sales_ecom;

-- What is the total revenue generated from all the orders?
select
   sum(Revenue) as Total_Revenue
from sales_ecom;

-- What is the average price of each product?

select
   Product,
   avg(Price_Each) as avg_price
from sales_ecom
group by Product;

-- Category By Revenue
select
   Category,
   count(Category) as total_count,
   sum(Revenue) as total_revenue
from sales_ecom
group by Category
order by total_revenue desc;

-- City Store By Revenue
select
   City_Store,
   count(City_Store) as total_count,
   sum(Revenue) as total_revenue
from sales_ecom
group by City_Store
order by total_revenue desc;

-- Customer_Age_Range By Revenue
select
   Customer_Age_Range,
   count(Customer_Age_Range) as total_count,
   sum(Revenue) as total_revenue
from sales_ecom
group by Customer_Age_Range
order by total_revenue desc;

-- Customer_Gender By Revenue
select
   Customer_Gender,
   count(Customer_Gender) as total_count,
   sum(Revenue) as total_revenue
from sales_ecom
group by Customer_Gender
order by total_revenue desc;

-- Month Name By Revenue
select
    month(Date) as Month_Name,
    sum(Revenue) as total_Revenue
from sales_ecom
group by Month_Name
order by total_Revenue desc;

-- What is the rank of each product based on its price?
select
   Product,
   Price_Each,
   dense_rank() over(partition by Product order by Price_Each) as rnk
from sales_ecom;

-- What is the rank of each customer's revenue based on the Revenue column?
select
   Order_ID,
   Revenue,
   dense_rank() over(partition by Order_ID order by Revenue desc) as rnk
from sales_ecom;

-- What is the cumulative revenue generated for each order?
SELECT Order_ID, 
        Revenue, 
        SUM(Revenue) OVER (ORDER BY Order_ID) AS cumulative_revenue
FROM sales_ecom;

-- Which category had the highest revenue?

select
   Category,
   sum(Revenue) as total_revenue
from sales_ecom
group by Category
order by total_revenue desc
limit 1;

-- Which city had the highest number of orders?
select
   Customer_City,
   count(Order_ID) as cnt
from sales_ecom
group by Customer_City
order by cnt desc
limit 1;

-- What is the total revenue generated from male customers?
select
    Customer_Gender,
    sum(Revenue) as total_revenue
from sales_ecom
where Customer_Gender='Male'
group by Customer_Gender;

-- How many orders were placed by male customers in a specific city?
select
    Customer_Gender,
    Customer_City,
    count(order_id) as total_order_count
from sales_ecom
where Customer_Gender='Male'
group by Customer_Gender,Customer_City;

-- What is the average revenue generated per customer age range?

select
   Customer_Age_Range,
   avg(Revenue) over(partition by Customer_Age_Range) as avg_revenue
from sales_ecom;


-- What is the rank of each product's revenue within its category?
SELECT Product, Category, Revenue,
       RANK() OVER (PARTITION BY Category ORDER BY Revenue DESC) AS revenue_rank
FROM sales_ecom;


-- What is the lead Customer_Gender for each order within its City_Store?
SELECT Order_ID, City_Store, Customer_Gender,
       ROW_NUMBER() OVER (PARTITION BY Order_ID, City_Store ORDER BY COUNT(*) DESC) AS gender_rank
FROM sales_ecom
GROUP BY Order_ID, City_Store, Customer_Gender;

SET SQL_SAFE_UPDATES=0;

UPDATE sales_ecom
SET Date = STR_TO_DATE(Date, '%m/%d/%Y');

-- Month_Name,Year,Quarter Vs Revenue
select
   year(Date) as Year,
   monthname(Date) as Month_name,
   quarter(Date) as Quarter,
   sum(Revenue) as total_revenue
from sales_ecom
group by Month_name,Year,Quarter;


SELECT
   MONTHNAME(Date) AS Month_name,
   SUM(Revenue) AS Total_Revenue,
   LAG(SUM(Revenue)) OVER (ORDER BY MONTH(Date)) AS Previous_Month_Revenue,
   (SUM(Revenue)/LAG(SUM(Revenue)) OVER (ORDER BY MONTH(Date)))*100 as MOM
FROM sales_ecom
GROUP BY Month_name, MONTH(Date);


select
    Category,
    Product,
    sum(Revenue) as total_revenue,
    dense_rank() over(partition by Product order by Category)
from sales_ecom
group by Category, Product;






