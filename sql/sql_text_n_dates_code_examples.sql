select *
from track
where
	name ilike '%Rock%'
;

select *
from customer
where
	first_name like 'Bj_rn'
;

select 
	customer_id
	, country || ', ' || city || ', ' || address as full_address
	, concat(country, ', ', city, ', ', address) as full_address2
	, concat_ws(', ', country, city, address) as full_address3
from customer
;

select
	name
	, length(name) as track_name_length
from track
where
	length(name) between 25 and 29
order by track_name_length desc
;

select
	name
	, left(name, 5) as first_five
	, right(name, 4) as last_four
	, substr(name, 6, 2) as middle_two
from track
;

select
	employee_id
	, email
	, position('@' in email) as at_idx
	, left(email, position('@' in email)-1) as username
	, right(email, length(email) - position('@' in email)) as domain_name
from employee
;

select
	name
--	, upper(name) as upper_name
--	, lower(name) as lower_name
--	, initcap(lower(name)) as initcap_name
	, concat(upper(left(name, 1)), lower(right(name, length(name) - 1))) as proper_name
from track
;

select
	track_id
	, composer
	, split_part(composer, ', ', 1) as first_author
	, string_to_array(composer, ', ') as authors_arr 
	, (string_to_array(composer, ', '))[2] as second_author
from track
;


select 
	name
	, regexp_substr(name, '\d{4}') as year_in_name
from track
where
	regexp_like(name, '\d{4}')
;

select *
from customer
;

select
	first_name
	, last_name
	, concat(left(first_name, 1), '. ', last_name)
from customer
;

select
	concat(country, ' ', city, ' ', address)
	, concat_ws(' ', country, city, address)
from customer
;

select now(), now() at time zone 'Europe/Moscow'
;

show time zone;

select 
	now()
	, localtimestamp
	, current_time
	, current_date
;

select 
	invoice_id
	, customer_id
	, invoice_date
	, localtimestamp - invoice_date as diff 
	, age(localtimestamp, invoice_date) as diff_in_years
	, extract('year' from age(localtimestamp, invoice_date)) as years_since
from invoice
;

select
	current_date
	, pg_typeof(current_date) as type1
	, invoice_date
 	, pg_typeof(invoice_date) as type2
 	, current_time
 	, pg_typeof(current_time) as type3
 	, localtimestamp - invoice_date as diff
 	, pg_typeof(localtimestamp - invoice_date) as type4
from invoice
;

/*
date
timestamp
time 
interval
*/
;

select
	make_date(2025, 4, 30)
	, make_timestamp(2025, 4, 30, 0, 10, 0)
	, cast(current_date + make_interval(days=>1) as date) as tomorrow
	, (current_date + make_interval(days=>1))::date
;

select 
	localtimestamp
	, cast(localtimestamp as date) as local_date
	, extract('day' from localtimestamp)
	, extract('month' from localtimestamp)
	, extract('year' from localtimestamp)
	, to_char(localtimestamp, 'HH24:MM')
	, to_char(localtimestamp, 'Month')
	, date_trunc('century', localtimestamp)
;

select
	localtimestamp
	, date_trunc('month', localtimestamp) + make_interval(months=>1) - make_interval(days=>1) as month_end
;

select
	extract('year' from make_date(2025, 4, 30)) * 100 + extract('month' from make_date(2025, 4, 30))
;

select
	localtimestamp
	, to_char(localtimestamp, 'YYYYMM')::int as monthkey
;

