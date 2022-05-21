/*
Created: 2021-10-05
Modified: 2021-10-27
Model: Movie Database
Database: PostgreSQL 12
*/

-- Create tables section -------------------------------------------------

-- Table Movie

CREATE TABLE "Movie"
(
  "MovieID" UUID NOT NULL,
  "Title" Character varying NOT NULL,
  "Duration" Interval MINUTE NOT NULL,
  "ReleaseDate" Date NOT NULL,
  "Rating" Double precision NOT NULL,
  "Budget" Money NOT NULL,
  "Gross" Money
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Movie" ADD CONSTRAINT "PK_Movie" PRIMARY KEY ("MovieID")
;

ALTER TABLE "Movie" ADD CONSTRAINT "MovieID" UNIQUE ("MovieID")
;

-- Table Birth Location

CREATE TABLE "Birth Location"
(
  "BirthLocationID" UUID NOT NULL,
  "City" Character varying NOT NULL,
  "State" Character varying NOT NULL,
  "Country" Character varying NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Birth Location" ADD CONSTRAINT "PK_Birth Location" PRIMARY KEY ("BirthLocationID")
;

ALTER TABLE "Birth Location" ADD CONSTRAINT "LocationID" UNIQUE ("BirthLocationID")
;

-- Table Genre

CREATE TABLE "Genre"
(
  "GenreName" Character varying NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Genre" ADD CONSTRAINT "PK_Genre" PRIMARY KEY ("GenreName")
;

ALTER TABLE "Genre" ADD CONSTRAINT "GenreName" UNIQUE ("GenreName")
;

-- Table University

CREATE TABLE "University"
(
  "UniID" UUID NOT NULL,
  "UniName" Character varying NOT NULL,
  "Location" Character varying,
  "Private" Boolean NOT NULL,
  "UniTotalStudents" Bigint NOT NULL,
  "RepresentativeColor" Character varying NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "University" ADD CONSTRAINT "PK_University" PRIMARY KEY ("UniID")
;

ALTER TABLE "University" ADD CONSTRAINT "UniID" UNIQUE ("UniID")
;

-- Table Department

CREATE TABLE "Department"
(
  "DepartmentName" Character varying NOT NULL,
  "UniID" UUID NOT NULL,
  "DepartmentTotalStudents" Bigint NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Department" ADD CONSTRAINT "PK_Department" PRIMARY KEY ("DepartmentName","UniID")
;

-- Table Movie Category

CREATE TABLE "Movie Category"
(
  "MovieID" UUID NOT NULL,
  "GenreName" Character varying NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Movie Category" ADD CONSTRAINT "PK_Movie Category" PRIMARY KEY ("MovieID","GenreName")
;

-- Table Director

CREATE TABLE "Director"
(
  "DirectorID" UUID NOT NULL,
  "BirthLocationID" UUID NOT NULL,
  "UniID" UUID,
  "DepartmentName" Character varying,
  "FirstName" Character varying NOT NULL,
  "LastName" Character varying NOT NULL,
  "DateOfBirth" Date NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX "IX_Relationship39" ON "Director" ("DepartmentName","UniID")
;

CREATE INDEX "IX_Relationship41" ON "Director" ("BirthLocationID")
;

ALTER TABLE "Director" ADD CONSTRAINT "PK_Director" PRIMARY KEY ("DirectorID")
;

ALTER TABLE "Director" ADD CONSTRAINT "DirectorID" UNIQUE ("DirectorID")
;

-- Table Actor

CREATE TABLE "Actor"
(
  "ActorID" UUID NOT NULL,
  "BirthLocationID" UUID NOT NULL,
  "UniID" UUID,
  "DepartmentName" Character varying,
  "FirstName" Character varying NOT NULL,
  "LastName" Character varying NOT NULL,
  "DateOfBirth" Date NOT NULL,
  "EyeColor" Character varying
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX "IX_Relationship40" ON "Actor" ("DepartmentName","UniID")
;

CREATE INDEX "IX_Relationship42" ON "Actor" ("BirthLocationID")
;

ALTER TABLE "Actor" ADD CONSTRAINT "PK_Actor" PRIMARY KEY ("ActorID")
;

ALTER TABLE "Actor" ADD CONSTRAINT "ActorID" UNIQUE ("ActorID")
;

-- Table Director Position

CREATE TABLE "Director Position"
(
  "DirectorID" UUID NOT NULL,
  "MovieID" UUID NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Director Position" ADD CONSTRAINT "PK_Director Position" PRIMARY KEY ("DirectorID","MovieID")
;

-- Table Actor Position

CREATE TABLE "Actor Position"
(
  "ActorID" UUID NOT NULL,
  "MovieID" UUID NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Actor Position" ADD CONSTRAINT "PK_Actor Position" PRIMARY KEY ("ActorID","MovieID")
;

-- Table Ticket

CREATE TABLE "Ticket"
(
  "TicketID" UUID NOT NULL,
  "MovieID" UUID NOT NULL,
  "CinemaName" Character varying NOT NULL,
  "Location" Character varying NOT NULL,
  "SeatNo" Character varying NOT NULL,
  "Price" Money NOT NULL,
  "DateTime" Timestamp with time zone NOT NULL,
  "Type" Character varying NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Ticket" ADD CONSTRAINT "PK_Ticket" PRIMARY KEY ("TicketID","MovieID","CinemaName","Location")
;

ALTER TABLE "Ticket" ADD CONSTRAINT "TicketID" UNIQUE ("TicketID")
;

-- Table Cinema

CREATE TABLE "Cinema"
(
  "CinemaName" Character varying NOT NULL,
  "Location" Character varying NOT NULL,
  "TypesOfHall" Character varying NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Cinema" ADD CONSTRAINT "PK_Cinema" PRIMARY KEY ("CinemaName","Location")
;

-- Table Award

CREATE TABLE "Award"
(
  "AwardName" Character varying NOT NULL,
  "CategoryName" Character varying NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Award" ADD CONSTRAINT "PK_Award" PRIMARY KEY ("AwardName","CategoryName")
;

-- Table Award Category

CREATE TABLE "Award Category"
(
  "CategoryName" Character varying NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Award Category" ADD CONSTRAINT "PK_Award Category" PRIMARY KEY ("CategoryName")
;

ALTER TABLE "Award Category" ADD CONSTRAINT "CategoryName" UNIQUE ("CategoryName")
;

-- Table Movie Award

CREATE TABLE "Movie Award"
(
  "Date" Date NOT NULL,
  "AwardName" Character varying NOT NULL,
  "CategoryName" Character varying NOT NULL,
  "MovieID" UUID NOT NULL
)
WITH (
  autovacuum_enabled=true)
;

CREATE INDEX "IX_Relationship48" ON "Movie Award" ("MovieID")
;

ALTER TABLE "Movie Award" ADD CONSTRAINT "PK_Movie Award" PRIMARY KEY ("AwardName","CategoryName","Date")
;

-- Table Festival

CREATE TABLE "Festival"
(
  "FestivalName" Character varying NOT NULL,
  "Description" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Festival" ADD CONSTRAINT "PK_Festival" PRIMARY KEY ("FestivalName")
;

ALTER TABLE "Festival" ADD CONSTRAINT "FestivalName" UNIQUE ("FestivalName")
;

-- Table Movie Festival

CREATE TABLE "Movie Festival"
(
  "FestivalName" Character varying NOT NULL,
  "MovieID" UUID NOT NULL,
  "Date" Date NOT NULL,
  "Location" Character varying
)
WITH (
  autovacuum_enabled=true)
;

ALTER TABLE "Movie Festival" ADD CONSTRAINT "PK_Movie Festival" PRIMARY KEY ("FestivalName","MovieID")
;

-- Create foreign keys (relationships) section -------------------------------------------------

ALTER TABLE "Movie Category"
  ADD CONSTRAINT "belongs to"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Movie Category"
  ADD CONSTRAINT "categorized in"
    FOREIGN KEY ("GenreName")
    REFERENCES "Genre" ("GenreName")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Department"
  ADD CONSTRAINT "contains"
    FOREIGN KEY ("UniID")
    REFERENCES "University" ("UniID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Director Position"
  ADD CONSTRAINT "directs"
    FOREIGN KEY ("DirectorID")
    REFERENCES "Director" ("DirectorID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Director Position"
  ADD CONSTRAINT "directed by"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Actor Position"
  ADD CONSTRAINT "acts in"
    FOREIGN KEY ("ActorID")
    REFERENCES "Actor" ("ActorID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Actor Position"
  ADD CONSTRAINT "acted by"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Director"
  ADD CONSTRAINT "graduated from"
    FOREIGN KEY ("DepartmentName", "UniID")
    REFERENCES "Department" ("DepartmentName", "UniID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Actor"
  ADD CONSTRAINT "graduated from"
    FOREIGN KEY ("DepartmentName", "UniID")
    REFERENCES "Department" ("DepartmentName", "UniID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Director"
  ADD CONSTRAINT "born in"
    FOREIGN KEY ("BirthLocationID")
    REFERENCES "Birth Location" ("BirthLocationID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Actor"
  ADD CONSTRAINT "born in"
    FOREIGN KEY ("BirthLocationID")
    REFERENCES "Birth Location" ("BirthLocationID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Ticket"
  ADD CONSTRAINT "associated to"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Ticket"
  ADD CONSTRAINT "sells"
    FOREIGN KEY ("CinemaName", "Location")
    REFERENCES "Cinema" ("CinemaName", "Location")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Movie Award"
  ADD CONSTRAINT "goes to"
    FOREIGN KEY ("AwardName", "CategoryName")
    REFERENCES "Award" ("AwardName", "CategoryName")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Movie Award"
  ADD CONSTRAINT "wins"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Movie Festival"
  ADD CONSTRAINT "belongs to"
    FOREIGN KEY ("FestivalName")
    REFERENCES "Festival" ("FestivalName")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Movie Festival"
  ADD CONSTRAINT "played in"
    FOREIGN KEY ("MovieID")
    REFERENCES "Movie" ("MovieID")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

ALTER TABLE "Award"
  ADD CONSTRAINT "categorized in"
    FOREIGN KEY ("CategoryName")
    REFERENCES "Award Category" ("CategoryName")
      ON DELETE NO ACTION
      ON UPDATE NO ACTION
;

