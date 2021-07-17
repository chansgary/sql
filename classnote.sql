show databases;
select database();

# create shirts_db
create database shirst_db;
use shirst_db;
select database();

# create a new table shirts shirt_id article color shirt_size last_worn
# drop table shirts;

create table shirts(
    shirt_id int not null primary key auto_increment,
    article varchar(20),
    color varchar(10),
    shirt_size varchar(3),
    last_worn int
);

desc shirts;

# starter data
insert into shirts(article, color, shirt_size, last_worn)
value
    ('t-shirt', 'white', 'S', 10),
    ('t-shirt', 'green', 'S', 200),
    ('polo shirt', 'black', 'M', 10),
    ('tank top', 'blue', 'S', 50),
    ('t-shirt', 'pink', 'S', 0),
    ('polo shirt', 'red', 'M', 5),
    ('tank top', 'white', 'S', 200),
    ('tank top', 'blue', 'M', 15);

select * from shirts;

# Add a new shirt
insert into shirts(article, color, shirt_size, last_worn)
values ("polo shirt", "purple","M",50);

# select all shirts but only print out article and color
select article,color from shirts;

# select all medium shirts
select article, color, shirt_size, last_worn from shirts where shirt_size = "M";

# update all polo shirts to be size Large
select * from shirts where article = "polo shirt";
update shirts set shirt_size = "L"
where article = "polo shirt";
select * from shirts where article = "polo shirt";

# update the shirt last worn 15 days ago
select * from shirts where last_worn = 15;
update shirts set last_worn = 0 where last_worn = 15;

# update all white shirts, change size to 'XS' and color to be off white
select * from shirts where color = "white";

update shirts set shirt_size = "XS", color = "off white" where color = "white";

select * from shirts;

# delete all old shirts last worn 200 days ago
select * from shirts where last_worn>=200;
delete from shirts where last_worn>=200;
select * from shirts;

# delete all tank tops
select * from shirts where article = "tank top";
delete from shirts where article = "tank top";

select * from shirts;

delete from shirts;
# it does not mean to drop the table but just delete all rows/observations from shirts

drop table shirts;
# now we drop the entire table




