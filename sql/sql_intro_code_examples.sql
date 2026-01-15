-- однострочный комментарий

/*
многострочный
комментарий
*/

select 
	track_id 
	, name 
	, album_id
	, bytes
from track
;

select 9/3
;

select 9/4.
;

select
	track_id
	, name as track_name
	, round(milliseconds / 60000.0, 2) as duration_in_min
from track
;

select *
from track
where
	album_id != 3
;

/*
1. from
2. where
3. select
*/

select *
from track
where
	composer = 'AC/DC'
	or composer = 'Queen'
	or composer = 'Linking Park'
	or composer = 'Pink Floyd'
	or composer = 'Abba'
;

select *
from track
where
	composer in ('Queen', 'AC/DC', 'Linkin Park', 'Pink Floyd')
;

select *
from track
where
	composer = 'Queen'
	and milliseconds > 300000
;

select *
from track
where
	/*
	 (байты больше 9000000 и автор Queen) 
	 либо автор U2
	 */
	bytes > 9000000
	and composer = 'Queen'
	or composer = 'U2'
;

select *
from track
where
	bytes > 9000000
	and (composer = 'Queen' or composer = 'U2')
order by bytes desc
;

select *
from track
order by milliseconds desc
limit 10
;

select *
from track
order by milliseconds desc
limit 10
offset 10
;

/*
from
order by
select
offset
limit
*/

/*
count
sum
avg
min
max
*/

select count(*)
from track
;

select
	count(*) as cnt
	, count(composer) as not_null_cnt
from track
;

select *
from track
order by name
;

select
	count(name) as tracks_cnt
	, count(distinct name) as uniq_names
from track
;

select distinct
	country
	, city
from customer
;

select *
from customer
;

select
	country
	, city
	, count(customer_id)
from customer
group by 
	country
	, city
;

select *
from customer
where
	company is null
;

/*
from
where
group by
having
select
*/

select
	country
	, count(customer_id) as customers_cnt
from customer
where
	company is null
group by 
	country
having
	count(customer_id) > 1
;

