/* ЗАДАЧА
Из таблицы invoice вытащить поля:  invoice_id, customer_id, 
billing_country, total
* посчитать итог для каждой страны
* посчитать нарастающий итог для каждой страны
* посчитать скользящее среднее 2 предыдущих, 
  текущей и 2 будущих строк для каждой страны
*/

select 
	invoice_id
	, customer_id
	, invoice_date
	, billing_country
	, total
	, sum(total) over(partition by billing_country) as total_by_country
	, sum(total) over w as running_total_by_country
	, round(avg(total) over(w rows between 2 preceding and 2 following
	), 2) as sliding_avg
from  invoice
window w as (
	partition by billing_country
	order by invoice_date
)
order by billing_country, invoice_date
;

select 
	inv.*
	, rank() over(order by total) as total_rank
	, dense_rank() over(order by total) as dns_rank
	, row_number() over(order by total) as row_n
from inv_subset inv
order by total
;

select *
from (
	select 
		tr2.*
		, row_number() over(
			partition by track_id 
			order by track_id
		) as row_n
	from tr2
)
where
	row_n = 1
;

select 
	inv.*
	, ntile(4) over(order by total) as quantile
from inv_subset inv
;

select 
	inv.*
	, lag(total, 1, 0) over(
		partition by customer_id
		order by invoice_date
	) as prev_sum
	, lead(total, 1, 0) over(
		partition by customer_id
		order by invoice_date
	) as next_sum
	, first_value(total) over(
		partition by customer_id
		order by invoice_date
	) as first_sum
	, last_value(total) over(
		partition by customer_id
		order by invoice_date
		rows between unbounded preceding and unbounded following
	) as last_sum
	, first_value(total) over(
		partition by customer_id
		order by invoice_date desc
	) as last_sum2
	, nth_value(total, 3) over(
		partition by customer_id
		order by invoice_date
	) as third_invoice
from inv_subset inv
order by customer_id, invoice_date
;

select 
	inv.*
	, sum(total) over(
		order by invoice_date
		rows between unbounded preceding and current row
	) as running_total1
	, sum(total) over(
		order by invoice_date
		range between unbounded preceding and current row
	) as running_total2
from inv_subset inv