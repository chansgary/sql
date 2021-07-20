-- aggregate function such as: finding average, group by...
-- fake data for instagram, unless you manually check your data
-- all insights, combine authors group by year, average page numbers per genre
-- power user/influenzer
-- to get meaning out of data
-- count sum min max...

################################################################################
# COUNT
# select count(col) from tbl;
select count(*) from books;
# tells us there are 19 rows. check how many things in tables
select author_fname from books;
select distinct author_fname from books;

select count(author_fname) from books; # 19 rows with duplicated first name
select count(distinct author_fname) from books; # 12 rows without duplicated first name

select count(distinct author_fname,author_lname) from books;

# how many title contain 'the'?
select title from books
where title like '%the%';

select count(title) from books
where title like '%the%';

select count(*) from books
where title like '%the%';

################################################################################
# GROUP BY: summarize or aggregates identical data into single rows
# Show error like:
# ERROR 1055 (42000): Expression #1 of SELECT list is not in GROUP BY clause and contains
# nonaggregated column 'section9.books.title' which is not functionally
# dependent on columns in GROUP BY clause;
# this is incompatible with sql_mode=only_full_group_by

# solution1:
SET @@sql_mode='';

select title,author_lname from books
group by author_lname;
# this is not allowed by default in the newer versions

#solution2:
select author_lname from books
group by author_lname;

# this will make some row to become super row(mega row) since original two/more rows
# are now combined in to one

# count how many books each author wrote
select author_lname, count(*)
from books
group by author_lname;

select concat(author_lname,' ',author_fname),count(*) as quantity from books
group by author_lname,author_fname
order by quantity desc;

select concat('In ',released_year, ', ',count(*), ' books has released') as 'year - quantity'
from books
group by released_year
order by released_year desc;

################################################################################
# MIN and MAX

# find the minimum released_year
select min(released_year) from books;
select max(released_year) from books;
select avg(pages) from books;

select max(pages),title from books;
# this is not going to give us the title of the book with the most pages

select title,pages from books;
# since the pages for the title 'the namesake' is only 291

################################################################################
# One potential Solution
select max(pages),title from books;
# malfunctioning, since two columns is independent so title takes the first value!!!!!!

# Subqueries: Use a query inside of another query
select * from books
where pages = (select min(pages)
               from books);

# So the correct query above should be:
select title, pages from books
where pages = (select max(pages)
                from books);

# downside: this is a bit of slow

#faster way:
select title,pages from books order by pages desc limit 1;

################################################################################
# MIN/MAX with group by

# find the year each author published their first book
select
       title,
       concat(author_fname,',',author_lname) as author_fullname,
       min(released_year) as min_year
from books
group by author_fullname;

# find the longest page count for each author
select author_fname,author_lname,max(pages) from books
group by author_fname,author_lname;

# nicer clean up version
select
       concat(author_fname, ' ', author_lname) as author,
       max(pages) as 'longest book'
from books
group by author_fname,
         author_lname;


################################################################################
# SUM: Add things together

# sum all pages in the entire database
select sum(pages) from books;
select count(author_lname) from books;

## SUM with GROUP BY
# sum all pages with each author has written
select sum(pages),author_fname,author_lname from books
group by author_fname,author_lname
order by sum(pages) desc;

# self-counted average
select
       sum(pages)/count(pages) as 'avg(pages)'
from books;

################################################################################
# AVG: sum together and divide
select avg(pages) from books;

# same result as we previously predicted

# calculate the average released_year across all books
select round(avg(released_year)) from books;
# with round, make more sense

# calculate the average stock quantity for books released in the same year
select
       released_year,
       round(avg(stock_quantity)) as quantity
from books
group by released_year;

select author_fname,
       author_lname,
       round(avg(pages))
from books
group by
         author_fname,
         author_lname;

select author_fname,
       author_lname,
       avg(pages)
from books
group by
         author_fname,
         author_lname;
# we will see 4 decimal floats if not rounded.

## challenges:
# print the number of books in the exercise
select count(*) as num from books ;

# print out how many books were released in each year
select released_year,count(*) from books
group by released_year;

# print out the total number of books in stock
select sum(stock_quantity) from books;

# find the average released_year for each author
select concat(author_fname,',',author_lname) as author_fullname,
       round(avg(released_year)) as avg_year
from books
group by author_fname,author_lname;

# find the full name of the author who wrote the longest book
# rewarding quesiton
select concat(author_fname,',',author_lname) as author_fullname
from books
where pages = (select max(pages) from books);

select
       concat(author_fname,',',author_lname) as author_fullname,
       pages
from books
order by pages desc
limit 1;


# all information of longest book
select * from books
order by pages desc
limit 1;

# year,#books, avg pages
select
       released_year as year,
       count(*) as '# books',
       avg(pages) as 'avg pages'
from books
group by released_year
order by released_year;



