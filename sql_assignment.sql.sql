use countrys;
-- Part A – Basic Queries
-- 1.	Display all customers.
select * from customers;

-- 2.	Display customers from Kerala.
select * from customers 
where State="Kerala";

-- 3.	Display all products from the Electronics category.
select *
From products
where Category="Electronics";

-- 4.	Display products with price greater than 1000
select *
From products
where Price>1000;

-- 5.	Display all completed orders.
select * 
from ordernew
where Order_Status="Completed";

-- 6.	Sort products by price in ascending order.
select * From products
order by Price;

-- 7.	Display the 5 most expensive products.
select * From products
order by Price desc
limit 5;



-- Part B – Aggregate Functions
-- 8.	Find the total number of customers.
SELECT count(*) from customers;

-- 9.	Find the total number of orders.
SELECT count(*) from ordernew;

-- 10.	Find the average product price.
select avg(Price) as avgprice
from products;

-- 11.	Find the highest product price.
select max(Price) as maxprice
from products;

-- 12.	Find the lowest product price.
select min(Price) as minprice
from products;

-- 13.	Find the total quantity sold for each product.
SELECT Product_ID, SUM(Quantity) AS Total_Quantity
FROM order_details
GROUP BY Product_ID;

-- Part C – GROUP BY
-- 14.	Find the number of customers in each state.
select count(*),State from customers 
group by State;

-- 15.	Find the number of products in each category.
select count(*),category from products
group by Category;

-- 16.	Find the number of orders for each payment mode.
select count(*),payment_mode from ordernew
group by payment_mode;

-- 17.	Display categories having more than 3 products.
SELECT Category,count(*)
FROM products
GROUP BY Category
HAVING COUNT(*) > 3;


-- Part D – JOIN
-- 18.	Display customer name and order date.
select Customer_Name,order_date
from customers
join ordernew
on customers.customer_ID=ordernew.customer_id;

-- 19.	Display product name and quantity.
select Product_Name,Quantity
from products
join order_details
on products.Product_ID=order_details.Product_ID;

-- 20.	Display customer name, product name and quantity.
SELECT Customer_Name, Product_Name, Quantity
FROM customers
JOIN ordernew
ON customers.Customer_ID = ordernew.Customer_ID
JOIN order_details
ON ordernew.Order_ID = order_details.Order_ID
JOIN products
ON order_details.Product_ID = products.Product_ID;


-- 21.	Display Order ID, Customer Name and Order Status.
select order_details.Order_ID,Customer_Name,order_status
from order_details
join ordernew
on  order_details.Order_ID=ordernew.order_id
join customers
on ordernew.customer_id=customers.Customer_ID;


-- Part E – CASE 
-- CASE in SQL is used to return different values based on conditions. It works like IF–ELSE in programming.
-- 22.	Display product name, price and price category: High, Medium or Low.
SELECT Product_Name, Price,Category,
CASE
    WHEN Price > 1000 THEN 'High'
    WHEN Price > 500 THEN 'Medium'
    ELSE 'Low'
END 
FROM products;


-- 23.	Display customer name, age and age category: Young, Adult or Senior
select Customer_Name,Age,
CASE
  when Age<25 THEN "YOUNG"
  when Age<50 THEN "adult"
  else "senior"
END
from customers;

-- Part F – Simple Subqueries
-- 24.	Display products whose price is greater than the average product price.
select * from products
where Price>(select avg(Price) from products);

-- 25.	Display the product with the highest price.
select * from products where Price=(select MAX(Price) from products);

-- SET SQL_SAFE_UPDATES = 0;

-- Part G – UPDATE / ALTER / DELETE
-- 26.	Increase the price of Electronics products by 10%.
update products
SET Price=Price*1.10
where Category="Electronics";
select *from products;

-- 27.	Change the status of Order ID 5 to Completed.
update ordernew
SET order_status="Completed"
where order_id=5;

select * from ordernew;

-- 28.	Add an Email column to the Customers table.
alter table customers
add email varchar(50);

select * from customers;

-- 29.	Modify the Customer_Name column.
ALTER TABLE customers
MODIFY Customer_Name VARCHAR(100);

-- 30.	Delete cancelled orders.
delete from ordernew
where order_status="Cancelled";

-- Part H – Simple Data Analyst Questions
-- 31.	Which product has the highest quantity sold?
select Product_Name,sum(Quantity)
from products
join order_details
on products.Product_ID=order_details.Product_ID
group by Product_Name
order by sum(Quantity) desc
limit 1;


-- 32.	Which category has the most products?
select Category,count(*)
from products
group by Category
order by count(*) desc
limit 1;


-- 33.	Which payment mode is used most frequently?
select payment_mode,count(*)
from ordernew
group by payment_mode
order by count(*) desc
limit 1;


-- 34.	Which state has the highest number of customers?
select State,count(*)
from customers
group by State
order by count(*) desc
limit 1;


-- 35.	Display products whose total quantity sold is less than 10.
select Product_Name,sum(Quantity)
from products
join order_details
on products.Product_ID=order_details.Product_ID
group by Product_Name
having sum(Quantity)<10;

