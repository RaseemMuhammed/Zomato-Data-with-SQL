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

-- Total spend by each customer

select s.userid,
	sum(p.price)Total_Spend 
from 
sales s join product p
on s.product_id = p.product_id
group by s.userid
order by sum(p.price) desc

--spend by each customer each product

select s.userid,
	p.product_id,
	sum(p.price)Total_Spend 
from 
sales s join product p
on s.product_id = p.product_id
group by s.userid,p.product_id

--total number of days visited by customers
select userid,
	count(created_date)Days_count
from sales
group by userid
order by count(created_date) desc;

--what was the first product purchased by each customer

with cte as 
(select *,
	ROW_NUMBER() over(partition by userid order by created_date)rnk
from sales)
select * from cte
where rnk = 1;

-- what is the most purchased product and howmany times purchased by all customers

select product_id,
	count(product_id)count_P
from sales
group by product_id
order by count(product_id) desc;

-- which item is most popular for each customer

with cte as
(select *,
	rank()over (partition by userid order by cnt desc)rnk
from
(select userid,
	product_id,
	count(product_id)cnt
from sales
group by userid,product_id)a)
select userid,
	product_id
from cte 
where rnk = 1;

--which item was customer bought first after becoming a member

select userid,product_id from
(select *,
	rank() over (partition by userid order by created_date) rnk
from
(select s.userid,s.created_date, s.product_id 
from sales s join goldusers_signup g
on s.userid = g.userid
where created_date >= gold_signup_date)a)b
where rnk = 1;

--which item was customer bought just before becoming a member
select userid,product_id from
(select *,
	rank() over (partition by userid order by created_date desc) rnk
from
(select s.userid,s.created_date, s.product_id 
from sales s join goldusers_signup g
on s.userid = g.userid
where created_date < gold_signup_date )a)b
where rnk = 1;

--what is the total spend of members before they becoming member
with cte as
(select s.userid,s.created_date, s.product_id 
from sales s join goldusers_signup g
on s.userid = g.userid
where created_date < gold_signup_date)
select c.userid, count(c.created_date)T_Oredrs,
	sum(p.price)T_spend
from 
cte c join product p
on c.product_id = p.product_id
group by c.userid
order by sum(p.price) desc;

--if buying each product generate zomato points, eg p1 5rs=1 point, p2 10rs = 5points, and for p3 5rs=1 point
-- calculate the total point for the customers

select * from sales;
select * from product;

select userid, sum(T_score)Total_Points
from
(select *,
	case when product_id = 1 then (T_spend /5) * 1
	when product_id = 2 then (T_spend /10) * 5
	else (T_spend /5) * 1 end as T_score
from
(select userid,product_id,sum(price)T_spend
from
(select s.*,p.price from 
sales s join product p
on s.product_id = p.product_id)a
group by userid,product_id)b)c
group by userid;

--rank all transactions of customers

select * from sales;
select *,
	rank() over (partition by userid order by created_date)rnk
from sales;


