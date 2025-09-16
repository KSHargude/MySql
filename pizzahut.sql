create database pizzahut;

-- import pizzas file

use pizzahut;

/*
select * from pizzas;
create table orders1(
oid int not null,
odate date not null,
otime time not null,
primary key(oid));

select * from orders1;

create table o_details(
odetails_id int not null,
oid int not null,
pizza_id text not null,
quantity int not null,
primary key(odetails_id));

select * from o_details;

*/

-- Basic:

-- 1.Retrieve the total number of orders placed.

select * from orders1;

select count(oid) as total_orders from orders1;

-- 5297

-- 2.Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(o_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    o_details
        JOIN
    pizzas ON pizzas.pizza_id = o_details.pizza_id;

-- 75344.6

-- 3.Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price AS highest_priced_pizza
FROM
    pizzas
        JOIN
    pizza_types ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
    
-- The Greek Pizza	35.95

-- 4.Identify the most common pizza size ordered.

select quantity, count(odetails_id)
from o_details group by quantity;

/*
1	6105
2	113
3	1
*/

SELECT 
    pizzas.size, COUNT(o_details.odetails_id) AS order_count
FROM
    pizzas
        JOIN
    o_details ON pizzas.pizza_id = o_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
limit 1;

-- L	1751

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pt.name, SUM(od.quantity) AS quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    o_details od ON od.pizza_id = p.pizza_id
GROUP BY pt.name
ORDER BY quantity DESC
LIMIT 5; 

/*
The Classic Deluxe Pizza	247
The Thai Chicken Pizza	228
The California Chicken Pizza	222
The Pepperoni Pizza	208
The Barbecue Chicken Pizza	207
*/


-- Intermediate:

-- 1.Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    SUM(od.quantity) AS total_quantity, pt.category
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    o_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category;

/*
1099	Veggie
1371	Classic
1004	Chicken
1082	Supreme
*/

-- 2.Determine the distribution of orders by hour of the day.

select hour(otime) as hour, count(oid) as order_count
from orders1
group by hour(otime);

/*
11	292
12	642
13	598
14	376
15	352
16	498
17	620
18	562
19	494
20	413
22	149
21	295
23	4
10	2
*/

-- Join relevant tables to find the category-wise distribution of pizzas.

select count(name), category
from pizza_types
group by category;

/*
6	Chicken
8	Classic
9	Supreme
9	Veggie
*/

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select avg(quantity) from (select sum(od.quantity) as quantity, o.odate
from o_details od join orders1 o
on od.oid = o.oid
group by o.odate ) as order_quantity;

/*
outer query
33.6410
*/

/*
-- inner query
33	2015-01-01
50	2015-01-02
47	2015-01-03
26	2015-01-04
33	2015-01-05
59	2015-01-06
38	2015-01-07
48	2015-01-08
22	2015-01-09
30	2015-01-10
30	2015-01-11
27	2015-01-12
22	2015-01-13
36	2015-01-14
24	2015-01-15
33	2015-01-16
25	2015-01-17
27	2015-01-18
20	2015-01-19
24	2015-01-20
22	2015-01-21
43	2015-01-22
44	2015-01-23
41	2015-01-24
28	2015-01-25
32	2015-01-26
53	2015-01-27
28	2015-01-28
46	2015-01-29
35	2015-01-30
19	2015-01-31
41	2015-02-01
23	2015-02-02
41	2015-02-03
36	2015-02-04
30	2015-02-05
48	2015-02-06
36	2015-02-07
12	2015-02-08
*/

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pt.name, SUM(p.price * od.quantity) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    o_details od ON p.pizza_id = od.pizza_id
GROUP BY p.pizza_id
ORDER BY revenue DESC
LIMIT 3;

/*
The Thai Chicken Pizza	2739
The Four Cheese Pizza	2495.0499999999993
The Five Cheese Pizza	2405
*/

-- Advanced:

-- Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pt.category,
    (SUM(od.quantity * p.price) / (SELECT 
            ROUND(SUM(o_details.quantity * pizzas.price),
                        2) AS total_sales
        FROM
            o_details
                JOIN
            pizzas ON pizzas.pizza_id = o_details.pizza_id) * 100) AS revenue
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    o_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category
ORDER BY revenue DESC;

/*
Classic	27.061859774954012
Supreme	24.85632679714274
Veggie	24.41853828940633
Chicken	23.663275138496985
*/


-- Analyze the cumulative revenue generated over time.

select odate, sum(revenue) over (order by odate) as cum_revenue
from(
select o.odate, sum(od.quantity * p.price) as revenue
from o_details od join pizzas p on  od.pizza_id = p.pizza_id
join orders1 o
on o.oid = od.oid
group by o.odate) as sales;

/*
2015-01-01	366.75
2015-01-02	967.25
2015-01-03	1573.75
2015-01-04	1889.5
2015-01-05	2327.7
2015-01-06	2967.95
2015-01-07	3374.8999999999996
2015-01-08	3914.3499999999995
2015-01-09	4121.249999999999
2015-01-10	4441.749999999999
2015-01-11	4809.649999999999
2015-01-12	5188.049999999998
2015-01-13	5427.249999999998
2015-01-14	5888.199999999998
2015-01-15	6111.949999999998
2015-01-16	6460.949999999998
2015-01-17	6733.699999999998
2015-01-18	6968.349999999998
2015-01-19	7192.299999999997
2015-01-20	7401.499999999997
2015-01-21	7654.949999999997
2015-01-22	8200.149999999998
2015-01-23	8735.849999999999
2015-01-24	9296.249999999998
2015-01-25	9730.099999999999
2015-01-26	10104.149999999998
2015-01-27	10921.849999999999
2015-01-28	11309.849999999999
2015-01-29	11844.849999999999
2015-01-30	12204.599999999999
2015-01-31	12413.249999999998
2015-02-01	12761.849999999999
2015-02-02	13102.999999999998
2015-02-03	13625.599999999999
2015-02-04	14060.349999999999
2015-02-05	14414.249999999998
2015-02-06	14825.149999999998
2015-02-07	15315.249999999998
2015-02-08	15421.249999999998

*/

/*
2015-01-01	366.75
2015-01-02	967.25
2015-01-03	1573.75
2015-01-04	1889.5
2015-01-05	2327.7
2015-01-06	2967.95
2015-01-07	3374.8999999999996
2015-01-08	3914.3499999999995
2015-01-09	4121.249999999999
2015-01-10	4441.749999999999
2015-01-11	4809.649999999999
2015-01-12	5188.049999999998
2015-01-13	5427.249999999998
2015-01-14	5888.199999999998
2015-01-15	6111.949999999998
2015-01-16	6460.949999999998
2015-01-17	6733.699999999998
2015-01-18	6968.349999999998
2015-01-19	7192.299999999997
2015-01-20	7401.499999999997
2015-01-21	7654.949999999997
2015-01-22	8200.149999999998
2015-01-23	8735.849999999999
2015-01-24	9296.249999999998
2015-01-25	9730.099999999999
2015-01-26	10104.149999999998
2015-01-27	10921.849999999999
2015-01-28	11309.849999999999
2015-01-29	11844.849999999999
2015-01-30	12204.599999999999
2015-01-31	12413.249999999998
2015-02-01	12761.849999999999
2015-02-02	13102.999999999998
2015-02-03	13625.599999999999
2015-02-04	14060.349999999999
2015-02-05	14414.249999999998
2015-02-06	14825.149999999998
2015-02-07	15315.249999999998
2015-02-08	15421.249999999998
*/

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select name, revenue from
(select category, name, revenue, rank() over (partition by category order by revenue desc) as rn
from
(SELECT 
    pt.name, SUM(p.price * od.quantity) AS revenue, pt.category
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    o_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.category, pt.name) as a) as b
where rn <= 3;


