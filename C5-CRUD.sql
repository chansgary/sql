-- CRUD stands for
-- CREATE READ UPDATE DELETE

-- CREATE Series:
-- create database <datbasename>;
-- create table <table_name> (column_name, column_name);
-- insert into <table_name> (column_name, column_name)
-- values(value, value);

# show databases;
use cats_app;
show tables;

# CREATE TABLE cats
# (
#     cat_id int not null auto_increment primary key,
#     name   varchar(100),
#     breed  varchar(100),
#     age    int
# );
# desc cats;

# 插入数据
# insert into cats(name,breed,age)
# values ("Ringo", "Tabby",4),
#        ("Cindy", "Maine Coon",10),
#        ("Dumbledore","Maine Coon",11),
#        ("Egg","Persian",4),
#        ("Misty","Tabby",13),
#        ("George Michael", "Ragdoll",9),
#        ("Jackson","Sphynx",7);


-- Reading the data out
-- * mean give me all columns
select * from cats;

-- select expression: what columns do you want?
# select single column
select name from cats;
select age from cats;
select cat_id from cats;

-- select two columns at the same time
select name,age from cats;
select age,name from cats;
-- first column: age, second column: name

# The WHERE clause

select * from cats where age = 4;
select * from cats where breed = "Maine Coon";
select * from cats where name = "EGG";

# By default, this is case insensitive
# Exercises:
select cat_id from cats;

select name,breed from cats;

select name,age from cats where breed="Tabby";

select cat_id,age from cats where cat_id = age;
# we can also compare columns

select cat_id,name from cats;

select cat_id as id,name from cats;
select cat_id,name as cat_name from cats;
# this is pretty useful when we are going to combine two tables
# while not truly changing the data sources


##############################################################
# UPDATE: How do we alter existing data?
# set password forget the pastword reset the password

select * from cats;

update cats set breed = "Shorthair"
where breed = "tabby";

select * from cats;

# change Misty's age to 14 (from 13)
select name, age from cats;

update cats set age = 14
where name = "Misty";

select name, age from cats;
# first read then update to update the data you want to make modifications
# You wanna make sure that before updating

# change Jackson's name to "Jack"
select name from cats;

# first read
select * from cats where name = "Jackson";
# then update
update cats set name = "Jack"
where name =  "Jackson";

select name from cats;

# change Ringo's breed to "British Shorthair"
select * from cats where name = "Ringo";
update cats set name = "British Shorhair"
where name = "RINGO";
select * from cats where name = "Ringo"; # should be empty now
select * from cats where name = "British Shorhair" # similar to first read igonring name

# udpate both Main Coons' ages to be 12
select * from cats;
select * from cats
where breed = "Maine Coon";

update cats set age = 12
where breed = "Maine Coon";
select * from cats;

# The rule of thumb: select statement before update statement

##############################################################
select * from cats where name = "egg";
select * from cats;

delete from cats where name = "egg";

select * from cats;
# the id won't change

# delete from cats;
# this command deletes all entries in the table.

# challenge:
# delete all 4 year old
select * from cats;
select * from cats where age = 4;
delete from cats where age = 4;
select * from cats where age = 4;
select * from cats;

# delete cats whose age = cat_id
select * from cats where age = cat_id;
delete from cats where age = cat_id;
select * from cats;

# delete all cats
delete from cats;
# it is a delete statment without where cluase meaning no condition at all.
select * from cats; # should be empty now(but we still have header)











