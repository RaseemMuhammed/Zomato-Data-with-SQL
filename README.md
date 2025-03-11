# Zomato-Data-with-SQL
This project involves analyzing a small dataset of Zomato using SQL queries.
Objectives:
Data Cleaning and Preparation:

Import raw data into an SQL database.
Remove duplicates, handle missing values, and format the data for analysis.
Normalize and transform data as needed.
Exploratory Data Analysis:

Analyze the basic structure of the data using SQL queries to examine key tables (restaurants, reviews, ratings, etc.).
Identify trends in restaurant ratings, types of cuisines, most popular locations, and other characteristics.
Below is the SQL Quary to create tables:-
drop table if exists goldusers_signup;
CREATE TABLE goldusers_signup(userid integer,gold_signup_date date); 

INSERT INTO goldusers_signup(userid,gold_signup_date) 
 VALUES (1,'09-22-2017'),
(3,'04-21-2017');

drop table if exists users;
CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
 VALUES (1,'09-02-2014'),
(2,'01-15-2015'),
(3,'04-11-2014');

drop table if exists sales;
CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
 VALUES (1,'04-19-2017',2),
(3,'12-18-2019',1),
(2,'07-20-2020',3),
(1,'10-23-2019',2),
(1,'03-19-2018',3),
(3,'12-20-2016',2),
(1,'11-09-2016',1),
(1,'05-20-2016',3),
(2,'09-24-2017',1),
(1,'03-11-2017',2),
(1,'03-11-2016',1),
(3,'11-10-2016',1),
(3,'12-07-2017',2),
(3,'12-15-2016',2),
(2,'11-08-2017',2),
(2,'09-10-2018',3);


drop table if exists product;
CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);


select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;
------------------------------------------------------------------------------------------

Problems:
--Total spend by each customer
--spend by each customer each product
--total number of days visited by customers
--what was the first product purchased by each customer
-- what is the most purchased product and howmany times purchased by all customers
-- which item is most popular for each customer
--which item was customer bought first after becoming a member
--which item was customer bought just before becoming a member
--what is the total spend of members before they becoming member
--if buying each product generate zomato points, eg p1 5rs=1 point, p2 10rs = 5points, and for p3 5rs=1 point,calculate the total point for the customers
