-- Refining our results:
-- 5 rows/obeservations, sort our results
# More weapons in the arsenal
show databases;
use book_shop;
select database();

# Insert new data into the table 'books'
INSERT INTO books
    (title, author_fname, author_lname, released_year, stock_quantity, pages)
    VALUES ('10% Happier', 'Dan', 'Harris', 2014, 29, 256),
           ('fake_book', 'Freida', 'Harris', 2001, 287, 428),
           ('Lincoln In The Bardo', 'George', 'Saunders', 2017, 1000, 367);

# show all title of the books
select title from books;

# select unique names of authors from 'books'
show tables;
select author_fname from books;

# same
select distinctrow author_fname from books;
select distinct author_fname from books;

select distinct released_year from books order by released_year;

# what if we want distinct author names from books?

# the distinct will function to the entire row, just have to separate different columns by comma
select distinct concat(author_lname,' ',author_fname) as author_name from books;
select distinct author_fname,author_lname from books;


# order by - assume ASCENDING
# if string, order by alphabetical order
# it int, order by values

select author_lname from books order by author_lname;
select author_lname from books order by author_lname asc; # by default ASC

select title from books order by title desc;
select released_year from books order by released_year desc;

# can be unmatched
select title,pages from books order by released_year;

#        1         2            3
select title,author_fname,author_lname
from books order by 2;
# it is a shortcut that we don't have to type all

# After sorting lastname, we go for the fname
select author_fname,author_lname from books
order by author_lname,author_fname;

# limit ~~ order by
select title from books order by title limit 5;

# 5 recently released books
select released_year,title
from books
order by released_year desc
limit 5;

# specify the starting point from where we want to start
# 0 is the first row now, recall that for substring "hello" h is at 1

# for instance, first 10 posts, click next then next 10 pages
# 0,10;10,10;20,10;
select released_year,title
from books
order by released_year desc
limit 0,5;

# select * from books limit 'a big number that in the MySQL documentation';


################################################################################
# LIKE

# Percentage symbols is wildcard: pattern matching
# '%         d    a       %   '
# whatever   d    a    whatever'

select author_fname from books where author_fname like '%da%';

# Percentage symbols is wildcard: pattern matching
# d    a       %   '
# d    a    whatever'
select author_fname from books where author_fname like 'da%';

select title from books where title like 'the%';
select title from books where title like '%the%';

################################################################################
# More WildCards
select title, stock_quantity from books;

# hundreds
select title, stock_quantity from books where stock_quantity like '___';
# thousands
select title, stock_quantity from books where stock_quantity like '____';

SELECT title FROM books;
SELECT title FROM books where title like '%\%%';
SELECT title FROM books WHERE title LIKE '%\_%'

# if there are special character inside, we should put in \specialcharacter


################################################################################

# select all story collections
select title from books where title like '%stories%';

# print out the longest title and page count
select title,pages from books
order by pages desc
limit 1;

# print a summary containing the title and year for the 3 most recent books
select concat(title,' - ',released_year) from books
order by released_year desc
limit 3;

# find all books with an author_lname that contains a space(" ")
select title,author_lname from books
where author_lname like '% %';

# find the 3 books with the lowest stock
select title, released_year,stock_quantity
from books
order by stock_quantity
limit 3;

# print title and author_lname, sorted first by author_lname, and then by title
select title, author_lname from books
order by author_lname,title;

select concat('MY FAVORITE AUTHOR IS ',author_fname,' ',author_lname,'!') as yell
from books
order by author_lname;



