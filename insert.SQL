CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

ALTER TABLE "Movie" ALTER COLUMN "MovieID" SET DEFAULT uuid_generate_v4();
ALTER TABLE "Director" ALTER COLUMN "DirectorID" SET DEFAULT uuid_generate_v4();
ALTER TABLE "Actor" ALTER COLUMN "ActorID" SET DEFAULT uuid_generate_v4();
ALTER TABLE "University" ALTER COLUMN "UniID" SET DEFAULT uuid_generate_v4();
ALTER TABLE "Ticket" ALTER COLUMN "TicketID" SET DEFAULT uuid_generate_v4();
ALTER TABLE "Birth Location" ALTER COLUMN "BirthLocationID" SET DEFAULT uuid_generate_v4();

-- ---------------------------------------------------

Insert into "Movie" ("Title", "Duration", "ReleaseDate", "Rating", "Budget", "Gross") values 
('The Irishman', interval '209' minute, '2019-11-01', 7.8, 250000000.0, 8000000.0),
('Scent of a Woman', interval '156' minute, '1992-12-23', 8.0, 31000000.0, 134100000.0),
('The Departed', interval '151' minute, '2006-10-06', 8.5, 90000000.0, 291500000.0),
('Forrest Gump', interval '142' minute, '1994-07-06', 8.8, 55000000.0, 683100000.0),
('Casino', interval '178' minute, '1995-11-22', 8.2, 50000000.0, 116100000.0),
('Parasite', interval '132' minute, '2019-05-30', 8.6, 15500000.0, 259000000.0);

-- ---------------------------------------------------

Insert into "Award Category" ("CategoryName") values 
('Best Actor/Actress'), 
('Best Director'),
('Best Screenplay'),
('Best Cinematography'),
('Best Original Score');

-- ---------------------------------------------------

Insert into "Award" ("AwardName", "CategoryName") values
('Academy Awards', 'Best Actor/Actress'),
('Academy Awards', 'Best Director'),
('Golden Globes', 'Best Screenplay'),
('BMI Film & TV Awards', 'Best Original Score'),
('BAFTA Awards', 'Best Cinematography');

-- ---------------------------------------------------

