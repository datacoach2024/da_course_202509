select 
	customer_id
	, first_name
	, last_name
	, country
	, case country
		when 'Canada' then 'CAN'
		when 'Germany' then 'GER'
		else 'N/A'
	end as country_code
	, case
		when country in ('India', 'China', 'Japan') then 'Asia'
		when country in ('USA', 'Canada', 'Mexica', 'Chile', 'Brazil', 'Argentina') then 'America'
		else 'Europe'
	end as continent
from customer c
;

select
	case
		when milliseconds between 0 and 100000 then 'short'
		when milliseconds between 100001 and 300000 then 'medium'
		else 'long'
	end as duration_cat
	, count(track_id) as tracks_cnt
from track t
group by duration_cat
order by tracks_cnt
;

select 
	track_id
	, name
	, composer
	, coalesce(composer, 'n/a') as composer
from track
where
	composer is not null
;
