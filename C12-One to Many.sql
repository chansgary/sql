# C12 - One to Many
# Almost all data in the reality are related
# Work wit multiple tables, joins, primary key...
# We are done with the book table, we will play with the Instagram database later

################################################################################
# RELATIONSHIP and JOINS

# So far we've been working with very simple data
# real world data is messy and interrelated

# Authors, Versions, Customers, Orders, Reviews
# Relationship Basics

################################################################################
# 1. One to One Relationship
# Customers and Orders

# customer_firstname,
# customer_lastname,
# email,
# the date of the purchase,
# the price of the order

# we might have too many duplications
# especially for people who shopped a lot
# could be a waste, they just signed up for the site but not ordering

# keep your data separate is always the better way`

#************* Primary Key ************* #
# Unique(be treated as the reference)
# primary key is the only to reference specific row in the table
# Say one customer ordered same thing in one day twice,
# --> order_date, amount, customer_id all same, but the order_id should be different
# maybe the customer here purposely ordered something twice, we should treat them separately

#************* Foreign Key ************* #
# referring to external table
# enforcing the the id we input has already existed
#  customer exists first then the order
# it's not going to happen that we don't have a order without the corresponding customer

show databases;
create database C11;
use c11;
create table customers(
    id int auto_increment primary key,
    first_name varchar(100),
    last_name varchar(100),
    email varchar(100)
);

create table orders(
    id int auto_increment primary key,
    order_date date,
    amount decimal(8,2),
    customer_id int,
    # convention: to name foreign key as ref_tablename_ref_colname
    foreign key(customer_id)
        references customers(id)
        ON DELETE CASCADE
    # like a pointer pointer to the reference table
    # syntax foreign key()
);

insert into customers (first_name, last_name, email)
values ('Boy', 'George', 'george@gmail.com') ,
       ('George', 'Michael', 'gm@gmail.com'),
       ('David', 'Bowie', 'david@gmail.com'),
       ('Blue', 'Steele', 'blue@gmail.com'),
       ('Bette', 'Davis', 'bette@aol.com');


insert into orders(order_date, amount, customer_id)
values ('2016/02/19',99.99,1),
       ('2017/11/11',35.50,1),
       ('2014/12/12', 800.67, 2),
       ('2015/01/03', 12.50, 2),
       ('1999/04/11',450.25, 5);

select * from customers;
select * from orders;

desc orders;

# let's try if we can insert values into order from a non-existing customer
insert into orders(order_date, amount, customer_id)
values ('2021/02/02', 100,99);
# Wrong!!!Wrong!!!Wrong!!!
# foreign key prevents doing such hazardous thing

select * from orders
where customer_id = 1;

select * from orders
where customer_id = 1;

select * from orders limit 5;
select * from customers limit 5;

select * from customers where last_name = 'george'; # find the id of george is 1
select * from orders where customer_id = 1; # find order information for id = 1

# sub query
select * from orders
where customer_id = (
    select id from customers
    where last_name = 'george'
         );

# this only works for one user, what if we have more users??
# use JOIN

# Cross Join - never gonna use
select * from customers,orders;
# it takes every customer and
# join them with every order - meaningless`


# 2. One to Many Relationship - Really Common
# 3. Many to Many Relationship


################################################################################

select * from customers,orders
where orders.customer_id = customers.id;
# '.' means that in the table, to be explicit

select orders.customer_id as ID,
       first_name,
       last_name,
       email,
       order_date,
       amount
from customers,orders
where orders.customer_id = customers.id;

################################################################################
# EXPLICIT INNER JOIN
select orders.customer_id as ID,
       first_name,
       last_name,
       email,
       order_date,
       amount
from customers
join orders
    on customers.id = orders.customer_id;

# switching the order does not really impact

# syntax:
# select * from tableA
# join tableB on tableA.samecoloumn = tableB.samecolumn;

################################################################################
# LEFT JOIN

# Getting fancier
select orders.customer_id as ID,
       first_name,
       last_name,
       email,
       order_date,
       amount
from customers
join orders
    on customers.id = orders.customer_id
order by order_date;

# find the biggest spenders
# George,Michael
select
       first_name,
       last_name,
       sum(amount) as total_spent
from customers
join orders
    on customers.id = orders.customer_id
group by last_name, first_name
order by sum(amount) desc;

################################################################################
# LEFT JOIN: select everything from A, along with any matching records in B

select * from customers limit 0;
# id, first_name, last_name, email
select * from orders limit 0;
# id, order_date, amount, customer_id

# Note: orders.customer_id comes from customers, id column is order_id
# INNER JOIN is by default

# For instance, to see hwo much each user spends (including the non-spending user)
# send emails to people who spend a lot about thank you letters
# send emails to people who spend little about coupons 10% off
select first_name, last_name, order_date,amount from customers
left join orders
    on customers.id = orders.customer_id;

# again, we want to see the highest spender:

select first_name,
       last_name,
       ifnull(sum(amount),0) as total_spent
from customers
left join orders
    on customers.id = orders.customer_id
group by customer_id
ORDER BY total_spent desc;

# How do we change the null value? can we replace null with 0?
#ifnull(expression to teston, changeto)


################################################################################
# RIGHT JOIN: selecting everything from B, along with any matching records in A

select * from customers
right join orders
    on customers.id = orders.customer_id;
# since we have set the each order row has corresponding id in customers, so no null value this time
# each order should come from a customer
# but for each customer, might not have any orders, or many

# Can we bundle each orders and customers together? Say if we wanna delete one of them, the corresponding orders also gone
# ON DELETE CASCADE

################################################################################
# LEFT JOIN V.S. RIGHT JOIN
# Left join is pretty much the right join only with the order changed


################################################################################
# Our first Joins exercise
# schema
# students: id, first_name
# papers: title, grade, student_id
# each paper belongs to one student
# each student might have more than one paper

create database C12;
use c12;
create table students(
    id int auto_increment primary key,
    first_name varchar(100)
);

create table papers(
    title varchar(100),
    grade int,
    student_id int,
    foreign key(student_id)
        references students(id)
        on delete cascade
);

INSERT INTO students (first_name) VALUES
('Caleb'), ('Samantha'), ('Raj'), ('Carlos'), ('Lisa');

INSERT INTO papers (student_id, title, grade ) VALUES
(1, 'My First Book Report', 60),
(1, 'My Second Book Report', 75),
(2, 'Russian Lit Through The Ages', 94),
(2, 'De Montaigne and The Art of The Essay', 98),
(4, 'Borges and Magical Realism', 89);

# Q1
# students: id, first_name
# papers: title, grade, student_id

select first_name,title,grade
from students
    inner join papers
        on students.id = papers.student_id
order by grade desc;

# Q2:
select first_name,
       ifnull(title,'MISSING') as title,
       ifnull(grade,0) as grade
from students
left join papers
    on papers.student_id = students.id;

# Q3: average grade for every students
select first_name,
       ifnull(avg(grade),0) as average
from students
    left join papers
        on students.id = papers.student_id
group by first_name
order by average desc;


# Q4: fancier
select first_name,
       ifnull(avg(grade),0) as average,
       if(avg(grade)>=75,'PASSING','FAILING') as passing_status
from students
left join papers p on students.id = p.student_id
group by first_name
order by average desc;

select first_name,
       ifnull(avg(grade),0) as average,
       case
           when avg(grade) is null then 'FAILING' # make sure no bizarre thing compares with null
           when avg(grade)>=75 then 'PASSING'
           else 'FAILING'
       end as passing_status
from students
left join papers p on students.id = p.student_id
group by first_name
order by average desc;
















