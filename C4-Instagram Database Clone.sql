# C14 -  Instagram Database clone
# Build the schema then we will have a bunch of challenges
# will talk little bit about performance
# data: thousands of rows


################################################################################
# Schema:
# user_table: username
# image_url:
# likes - only add once
# #hashtag
# content
# comment
# followers, following --> one way relationship(does not need permission )
#
# users
# photos
# comments
# likes
# hashtags
# followers/followees

show databases;
drop database C14_ig_clone;
create database C14_ig_clone;
use C14_ig_clone;

create table users(
    id int auto_increment primary key,
    username varchar(255) unique not null,
    created_at timestamp default now()
);

# insert into users(username)
#
# # test users table
# values('BlueCat'),
#        ('chan'),
#        ('Liu');
# select * from users;

create table photos(
    id int auto_increment primary key,
    image_url varchar(255) not null,
    user_id int not null,
    created_at timestamp default now(),
    foreign key(user_id)
        references users(id)
        on delete cascade
);


# test photos
# select *
# from photos
# join users on photos.users_id = users.id;
# insert into photos (image_url, users_id)
# values ('/arfqasirfhi',1),
#        ('/gdtfdfvdvvv',2),
#        ('/asrfqervafv',2);

create table comments(
    id int auto_increment primary key,
    comment_text varchar(255) not null,
    user_id int not null,
    photo_id int not null,
    created_at timestamp default now(),
    foreign key(user_id) references users(id) on delete cascade,
    foreign key(photo_id) references photos(id) on delete cascade,
    primary key(user_id, photo_id) # will not allow us to have null user_id / photo_id
);

create table likes(
    user_id int not null,
    photo_id int not null,
    created_at timestamp default now(),
    foreign key(user_id) references users(id) on delete cascade,
    foreign key(photo_id) references photos(id) on delete cascade
);


create table follows(
    follower_id int not null,
    followee_id int not null,
    created_at timestamp default now(),
    foreign key(follower_id) references users(id) on delete cascade,
    foreign key(followee_id) references users(id) on delete cascade,
    primary key (follower_id,followee_id) # same data will show at most once
    # follower_id != followee_id
);

create table tags(
    id int auto_increment not null primary key,
    tag_name varchar(255) unique,
    created_at timestamp default now()
);

create table photo_tags(
    photo_id int not null,
    tag_id int not null,
    foreign key(photo_id) references photos(id) on delete cascade,
    foreign key(tag_id) references tags(id) on delete cascade,
    primary key (photo_id,tag_id)
);

