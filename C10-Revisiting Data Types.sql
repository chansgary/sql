-- basic: data types, varchar, int
-- what about decimals, dates, time, timestamp?
-- a lot of information we need

-- ################################################################################
-- Char and varchar
-- data takes different forms

-- Storing texts

-- Char has a fixed length, while the length of varchar can be changed!!!
-- Char(3) -- only three characters are allowed, fixed size, longest one is 255

-- char is faster for fixed length text!!!
-- states abbreviations: CA,NY
-- yes/no flags: Y/N
-- Sex: M/F

-- Otherwise use varchar
show databases;
create database dogs_app;

CREATE TABLE dogs (name CHAR(5), breed VARCHAR(10));

INSERT INTO dogs (name, breed) VALUES ('bob', 'beagle');

INSERT INTO dogs (name, breed) VALUES ('robby', 'corgi');

INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'Retriever');

SELECT * FROM dogs;

INSERT INTO dogs (name, breed) VALUES ('Princess Jane', 'Retrievesadfdsafdasfsafr');

SELECT * FROM dogs;


################################################################################
# Decimal: decimal(5,2)
# total number of digits, how many digits come after the decimal point
# 9    9    9  .     9    9
#              |<--after decimal-->|
# |<---------whole length--------->|

create database decimals;
use decimals;
create table decis(
    price decimal(5,2)
        );

desc decis;

insert into decis(price)
values (7),
       (23.213479819823),
       (-12378.1234),
       (666.66),
       (77.777);

select * from decis;

################################################################################
# FLOAT DOUBLE
# the differences here will not matter much, essentially
# Fixed-Point Types (Exact Value) - DECIMAL, NUMERIC
# Floating-Point Types (Approximate Value) - FLOAT, DOUBLE

# Store larger numbers using less space, it comes at the cost of precision
# float 4 bytes 7 digits
# double 8 bytes 15 digits

# You should always use decimals unless you knwo that the precison might not be a thing
create table thingies (price float);
insert into thingies values (88.45);
insert into thingies values (8877.45);
insert into thingies values (887766.45);
insert into thingies values (8877665544.45); # which is different from original data
select * from thingies;

# suggestions: decimal > double > float

# CODE: FLOAT and DOUBLE
#
# CREATE TABLE thingies (price FLOAT);
#
# INSERT INTO thingies(price) VALUES (88.45);
#
# SELECT * FROM thingies;
#
# INSERT INTO thingies(price) VALUES (8877.45);
#
# SELECT * FROM thingies;
#
# INSERT INTO thingies(price) VALUES (8877665544.45);

SELECT * FROM thingies;


################################################################################
# Dates and Times
# Date: 'YYYY-MM-DD' Format
# Time: 'HH-MM-SS' Format  'Values with a Time But No Date'
# DATETIME: '' (what I used for most),such as comment on someone else's post,
# how many hours ago, date ago,...commented
# What you have rows in tables, you often wanna store the data by the time, and you can check how old/new the data is
# DATETIME: 'YYYY-MM-DD HH:MM:SS' - the most useful one

select database();
show databases;
create database datetimee;
use datetimee;
create table people(
    name varchar(100),
    birthdate date,
    birthtime time,
    birthdt datetime
);

insert into people (name, birthdate, birthtime, birthdt)
values ('Padma','1983-11-11','10:07:35','1983-11-11 10:07:35');

insert into people (name, birthdate, birthtime, birthdt)
values ('Larry','1943-12-25','04:10:42','1943-12-25 04:10:42');

select * from people;

select name,birthdt from people
order by birthdt desc;

# CODE: Creating Our DATE data
# CREATE TABLE people (name VARCHAR(100), birthdate DATE, birthtime TIME, birthdt DATETIME);
#
# INSERT INTO people (name, birthdate, birthtime, birthdt)
# VALUES('Padma', '1983-11-11', '10:07:35', '1983-11-11 10:07:35');
#
# INSERT INTO people (name, birthdate, birthtime, birthdt)
# VALUES('Larry', '1943-12-25', '04:10:42', '1943-12-25 04:10:42');
#
# SELECT * FROM people;


select curdate(); # gives current date
select curtime(); # gives current time
select now(); # gives current datatime

# These are useful in insert statements

insert into people(name, birthdate, birthtime, birthdt)
values ('virtual_guy',curdate(),current_time(),now());

select * from people;

delete from people where name = 'virtual_guy';

insert into people(name, birthdate, birthtime, birthdt)
values('Toaster','2017-04-21','19:12:43','2017-04-21 19:12:43');

select name,birthdate, day(birthdate) from people;
# DAY: all it does is to extract the day
select name,birthdate, year(birthdate),month(birthdate),day(birthdate) from people;

select name,birthdate, dayname(birthdate) from people;
select name,birthdate, dayofweek(birthdate) from people;
select name,birthdate, dayofyear(birthdate) from people;
# this will go wrong in applying to time, since time does not store these inforamtion

select name,birthdate,monthname(birthdate) from people;



#  this fucntion produces this format: "April 21st 2017"
# function waysL
select concat(
    monthname(birthdt),' ',
    dayofmonth(birthdt),if(dayofmonth(birthdt)%10 = 1,'st',if(dayofmonth(birthdt)%10 = 2,'nd',if(dayofmonth(birthdt)%10 = 3,'rd','th'))),' ',
    year(birthdt)) as dateOfBirth
from people;
# alternative: date_formate way:
select date_format(birthdate,'%M %D %Y') from people;

# Date format
select date_format(birthdate,'%M %d %Y') from people;

select
       concat(name,date_format(birthdate,' was born on a %W.')) as announce
from people;

# American type:
# DD/MM/YYYY

