create view album_to_song AS
select
g.genre,
b.title,
m.name,
s.song
from mux.musician m, mux.song s, mux.genre g, mux.album b
where m.art_id = s.art_id
and b.album_id = s.album_id
and g.genre_id = s.genre_id
order by g.genre, b.title, s.song

select ats.genre, count(ats.genre)
from album_to_song ats
group by ats.genre
order by count(ats.genre) desc

select ats.name, count(ats.name)
from album_to_song ats
where ats.genre not like 'Books'
group by ats.name
order by count(ats.name) desc

select ats.title, count(ats.song)
from album_to_song ats
where ats.genre not like 'Books'
group by ats.title
order by ats.title