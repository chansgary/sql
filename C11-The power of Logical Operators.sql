# Chapter11: The Power of Logical Operators
# for instance  Put two queries together instead of just one
# add logic into SQL statements

# select all books not published in 2017
# select all birthdays between 1990 and 1992, but not just either one of them
# select all items that are in stock AND  priced below $19.99


################################################################################
# != not equal

show databases;
use book_shop;
show tables;
desc books;
select title, released_year from books
where released_year = 2017;
# instead, we want all books released in year != 2017
select title, released_year from books
where released_year != 2017;

# select all author without last name as 'Harris
select title,author_lname from books
where author_lname != 'Harris';

################################################################################
# NOT LIKE: match pattern in strings
select title from books
where title like 'W%'; # % here is a placeholder

# select all title from book that does not start with W
# hopefully you like it rather than not like it
select title from books
where title not like 'W%';

################################################################################
# > Greater Than >= Greater than or equal to
# instance: airbnb that price filter

select title, released_year
from books
order by released_year;

select title,released_year from books
where released_year >= 2000
order by released_year;

select title,stock_quantity from books
where stock_quantity >= 100;

select 99>1;
# What do you expect?
# Guess(result): true(1)

select -1>1;
# What do you expect?
# Guess(result): false(0)

# A couple of examples here:
select
       100 > 5,
       -15 > 15,
       9 > -10,
       1 > 1,
       'a' > 'b',
       'A' > 'a',
       'Z' = 'z';
# Note: uppercase or lowercase doesn't matter, SQL treats them equal

################################################################################
# < Less Than <= Less than or Equal to
select title,released_year from books
where released_year <= 2000
order by released_year;

select
       3 < -10,
       -10 <-9,
       42 <= 42,
       'h' < 'p',
       'Q' <= 'q';

################################################################################
# && Logical And: all condtions are true
# for instance: select books written by Dave Eggers published after the year 2010
select title,
       author_fname,
       author_lname
from books
where
      author_fname = 'dAvE' &&
      author_lname ='eggers'&&
      released_year > 2010;

# && <==> AND

################################################################################
# OR <==> ||
# Condtion1 || Condition2, one side is true

SELECT
    title,
    author_lname,
    released_year
FROM books
WHERE author_lname='Eggers' || released_year > 2010;


SELECT 40 <= 100 || -2 > 0;
-- true

SELECT 10 > 5 || 5 = 5;
-- true

SELECT 'a' = 5 || 3000 > 2000;
-- true

SELECT title,
       author_lname,
       released_year,
       stock_quantity
FROM   books
WHERE  author_lname = 'Eggers'
              || released_year > 2010
OR     stock_quantity > 100;

################################################################################
# BETWEEN
# select all books published between 2014 and 2015
# solution1:
select title, released_year from books
where
      released_year>=2014 AND
      released_year<=2015;
# solution2:
select title, released_year from books
where
      released_year=2014 OR
      released_year=2015;
# solution3:
select title, released_year from books
where
      released_year between 2014 and 2015;
# Note: this 'AND' is paired with 'BETWEEN'


select title, released_year from books
where
      released_year not between 2014 and 2015;
# print out books whose released_year is outside 2014 nad 2015

################################################################################
# CAST
select cast('2017-05-02' as datetime)

# if we are comparing two fields, make sure that they are of the same data type.
# for instance, if we compare date with datetime, we'd better cast date to datetime
# before the comparison

show databases;
use datetimee;
show tables;
select * from people;

select name,birthdt
from people
where birthdt between  '1980-01-01' and '2000-01-01';

# even though SQL is smart enough to figure out the solution
# we'd better cast them into the same data type first
select name,birthdt
from people
where birthdt between cast('1980-01-01' as datetime)
               and cast('2000-01-01' as datetime);

################################################################################
# IN and NOT IN

use book_shop;
# select all books written by carver,lahiri or smith
# Old way:
select title, author_lname
from books
where author_lname = 'carver' OR
      author_lname = 'lahiri' OR
      author_lname = 'smith';

# New way: 'IN' makes it much shorter
select title, author_lname
from books
where author_lname in ('carver','lahiri','smith');

select title,released_year
from books
where released_year in (2004,2005,2006);

################################################################################
# NOT IN
# get all books that are not published in
# 2000,2002,2004,2006,2008,2010,2012,2014,2016
select title, released_year
from books
where released_year != 2002 AND
      released_year != 2004 AND
      released_year != 2006 AND
      released_year != 2008 AND
      released_year != 2010 AND
      released_year != 2012 AND
      released_year != 2014 AND
      released_year != 2016;

# Too verbose!!!

# massive difference, much easier to add on
select title,released_year
from books
where released_year > 2000 AND
      released_year not in(2000,2002,2004,2006,2008,2010,2012,2014,2016);
# %

select title,released_year
from books
where released_year >= 2000 AND
      released_year % 2 != 0;

################################################################################
# Case Statements


# genre changing depending on the released_year
select title,released_year,
       case
           when released_year >= 2000 then 'Modern lit'
           else '20th Century Lit'
       end as Genre
from books;

# * - low
# ** - medium
# *** hight

select title,stock_quantity,
       case
           when stock_quantity between 0 and 50 then '*'
           when stock_quantity between 51 and 100 then '**'
           else '***'
       end as stock
from books;

# No need of comma
select title,
       case
           when stock_quantity between 0 and 50 then '*'
           when stock_quantity between 51 and 100 then '**'
           when stock_quantity between 101 and 150 then '***'
           else '****'
       end as STOCK
from books;

# more succinct version:
# I think that from the very beginning we should set stock_quantity to be larger than or equal to 0.
select title,
       case
           when stock_quantity <= 50 then '*'
           when stock_quantity <= 100 then '**'
           when stock_quantity <= 150 then '***'
           else '****'
       end as STOCK
from books;

################################################################################
# Logical Operators Exercises

# evaluate the following
select 10 != 10;
# guess(result): 0

select 15 > 14 && 99 - 5 <= 94;
# guess(result): 1

select 1 in (5,3) || 9 between 8 AND 10;
# guess(result): 1

# select all books written before 1980(non inclusive)
select * from books
where released_year < 1980;

# select all books written by Eggers or Chabon
select title,author_lname
from books
where author_lname in ('Eggers','Chabon');

select title,author_lname
from books
where author_lname = 'Eggers' OR
      author_lname = 'Chabon';

# select all books written by lahiri published after 2000
select title, author_lname
from books
where author_lname = 'lahiri' AND
      released_year > 2000;

# select all books with page counts between 100 and 200
select title,pages
from books
where pages between 100 and 200;

select title,pages
from books
where pages >= 100 and pages <=200;

# select all books where author_lname starts with a 'C' or an 'S'
select title,author_lname from books
where author_lname like 'C%' or
      author_lname like 'S%';

# if title contains 'stories', short stories
# just kids and a heartbreaking work -> memoir
# everything else -> novel
# apparently need a case statement

select title, author_lname,
       case
           when title like '%stories%' then 'Short Stories'
           when title like 'just kids' or 'a hearting work' then 'Memoir'
           else 'Novel'
       end as Type
from books;

# title, author_lname, count: how many books each author has book/books


# challenging problems
# command: mysql> SET @@sql_mode='';
select title,author_lname,
    case
        when count(*) = 1 then concat(count(*),' book')
        else concat(count(*),' books')
    end as COUNT
from books
group by author_fname,author_lname
order by author_lname;

# Burn all the books
# drop table xxx;
# drop database xxx;




