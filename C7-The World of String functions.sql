-- String functions
-- previous chapter we do CRUD
-- CREATE Read Update delete

-- Running SQL files is much more convenient than manually typing in command line
show databases;
use cats_app;
show tables;
# drop table cats;

# create a new Cat
create table cats
    (
        cat_id int not null auto_increment primary key,
        name varchar(100),
        age int
);

show columns from cats;
-- same as select * from cats
-- source xxxfile.sql


################################################################################
show databases;
use book_shop;
select database();
show tables;
desc books;
select * from books;

# String functions
# concat pieces of data: combine firstnames + lastnames
# concat if we want a space in the middle concat(fname, ' ',lname)
# select author_fname,author_lname from books;
select concat("Hello ", "Wolrd"); # SQL version of helloworld

select
    concat(author_fname,' ',author_lname)
as author_fullname
from books
order by author_fname;

# combine all these together, doesn't have to one single column
select
       author_fname as first,
       author_lname as last,
       concat(author_fname,' ',author_lname) as author_fullname,
       concat(author_fname,', ',author_lname) as author_fullname2
from books
order by first;

# concat with multiple fields but with same dlm
desc books;

select
    concat_ws(' - ', title,author_fname,author_lname)
#   concat(title,' - ',author_fname,' - ',author_lname) same as above
from books;

select
    concat('<< ', title,' >>',' - ',author_fname,',',author_lname)
as
    'Movie - Author'
from books;

################################################################################
# Note: MySQL starts at 1 instead of 0 like other languages
select substring('Hello World',1,4);
select substring('Hello World',7); # from the number to the end
select substring('Hello World',-3); # from -3 to the end

# when you have a quotation mark, please pay attention around it
select * from books;

select substring(title,1,10)
as first10string
from books;

# substr works too

select
       concat(
           substr(title,1,10),
           '...')
as 'short title'
from books;

# Looks like the following
# "The Namesa...
# Norse Myth...
# American G...
# Interprete...
# A Hologram...
# The Circle..."

################################################################################
# REPLACE
select replace('Hello World', 'Hell','$%&*');

select
    replace('Hello World','l',7)
as 7World;

select
    replace('Hello World','o',0) # case sensitive!!!
as 0World;

select
    replace('cheese bread coffee milk',' ', ' OR ');

# replace all 'e's to 3

select
    replace(substr(title,1,10),'e',3)
from books;

################################################################################
# REVERSE

select reverse("meow meow meow meow");

select
    concat(author_fname,reverse(author_fname))
from books;

################################################################################
# CHAR LENGTH
select
    char_length("Hello World")
as len;


select
       author_lname,char_length(author_lname) as len
from books;

# we want to see things like
# "Eaggers is 6 characters long" for each author

select
       concat(author_lname,' is ',char_length(author_lname),' characters long')
as len_statements
from books;

# SQL-formatter looks nicer in format
select
       current_date,
       current_time,
       concat(lower(author_lname),',',upper(author_fname))
as first_LAST
from books;

select
    concat('My favorite book is ','<<',lower(title),'>>')
from books;

# upper can only takes one input each
# upper(string/columns) correct
# upper(string1,string2,string3) wrong!!!

################################################################################
# challenge
# reverse and upper case the following sentence:
# 'Why does my cat look at me with such hatred?'
select upper(reverse('Why does my cat look at me with such hatred?'));
select reverse(upper('Why does my cat look at me with such hatred?'));
# same result

# replace all spaces in title to '->'
select replace(title,' ','->')
as title
from books;

# forwards: lastname, backwards: reverse(lastname)
select
       author_lname as forwards,
       reverse(author_lname) as backwards
from books;

# full name in caps first+last
select
       concat(upper(author_fname),' ', upper(author_lname))
as 'full name in caps'
from books;

select
       concat(title," was released in ",released_year)
as blurb
from books;

# title + character count
select
       title,
       char_length(title) as 'character count'
from books;

# short title:10 chars+..., author:last,first, quantity:num in stock
select
       concat(substr(title,1,10),'...') as 'short title',
       concat(author_lname,',',author_fname) as author,
       concat(stock_quantity,' in stock')
from books;















