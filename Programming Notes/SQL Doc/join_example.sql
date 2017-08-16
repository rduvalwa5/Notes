-- this is an inner join not writen as a join
-- in this join only data that meets the criteria is returned
select mux.album.title, mux.song.song from mux.song, mux.album
where mux.song.album_id = mux.album.album_id
and mux.album.title like 'Red Dirt Girl'

-- this is an inner join writen as a join
-- in this join only data that meets the criteria is returned
select mux.album.title, mux.song.song
from mux.song INNER JOIN mux.album
on mux.song.album_id = mux.album.album_id
where mux.album.title like 'Red Dirt Girl'

-- left or outer join retruns all records from the left table
-- regardless of matching criteria this way you still get all the records 
-- in left table

-- I need a better example of this

select mux.album.* from mux.album, mux.genre
where mux.album.genre_id = mux.genre.genre_id
-- and mux.genre.genre like 'ROCK'
and mux.album.art_id in 
(select mux.musician.art_id from mux.musician
 where (mux.musician.name like 'Emmylou Harris'
 or mux.musician.name like 'Mark Knopfler-Emmylou Harris'))

select mux.genre.genre,mux.album.title, mux.album.album_id,mux.album.genre_id 
from mux.genre left join mux.album
on mux.album.genre_id = mux.genre.genre_id
and (mux.genre.genre like 'ROCK' or mux.genre.genre like 'COUNTRY')
and mux.album.art_id in 
(select mux.musician.art_id from mux.musician
 where (mux.musician.name like 'Emmylou Harris'
 or mux.musician.name like 'Mark Knopfler-Emmylou Harris'))

-- right or outer join returns all records from the right table
-- regardless of matching criteria this way you still get all the records 
-- in right table

-- I need a better example of this

select mux.genre.genre,mux.album.title, mux.album.album_id,mux.album.genre_id  from mux.genre right join mux.album
on mux.album.genre_id = mux.genre.genre_id
-- and mux.genre.genre like 'ROCK'
and mux.album.art_id in 
(select mux.musician.art_id from mux.musician
 where (mux.musician.name like 'Emmylou Harris'
 or mux.musician.name like 'Mark Knopfler-Emmylou Harris'))

