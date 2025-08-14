create table retail_sales(

transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender	VARCHAR(40),
age	INT,
category VARCHAR(50),
quantity INT,
price_per_unit FLOAT,	
cogs FLOAT,
total_sale FLOAT
)
--DATA CLEANING--

SELECT * FROM retail_sales
LIMIT 10
SELECT * FROM retail_sales
where transactions_id is null
     or sale_date is null
	 or sale_time is null
	 or customer_id is null
	 or category is null
	 or cogs is null

delete from retail_sales
where transactions_id is null
     or sale_date is null
	 or sale_time is null
	 or customer_id is null
	 or category is null
	 or cogs is null

--DATA EXPLORATION--
How many sales we have?
select count(*) as total_sale from retail_sales

How many unique customers we have?
select count(distinct customer_id) as total_customers from retail_sales

--categories--
select distinct category from retail_sales

--Business problems and key values--

-- 1  Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- 2  Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- 3  Write a SQL query to calculate the total sales (total_sale) for each category.
-- 4  Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- 5  Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- 6  Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- 7  Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- 8  Write a SQL query to find the top 5 customers based on the highest total sales 
-- 9  Write a SQL query to find the number of unique customers who purchased items from each category.
--10  Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--MY ANALYSIS AND FINDINGS--
1)
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05'

2) 
SELECT * from retail_sales
WHERE category = 'Clothing' 
AND quantity >=4
AND to_char(sale_date,'YYYY-MM')='2022-11'

3)
SELECT SUM(total_sale) as total_category_sales,category from  retail_sales
group by category

4)
SELECT AVG(age) as avg_age from retail_sales
where category='Beauty'

5)
SELECT * from retail_sales
WHERE total_sale > 1000

6)
SELECT 
    gender,
    category,
    COUNT(transactions_id) AS total_transactions
FROM retail_sales
GROUP BY gender, category
ORDER BY gender, category;

7)
SELECT AVG(total_sale) as total_sales,
extract(year from sale_date) as year,
extract(month from sale_date) as month
from retail_sales
group by 2,3
order by total_sales desc

8)
select customer_id, sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc
limit 5

9)
select count(distinct customer_id) , category
from retail_sales
group by category

10)
WITH hourly_sale
AS
(
SELECT * ,
CASE 
WHEN EXTRACT(HOUR FROM sale_time)<12 then 'Morning'
WHEN EXTRACT(HOUR FROM sale_time) between 12 and 17 then 'Afternoon'
else 'Evening'
end as shift
from retail_sales
)
select shift, count(*) as total_orders
from hourly_sale
group by shift

--END OF PROJECT--




	 


	 