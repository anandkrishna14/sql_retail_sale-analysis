select *
 from retail_sales
limit 10

select count(*) from  retail_sales

 select * from  retail_sales
  where transactions_id IS NULL

  select * from  retail_sales
  where sale_date IS NULL

   select * from  retail_sales
  where sale_time IS NULL

  select * from retail_sales 
  where transactions_id IS NULL
  OR
  sale_date IS NULL
  OR 
  sale_time IS NULL
  OR 
  customer_id IS  NULL 
  OR 
  age IS NULL
  OR 
  category IS NULL
  OR 
  quantity IS NULL
  OR 
  price_per_unit IS NULL
  OR 
 cogs IS NULL
  OR 
  total_sale IS NULL

  DELETE FROM  retail_sales 
  where transactions_id IS NULL
  OR
  sale_date IS NULL
  OR 
  sale_time IS NULL
  OR 
  customer_id IS  NULL 
  OR 
  age IS NULL
  OR 
  category IS NULL
  OR 
  quantity IS NULL
  OR 
  price_per_unit IS NULL
  OR 
  cogs IS NULL
  OR 
  total_sale is  NULL

  -- DATA EXPORATION 
  -- how many sake s we have  
  SELECT COUNT(*) AS total_sale FROM retail_sales
-- how many unique  costomer we have 
SELECT COUNT(DISTINCT customer_id ) AS total_customer FROM retail_sales

-- how many of distinct categpory
SELECT COUNT(DISTINCT category ) AS total_customer FROM retail_sales

SELECT DISTINCT (category )  FROM retail_sales

-- data analysis for the business 
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from retail_sales
where sale_date = '2022-11-05'


--
select DISTINCT(transactions_id) from retail_sales
where sale_date = '2022-11-05'

 -- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
 SELECT * from retail_sales
 where category = 'Clothing'
        AND 
		quantity ='4'
		AND 
		to_char(sale_date, 'YYYY-MM')='2022-11'

 -- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category
 SELECT category, SUM(total_sale) AS total,count(*) as sales
 from retail_sales
 group by category


 -- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
 SELECT 
  AVG(age)
 from retail_sales
 where category = 'Beauty'

Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select * from retail_sales
where total_sale >1000


.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

select category,gender ,count(*) as total_transa from retail_sales
group by category, gender
order by total_transa desc


-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select year, month ,total
from
(
select 
    extract(year from sale_date) as year,
	extract(month from sale_date) as month,
   avg(total_sale) AS total,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
from retail_sales
group by 1,2) as t1
where rank=1

-- .8 Write a SQL query to find thetotal top 5 customers based on the highest total sales 
select customer_id,sum(total_sale) as total
from retail_sales
group by customer_id
order by total desc
limit 5

Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select category,count(DISTINCT customer_id) as unique_customer
from retail_sales

group by category 

 Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

 WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift


  

  