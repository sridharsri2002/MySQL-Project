select* from aisles;
select* from departments;
select* from order_products_train;
select* from orders;
select* from products;

-- What are the top 10 aisles with the highest number of products?

select a.aisle, count(p.aisle_id) as product_count
from aisles a
join products p on a.aisle_id = p.aisle_id
group by a.aisle
order by product_count desc
limit 10;

-- How many unique departments are there in the dataset?

select distinct count(department) from departments;

-- What is the distribution of products across departments?

select* from departments;
select* from products;

select count(p.product_name) as product, d.department
from products p
join departments d
on p.department_id =d.department_id
group by d.department
order by product;

-- What are the top 10 products with the highest reorder rates?

select* from products;
select* from order_products_train;

select p.product_name, count(o.reordered)
from products p
join order_products_train o on p.product_id = o.product_id
where o.reordered = 1
group by p.product_name
order by count(o.reordered) desc
limit 10;

-- How many unique users have placed orders in the dataset?

select* from orders;
select distinct(user_id) as user,count(order_id) from orders group by user;

-- What is the average number of days between orders for each user?

SELECT 
    user_id,
    ROUND(AVG(days_since_prior_order), 2) AS avg_days_between_orders
FROM 
    orders
WHERE 
    days_since_prior_order IS NOT NULL
GROUP BY 
    user_id;
    
-- What are the peak hours of order placement during the day?

select * from products;
select * from order_products_train;
select* from orders;

select
    order_hour_of_day,
    count(order_hour_of_day) as total_orders
from
    orders
group by
    order_hour_of_day
order by
    total_orders DESC;
    
-- How does order volume vary by day of the week?
    
select* from products;
select* from orders;
select* from order_products_train;    
    
select order_dow,count(order_id) as total_orders
from orders
group by order_dow
order by total_orders;

-- What are the top 10 most ordered products?
select* from orders;
select* from order_products_train;
select* from products;


select count(o.order_id) as top_orders, op.product_name
from order_products_train o
join products op on o.product_id = op.product_id
group by op.product_name
order by top_orders desc
limit 10;


-- How many users have placed orders in each department

select* from departments;
select* from order_products_train;
select* from orders;
select* from products;

select count(o.user_id)as users, d.department
from orders o
join order_products_train op on o.order_id  = op.order_id
join products p on op.product_id = p.product_id
join departments d on p.department_id = d.department_id
group by d.department
order by users desc;

-- What is the average number of products per order?

select* from order_products_train;
select* from orders;
select* from products;

SELECT 
    ROUND(COUNT(*) / COUNT(DISTINCT order_id), 2) AS avg_products_per_order
FROM 
 order_products_train;
 
 -- 12 What are the most reordered products in each department?
 
select* from aisles;
select* from departments;
select* from order_products_train;
select* from orders;
select* from products;

select p.product_name, count(op.reordered),d.department
from products p
join departments d on p.department_id=d.department_id
join order_products_train op on op.product_id = p.product_id
group by d.department,p.product_name
having count(op.reordered)=1
limit 10;

-- How many products have been reordered more than once?
select p.product_name, count(op.reordered)
from products p
join order_products_train op on p.product_id = op.product_id
group by p.product_name
having count(op.reordered)> 1
order by count(op.reordered) desc;










