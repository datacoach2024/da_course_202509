select avg(milliseconds)
from track
;

select
	track_id
	, milliseconds
from track
where
	milliseconds > (select avg(milliseconds) from track)
order by milliseconds
;

select *
from track
where
	genre_id in (
		select genre_id
		from genre
		where
			name ilike '%r%'
	)
;

select *
from (
	select
		track_id
		, round(bytes/1024.0/1024.0, 0) as size_mb
	from track
	where
		composer = 'Queen'
)
where
	size_mb > 2
;

-- рассчитайте среднее количество треков на жанр
select floor(avg(cnt))
from (
	select
		genre_id
		, count(track_id) as cnt
	from track
	group by genre_id
)
;

select
	invoice_id
	, billing_country
	, total
	, (
		select round(avg(total), 2)
		from invoice i2
		where
			i2.billing_country = i1.billing_country
	) as country_avg
from invoice i1
;

select
	track_id
	, name as track_name
	, round(milliseconds/60000.0, 2) as duration_minutes
from track
where
	track_id in (
		select track_id
		from playlist_track
		where
			playlist_id in (
				select playlist_id
				from playlist
				where
					name ilike '%classic%'
			)
	)
	and track_id in (
		select track_id
		from invoice_line
		group by track_id
		having sum(quantity)>1
	)
;

with
classics as (
	select playlist_id
	from playlist 
	where
		name ilike '%classic%'
)
, classic_tracks as (
	select track_id
	from playlist_track
	where
		playlist_id in (select playlist_id from classics)
)
, hot_tracks as (
	select track_id
	from invoice_line
	group by track_id
	having sum(quantity) > 1
)
select 
	track_id
	, name as track_name
	, round(milliseconds/60000.0, 2) as duration_minutes
from track
where
	track_id in (select track_id from classic_tracks)
	and track_id in (select track_id from hot_tracks)
;

-- посчитайте среднюю длину названий треков относящихся к альбомам
-- чьи названия содержат слово "Rock"

-- 1
select floor(avg(length(name))) as mean_name_length
from track
where
	album_id in (
		select album_id
		from album
		where
			title ilike '%rock%'
	)
;

-- 2
with
rock_albums as (
	select album_id
	from album a 
	where
		title ilike '%r%'
)
select 
	floor(avg(length(name))) as mean_name_len
from track
where
	album_id in (select album_id from rock_albums)
;