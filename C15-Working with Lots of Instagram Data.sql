# C15-Working with Lots of Instagram Data
# run if_clone_data.sql first to get the whole schema of Instagram data and insert all data
show databases;
select database();
show tables;
# get the headers of every table
select * from comments limit 0;
select * from follows limit 0;
select * from likes limit 0;
select * from photo_tags limit 0;
select * from photos limit 0;
select * from tags limit 0;
select * from users limit 0;
# comments: id, comment_text, photo_id, user_id, created_at
# follows: follower_id, followee_id created_at
# likes: user_id, photo_id, created_at
# photo_tags: photo_id, tag_id
# photos: id, image_url, user_id, created_at
# tags: id, tag_name, created_at
# users: id , username, created_at

################################################################################
# Step2: challenges

# Q1: We want to reward our users who have been around the longest - Thank You Email
# Find the 5 oldest users.
select username, created_at
from users
order by created_at
limit 5;

select count(*) as 'size(comments)' from comments;
# 7488 comments in total - pretty large

# Q2: What day of the week do most users register on?
# We need to figure out when to schedule an ad campaign


# date_format(created_at,'%W') as day
select dayname(created_at) as day,
       count(*) as total
from users
group by day
order by total desc;

# Q3: We want to target our inactive users with an email campaign
# Find the users who have never posted a photo
select username,user_id
from photos
right join users on photos.user_id = users.id
where photos.id is null
group by username;

# Q4: We're running a new contest to see who can get the most likes on a single photo,
# WHO WON???

# simpler sub question: for each photo, how many like do they get
# find the most popular photos
select
       photo_id,
       user_id,
       count(*) as count
from likes
group by photo_id
order by count desc
limit 1;
# we find the top liked photo_id is 145, user_id is 3.


select username,
       photo_id,
       likes.user_id,
       count(*) as total
from users
right join photos on
        users.id = photos.user_id
right join likes on
        photos.id = likes.photo_id
group by photos.id
order by total desc
limit 1;

# Note here will be photos and likes should be joined first

# Q5: Our investors want to know: how many times does the average user post?

# Calculate avg number of photos per user
# total number of photos / total number of users
select count(*) from photos;
select count(*) from users;

select
       (select count(*) from photos) /
       (select count(*) from users)
       as avg_photos_per_user;

# Q6: A brand wants to know which hashtags to use in a post:
# What are the top 5 most commonly used hashtags?

select tag_name,
       count(*) as total
from tags
right join photo_tags on
    tags.id = photo_tags.tag_id
group by tag_name
order by total desc
limit 5;

# Q7: We have a small problem with bots on our site...
# Find users who have liked every single photo on the site

# comments: id, comment_text, photo_id, user_id, created_at
# follows: follower_id, followee_id created_at
# likes: user_id, photo_id, created_at
# photo_tags: photo_id, tag_id
# photos: id, image_url, user_id, created_at
# tags: id, tag_name, created_at
# users: id , username, created_at

select
       username,
       count(*) as total
from likes
    left join users
        on likes.user_id = users.id
group by user_id
having total = (select count(*) from photos)
order by count(*) desc;

# Note that we can only use where before group by statement
# difference between where and having statements