Insert into "Movie Award" ("Date", "AwardName", "CategoryName", "MovieID") values
('1993-03-29', 'Academy Awards', 'Best Actor/Actress', (Select "MovieID" From "Movie" Where "Title" = 'Scent of a Woman')),
('1994-10-11', 'BMI Film & TV Awards', 'Best Original Score', (Select "MovieID" From "Movie" Where "Title" = 'Scent of a Woman')),
('1995-03-27', 'Academy Awards', 'Best Actor/Actress', (Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump')),
('1995-03-27', 'Academy Awards', 'Best Director', (Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump')),
('1995-03-27', 'Golden Globes', 'Best Screenplay', (Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump'));

-- ---------------------------------------------------

Insert into "Festival" ("FestivalName") values
('Venice Film Festival'),
('Sundance Film Festival'),
('Cannes Film Festival'),
('Berlin International Film Festival'),
('Toronto International Film Festival'),
('New York Film Festival');

-- ---------------------------------------------------

Insert into "Movie Festival" ("FestivalName", "MovieID", "Date") values
('Cannes Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'Parasite'), '2019-05-21'),
('New York Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), '2019-09-28'),
('Toronto International Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'Parasite'), '2019-09-16'),
('Toronto International Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'The Departed'), '2006-09-15'),
('Venice Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), '2019-09-07');

-- ---------------------------------------------------

Insert into "Genre" ("GenreName") values
('Crime'),
('Drama'),
('Romance'),
('Horror'),
('Adventure');

-- ---------------------------------------------------

Insert into "Movie Category" ("MovieID", "GenreName") values
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Crime'),
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Drama'),
((Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump'), 'Romance'),
((Select "MovieID" From "Movie" Where "Title" = 'Scent of a Woman'), 'Drama'),
((Select "MovieID" From "Movie" Where "Title" = 'Casino'), 'Crime'),
((Select "MovieID" From "Movie" Where "Title" = 'Casino'), 'Drama'),
((Select "MovieID" From "Movie" Where "Title" = 'The Departed'), 'Crime');

-- ---------------------------------------------------

Insert into "Cinema" ("CinemaName", "Location", "TypesOfHall") values
('Cineplex Cinemas', 'Yorkdale', 'cine-complex'),
('Cineplex Cinemas', 'Vaughan', 'cine-complex'),
('Cineplex Cinemas', 'Fairview Mall', 'cine-complex'),
('Cineplex Cinemas', 'Scarborough Town Centre', 'cine-complex'),
('Cineplex Cinemas', 'Yonge Eglinton Centre', 'cine-complex');

-- ---------------------------------------------------

Insert into "Ticket" ("MovieID", "CinemaName", "Location", "SeatNo", "Price", "DateTime", "Type") values
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Cineplex Cinemas', 'Yorkdale', 'A01', '20.0', '20191115 10:30:00 AM', 'VIP'),
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Cineplex Cinemas', 'Scarborough Town Centre', 'B11', '20.0', '20191111 05:30:00 PM', 'VIP'),
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Cineplex Cinemas', 'Vaughan', 'D03', '18.0', '20191115 07:30:00 PM', 'IMAX'),
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Cineplex Cinemas', 'Yorkdale', 'E01', '18.0', '20191115 11:00:00 AM', 'IMAX'),
((Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), 'Cineplex Cinemas', 'Yonge Eglinton Centre', 'C10', '19.0', '20191113 06:30:00 PM', 'VIP');

-- ---------------------------------------------------

Insert into "Birth Location" ("City", "State", "Country") values
('Toronto', 'Ontario', 'Canada'),
('Becancour', 'Quebec', 'Canada'),
('New York City', 'New York', 'United States'),
('Chicago', 'Illinois', 'United States'),
('Daegu', 'Yeongnam', 'South Korea'),
('Concord', 'California', 'United States'),
('Hollywood', 'California', 'United States'),
('Laleham', 'Middlesex', 'England'),
('Gimhae', 'South Gyeongsang', 'South Korea'),
('London', 'Ontario', 'Canada');

-- ---------------------------------------------------

Insert into "Director" ("BirthLocationID", "FirstName", "LastName", "DateOfBirth") values 
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Toronto' And "Country" = 'Canada'), 'David', 'Cronenberg', '1943-03-15'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Becancour' And "Country" = 'Canada'), 'Denis', 'Villeneuve', '1967-10-03'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'New York City' And "Country" = 'United States'), 'Martin', 'Scorsese', '1942-11-17'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Chicago' And "Country" = 'United States'), 'Robert', 'Zemeckis', '1951-05-14'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Daegu' And "Country" = 'South Korea'), 'Joon-ho', 'Bong', '1969-09-14');

-- ---------------------------------------------------

Insert into "Director Position" ("DirectorID", "MovieID") values
((Select "DirectorID" From "Director" Where "FirstName" = 'Martin'), (Select "MovieID" From "Movie" Where "Title" = 'Casino')),
((Select "DirectorID" From "Director" Where "FirstName" = 'Martin'), (Select "MovieID" From "Movie" Where "Title" = 'The Departed')),
((Select "DirectorID" From "Director" Where "FirstName" = 'Martin'), (Select "MovieID" From "Movie" Where "Title" = 'The Irishman')),
((Select "DirectorID" From "Director" Where "FirstName" = 'Robert'), (Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump')),
((Select "DirectorID" From "Director" Where "FirstName" = 'Joon-ho'), (Select "MovieID" From "Movie" Where "Title" = 'Parasite'));

-- ---------------------------------------------------

Insert into "Actor" ("BirthLocationID", "FirstName", "LastName", "DateOfBirth", "EyeColor") values
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Concord' And "Country" = 'United States'), 'Tom', 'Hanks', '1956-07-09', 'Green'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'New York City' And "Country" = 'United States'), 'Robert', 'De Niro', '1943-08-17', 'Brown'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Hollywood' And "Country" = 'United States'), 'Leonardo', 'DiCaprio', '1974-11-11', 'Blue'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'New York City' And "Country" = 'United States'), 'Al', 'Pacino', '1940-04-25', 'Blue'),
((Select "BirthLocationID" From "Birth Location" Where "City" = 'Gimhae' And "Country" = 'South Korea'), 'Kang-ho', 'Song', '1967-02-25', 'Brown');

-- ---------------------------------------------------

Insert into "Actor Position" ("ActorID", "MovieID") values
((Select "ActorID" From "Actor" Where "FirstName" = 'Al'), (Select "MovieID" From "Movie" Where "Title" = 'Scent of a Woman')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Leonardo'), (Select "MovieID" From "Movie" Where "Title" = 'The Departed')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Robert'), (Select "MovieID" From "Movie" Where "Title" = 'Casino')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Robert'), (Select "MovieID" From "Movie" Where "Title" = 'The Irishman')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Al'), (Select "MovieID" From "Movie" Where "Title" = 'The Irishman')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Tom'), (Select "MovieID" From "Movie" Where "Title" = 'Forrest Gump')),
((Select "ActorID" From "Actor" Where "FirstName" = 'Kang-ho'), (Select "MovieID" From "Movie" Where "Title" = 'Parasite'));

-- ---------------------------------------------------

Insert into "University" ("UniName", "Private", "UniTotalStudents", "RepresentativeColor") values
('New York University', TRUE, 52000, 'Purple'),
('Université du Québec à Montréal', FALSE, 44000, 'Blue'),
('University of Toronto', FALSE, 65000, 'Blue'),
('University of Southern California', TRUE, 50000, 'Cardinal'),
('University of California, Los Angeles', FALSE, 46000, 'Blue');

-- ---------------------------------------------------

Insert into "Department" ("DepartmentName", "UniID", "DepartmentTotalStudents") values
('Arts', (Select "UniID" From "University" Where "UniName" = 'New York University'), 5000),
('Cinema', (Select "UniID" From "University" Where "UniName" = 'Université du Québec à Montréal'), 2000),
('English', (Select "UniID" From "University" Where "UniName" = 'University of Toronto'), 4000),
('Fine Arts', (Select "UniID" From "University" Where "UniName" = 'University of Southern California'), 3000),
('Arts', (Select "UniID" From "University" Where "UniName" = 'University of California, Los Angeles'), 4000);
