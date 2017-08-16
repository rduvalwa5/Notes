update mux.album b
set b.media_id = (select media_id from mux.original_media
 where media_type = 'vinyl')
where b.art_id in 
(
select art_id from musician m
where m.name in
('Joan Baez','Beatles','Joe Cocker','Dvorak','Alabama',
'Charlie Rich','Hank Williams','Jimmy Buffet','Johnny Cash',
'BillieHoliday','Leon Russel','Marty Robbins','Nitty Gritty Dirt Band',
'Walyn Jennings','Willie Nelson','Arlo Gutherie','Bob Dylan',
'Harry Belafonte','Judy Collins','Leo Kottke','Melanie','Simon & Garfunkel'
'Steve Goodman','Woody Gutherie','Brecker Brothers','Jean Pierre Rampal',
'John Coltrane','Lara Nyro','Less McCann and Eddie Harris',
'Michael Brecker','Nat King Cole','Roberta Flack','The Jazz Crusaders',
'Thelonious Monk','Weather Report','Allman Brothers Band',
'Alvin Lee,','Bach Turner Overdrive','Beach Boys','BeeGees','Billy Joel',
'Blood Sweat & Tears','Bruce Springsteen','Chicago','Chuck Berry',
'Dionne Warwicke','Doobie Brothers','Doors','Eagles','Electric Light Orchestra',
'Jimi Hendrix','Lennon','Leo Sayer','Lovin Spoonful','Lynyrd Skynyrd',
'Moody Blues','Pete Townsend','Peter & Gordon','Pointer Sisters','Talking heads',
'Three Dog Night','Tina Turner','Traffic','Union Gap','Leo Ferre',
'Manitas de Plata','Maria Ostiz'))

update mux.album b
set b.media_id = 
(select media_id from mux.original_media
 where media_type = 'CD')
where b.art_id in 
(select art_id from musician m
 where m.name in 
('Anita Baker',	   
'Eric Clapton & B.B. King',	   
'John Mayall',
'Muddy Waters',	   
'Norah Jones',	   
'R.L. Burnside',	   
'Ray Charles',	   
'C. S. Forester',	   
'Isaac Asimov',   
'Patrick O''Brian',   
'Sean Naylor',	   
'Simon Winchester',	   
'Stephen King',	   
'Emmylou Harris',	   
'Kris Kristofferson',	   
'Linda Ronstadt',	   
'Mark O''Connor',	   
'Michael Martin Murphey',	   
'Rebba McEntire',   
'Rita Coolidge',	   
'The Infamous Srirngdusters',	   
'Tim O''Brien',   
'Uncle Earl',	   
'Various Artists',
'Barry McGuire',	   
'Bob Seger & the Silver Bullet Band',	   
'Dylan Compilations',
'John Prine',
'The Chieftains',	   
'The Kingston Trio',	   
'Vienna Teng',	   
'Walela',	   
'Al Cohn & Zoot Sims',	   
'Antonio Hart',	   
'Charlie Parker',	   
'Charlie Parker & Dizzy Gillespie',	   
'Chick Corea',	   
'Dave Brubeck Quartet',	   
'Devin Duval',	   
'Frank Sinatra',	   
'Gerald Albright',	   
'Grover Washington, Jr',	   
'Jelly Roll Morton',	   
'Jerry Bergonzi',	   
'Joe Louis Walker',	   
'John Scofield',	   
'Keith Jarrett',	   
'Keith Jarrett Trio',	   
'Kenny G',	   
'Kenny Garrett',	   
'Louis Armstrong',	   
'Mark OConnor-Ma-Marsalis-Taylor',	   
'Mark Taylor',	   
'Mark Turner',	   
'Miles Davis',	   
'Oscar Peterson Trio',	   
'Ottmar Liebert',	   
'Ottmar Liebert + Luna Negra',	   
'Pat Metheny',	   
'Pat Metheny Trio',	   
'Sonny Rollins',	   
'Stan Getz-Charlie Byrd',	   
'The Rat Pack',	   
'Tower of Power',	   
'Wayne Shorter',	   
'Aretha Franklin',	   
'Blue Oyster Cult',	   
'Buffalo Springfield',	   
'Carole King',   
'Celine Dion',	   
'Cream',	   
'Elton John',	   
'Eric Clapton',	   
'Fleetwood Mac',	   
'Frank Zappa',	   
'Janis Joplin',	   
'Jim Croce',	   
'Led Zeppelin',	   
'Mark Knopfler-Emmylou Harris',	   
'Meat Loaf',	   
'Metallica',	   
'Nirvana',	   
'Paul McCartney & Wings',	   
'Pink Floyd',
'Righteous Brothers',	   
'Roy Orbison',	   
'Steppenwolf',	   
'Steve Miller Band',	   
'Stills & Nash (And Young) Crosby',	   
'Stray Cats',	   
'The Animals',	   
'The Band',	   
'The Byrds',	   
'The Grateful Dead',	   
'The Guess Who',	   
'The Rolling Stones',	   
'The Traveling Wilburys',	   
'Them',
'Tom Petty & the Heartbreakers',	   
'War',
'Yes'))

select * from album
where album.media_id is null

select original_media.media_type, count(song.song)
from album, song,original_media
where album.media_id = original_media.media_id
and album.album_id = song.album_id
group by original_media.media_type
order by count(song.song) desc

