create table tr1 as
select
	track_id
	, name
	, genre_id
from track
limit 5
;

-- create table tr2 as
SeLEcT track_id , name
										, genre_id
FROM track
								limit 5 offset 2
;

select * from tr1;
select * from tr2;

select *
from tr1
left join tr2 on tr1.track_id = tr2.track_id
;

select *
from tr1
right join tr2 on tr1.track_id = tr2.track_id
;

select *
from tr1
inner join tr2 on tr1.track_id = tr2.track_id
;

select *
from tr1
full join tr2 on tr1.track_id = tr2.track_id
;

select 
	tr1.*
	, genre.name as genre_name
from tr1
left join genre on tr1.genre_id = genre.genre_id
;

select *
from genre
;

/*
ЗАДАЧА
1. вытащить данные содержащие следующие столбцы:
* customer_id
* full_name (first_name and last_name)
* total
и посчитать общую сумму чеков в разбивке по клиентам
*/
select
	c.customer_id 
	, concat_ws(' ', c.first_name, c.last_name) as full_name
	, sum(i.total) as total_sum
from customer c
left join invoice i on c.customer_id = i.customer_id
group by
	c.customer_id
	, concat_ws(' ', c.first_name, c.last_name)
order by c.customer_id
;

select
	t1.name as first_track
	, t2.name as second_track
from track t1
cross join track t2
where
	t1.name != t2.name
;

 -- self join 
select
	e1.employee_id as manager_id
	, concat_ws(' ', e1.first_name, e1.last_name) as manager_name
	, e2.employee_id as subordinate_id
	, concat_ws(' ', e2.first_name, e2.last_name) as subordinate_name
from employee e1
left join employee e2
	on e1.employee_id = e2.reports_to
order by e1.employee_id
;

select
	e1.employee_id as manager_id
	, concat_ws(' ', e1.first_name, e1.last_name) as manager_name
	, count(e2.employee_id) as subordinates_cnt
from employee e1
left join employee e2
	on e1.employee_id = e2.reports_to
group by
	e1.employee_id
	, concat_ws(' ', e1.first_name, e1.last_name)
order by e1.employee_id
;

select 
	t.track_id
	, t.name
from track t
left join invoice_line il
	on t.track_id = il.track_id
where
	il.quantity is null
;

select 
	t.track_id
	, t.name
from track t
where
	exists (
		select 1
		from invoice_line il
		where
			il.track_id = t.track_id
	)
order by t.track_id
;

select *
from tr1
;

select *
from tr2
;

select *
from tr1
union all
select *
from tr2
order by track_id
;

select *
from tr1
intersect
select *
from tr2
;

select *
from tr1
except
select *
from tr2
;

update tr2
set track_id = 3
where
	track_id = 6

select *
from tr1
left join tr2 on tr1.track_id = tr2.track_id
;

select 
	t.track_id
	, t.name
	, aa.name as artist_name
from track t
left join album a on t.album_id=a.album_id 
left join artist aa on a.artist_id=aa.artist_id