select date_format(birthdate,'%m/%d/%Y'),birthdate as americandate
from people limit 3;


# CODE: Formatting Dates
# SELECT name, birthdate FROM people;
#
# SELECT name, DAY(birthdate) FROM people;
#
# SELECT name, birthdate, DAY(birthdate) FROM people;
#
# SELECT name, birthdate, DAYNAME(birthdate) FROM people;
#
# SELECT name, birthdate, DAYOFWEEK(birthdate) FROM people;
#
# SELECT name, birthdate, DAYOFYEAR(birthdate) FROM people;
#
# SELECT name, birthtime, DAYOFYEAR(birthtime) FROM people;
#
# SELECT name, birthdt, DAYOFYEAR(birthdt) FROM people;
#
# SELECT name, birthdt, MONTH(birthdt) FROM people;
#
# SELECT name, birthdt, MONTHNAME(birthdt) FROM people;
#
# SELECT name, birthtime, HOUR(birthtime) FROM people;
#
# SELECT name, birthtime, MINUTE(birthtime) FROM people;
#
# SELECT CONCAT(MONTHNAME(birthdate), ' ', DAY(birthdate), ' ', YEAR(birthdate)) FROM people;
#
# SELECT DATE_FORMAT(birthdt, 'Was born on a %W') FROM people;
#
# SELECT DATE_FORMAT(birthdt, '%m/%d/%Y') FROM people;
#
# SELECT DATE_FORMAT(birthdt, '%m/%d/%Y at %h:%i') FROM people;


################################################################################
# Date Math
# Calculate your age, for instance, mine is the following
select datediff(curdate(),'1998-02-19')/365 as age;

# XXX days ago, XXX was born.
# similar circumstance is that XXX ago XX commented, or this was posted XXX days ago (minutes ago, days ago)
# datediff
# date_add
# +/-
select * from people;
select concat(datediff(now(),birthdt),' days ago ',name,' was born.') as 'hi_message'
from people;

select birthdt,date_add(birthdt,interval 1 month) from people;

select curdate(),date_add(curdate(), interval 2 year) from people;

select curdate()+interval 1 month;


# CODE: Date Math
# SELECT * FROM people;
#
# SELECT DATEDIFF(NOW(), birthdate) FROM people;
#
# SELECT name, birthdate, DATEDIFF(NOW(), birthdate) FROM people;
#
# SELECT birthdt FROM people;
#
# SELECT birthdt, DATE_ADD(birthdt, INTERVAL 1 MONTH) FROM people;
#
# SELECT birthdt, DATE_ADD(birthdt, INTERVAL 10 SECOND) FROM people;
#
# SELECT birthdt, DATE_ADD(birthdt, INTERVAL 3 QUARTER) FROM people;
#
# SELECT birthdt, birthdt + INTERVAL 1 MONTH FROM people;
#
# SELECT birthdt, birthdt - INTERVAL 5 MONTH FROM people;
#
# SELECT birthdt, birthdt + INTERVAL 15 MONTH + INTERVAL 10 HOUR FROM people;

################################################################################
# Timestamps
# generic term that creates and stores a standardized name across different programming langauges
# Datetime and timestamp from definitions, they are identically difined.
# But the time range they can interpret is different, datetime is wider
# timestamp takes up less space compared to datetime type

create table comments(
    content varchar(100),
    created_at timestamp default now()
);
# So each time when we insert data without specifying the created_at column,
# we will get the created_time automatically by default

insert into comments(content)
values
       ('I think I am going to succeed.'),
       ('I am handsome.'),
       ('Working hard pays off.');

insert into comments(content)
values
       ('Does the creation time differ?');

insert into comments(content)
values
       ('Yes it should be!!!!');

# we get the most recent comments from the top
select * from comments
order by created_at desc;

# Making more sense comments2 table
# meaning that each time when we change the the row created before, the created_at column values will be changed simultaneously
create table comments2(
    content varchar(100),
    created_at timestamp default now() on update current_timestamp
);

insert into comments2(content)
values
       ('Does the creation time differ?');

insert into comments2(content)
values
       ('Yes it should be!!!!');

insert into comments2(content)
values
       ('randomnessrandomness');

# timestamp auto update test
select * from comments2;
# the timestamp for randomnessrandomness is 2021-07-20 10:39:44
update comments2 set content = 'dependence/dependence'
where content = 'randomnessrandomness';
# After updating, let's check if its' timestamp change
select * from comments2;
# the timestamp for dependence/dependence is 2021-07-20 10:41:16


CODE: Working with TIMESTAMPS
CREATE TABLE comments (
    content VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
);

# INSERT INTO comments (content) VALUES('lol what a funny article');
#
# INSERT INTO comments (content) VALUES('I found this offensive');
#
# INSERT INTO comments (content) VALUES('Ifasfsadfsadfsad');
#
# SELECT * FROM comments ORDER BY created_at DESC;
#
# CREATE TABLE comments2 (
#     content VARCHAR(100),
#     changed_at TIMESTAMP DEFAULT NOW() ON UPDATE CURRENT_TIMESTAMP
# );
#
# INSERT INTO comments2 (content) VALUES('dasdasdasd');
#
# INSERT INTO comments2 (content) VALUES('lololololo');
#
# INSERT INTO comments2 (content) VALUES('I LIKE CATS AND DOGS');
#
# UPDATE comments2 SET content='THIS IS NOT GIBBERISH' WHERE content='dasdasdasd';
#
# SELECT * FROM comments2;
#
# SELECT * FROM comments2 ORDER BY changed_at;
#
# CREATE TABLE comments2 (
#     content VARCHAR(100),
#     changed_at TIMESTAMP DEFAULT NOW() ON UPDATE NOW()
# );









