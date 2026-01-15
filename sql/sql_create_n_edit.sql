create table if not exists test as
select *
from track
limit 20
;

create table if not exists test2
(
	track_id integer
	, track_name text
	, unit_price numeric(4,2)
);

select *
from test2
;

insert into test2
values
	(1, 'some name', 2.45)
	, (2, 'great song', 3.12)
;

insert into test2
select
	track_id
	, name as track_name
	, unit_price
from track
where
	track_id > 2
limit 10
;

create schema if not exists spotify;

select current_schema;

set search_path to spotify;


select *
from public.track
;

select *
from public.customer
;


create table if not exists users
(
	user_id serial -- integer not null unique auto increment
	, username varchar(64) not null unique
	, country varchar(20)
	, city varchar(50)
	, email varchar(254) check(position('@' in email) != 0)
	, created_at timestamp default localtimestamp
	, updated_at timestamp
	, is_deleted boolean default false
	, deleted_at timestamp
	, primary key (user_id)
)
;

insert into users (username, country, city, email)
values
	('john.doe', 'USA', 'New York', 'john.doe@ny.com')
;

insert into users (username, country, city, email)
select
	concat_ws('.', lower(first_name), lower(last_name)) as username
	, country
	, city
	, email
from public.customer
where
	support_rep_id = 5
;

select *
from users
;

create table if not exists tracks
(
	track_id serial
	, track_name text not null 
	, authors text
	, milliseconds integer
	, bytes integer
	, primary key (track_id)
)
;

insert into tracks (track_name, authors, milliseconds, bytes)
select
	name as track_name
	, composer as authors
	, milliseconds
	, bytes
from public.track
limit 20
;

select *
from tracks
;


create table playlists
(
	playlist_id serial
	, user_id integer not null
	, track_id integer not null
	, primary key (playlist_id)
	, foreign key (user_id) references users(user_id) on delete cascade
	, foreign key (track_id) references tracks(track_id) on delete cascade
)
;

insert into playlists (user_id, track_id)
values
	(1, 2),
	(1, 4),
	(2, 3)
;

select *
from playlists
;

select *
from users
;

update users
set city = 'Frankfurt'
where
	user_id = 12
;

delete from users
where
	user_id = 6
;

select *
from users
order by user_id
;

alter table users
rename to subscribers
;

select *
from subscribers
;

alter table subscribers
add column reg_year smallint
;

select *
from subscribers
;

update subscribers
set reg_year = extract('year' from created_at)
;

select max(length(track_name)), max(length(authors))
from tracks
;

alter table tracks
alter column track_name type varchar(100)
;

alter table tracks
alter column authors type varchar(100)
;

select current_schema;

set search_path to public;

select *
from test2
;

truncate table test2;

select *
from test
;

drop table test;

select *
from spotify.playlists
;

drop table spotify.subscribers cascade;


create view v_track as
select
	track_id
	, name as track_name
	, genre_id
	, composer as authors
	, round(milliseconds / 60000.0, 2) as duration_min
	, round(bytes/1024.0/1024.0, 2) size_mb
from track
;



select *
from v_track