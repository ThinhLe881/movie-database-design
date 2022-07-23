-- List all directors who were born in Canada.
Select "FirstName", "LastName", "Country" From "Director"
Inner Join "Birth Location" On "Director"."BirthLocationID" = "Birth Location"."BirthLocationID"
Where "Country" = 'Canada';

-- Which movies are directed by Martin Scorsese?
Select "Title", "FirstName", "LastName" From "Director Position"
Inner Join "Movie" On "Director Position"."MovieID" = "Movie"."MovieID"
Inner Join "Director" On "Director Position"."DirectorID" = "Director"."DirectorID"
Where "FirstName" = 'Martin' And "LastName" = 'Scorsese';

-- List all the actors who played in the movies for which cost of production was more than $50M. Compute cost in other currencies:
Select "FirstName", "LastName", "Title", "Budget" As "Budget_USD", ("Budget" * 1.25) As "Budget_CAD", ("Budget" * 113.54) As "Budget_JPY",
("Budget" * 71.47) As "Budget_RUB", ("Budget" * 0.87) As "Budget_EUR", ("Budget" * 0.91) As "Budget_CHF" 
From "Actor Position"
Inner Join "Actor" On "Actor Position"."ActorID" = "Actor"."ActorID"
Inner Join "Movie" On "Actor Position"."MovieID" = "Movie"."MovieID"
Where "Budget" > Money(50000000.0)

-- Using operator LIKE find all the directors whose surname start with letter “S” and “V”.
Select "FirstName", "LastName" from "Director"
Where "LastName" Like 'S%' Or "LastName" Like 'V%';

-- Find all the drama movies in which there is a playing actor who is less than 60 (age).
Select Distinct "Title"
From "Movie"
Inner Join "Movie Category" On "Movie Category"."MovieID" = "Movie"."MovieID"
Inner Join "Actor Position" On "Actor Position"."MovieID" = "Movie"."MovieID"
Where "GenreName" = 'Drama'
And "ActorID" In (Select "ActorID" From "Actor" Where Extract(Year From(Age("DateOfBirth"))) < 60)

-- Find all the pairs of actors who have blue eye color. Produce pairs in alphabetic order.
Select A1."LastName", A2."LastName"
From "Actor" A1, "Actor" A2
Where A1."EyeColor" = 'Blue' And A2."EyeColor" = 'Blue'
And A1."LastName" < A2."LastName"

-- From table Actors find the average age.
Select Avg(Extract(Year From(Age("DateOfBirth"))))
From "Actor"

-- Find the number of different countries in which actors from the movie “Scent of a Woman” were born.
Select Count(Distinct "Country")
From "Actor"
Inner Join "Actor Position" On "Actor"."ActorID" = "Actor Position"."ActorID"
Inner Join "Birth Location" On "Actor"."BirthLocationID" = "Birth Location"."BirthLocationID"
Where "MovieID" = (Select "MovieID" From "Movie" Where "Title" = 'Scent of a Woman')

-- Find the number of actors with blue eye color.
Select Count(*)
From "Actor"
Where "EyeColor" = 'Blue'

-- What is the number of movies in which Al Pacino was playing?
Select Count(*)
From "Actor Position"
Inner Join "Actor" On "Actor"."ActorID" = "Actor Position"."ActorID"
Where "FirstName" = 'Al' And "LastName" = 'Pacino'

-- Find the minimum, average and maximum budget for each type of movie.
Select "GenreName", Money(Min(Cast("Budget" As decimal))) As "MinBudget", Money(Avg(Cast("Budget" As decimal))) As "AvgBudget", Money(Max(Cast("Budget" As decimal))) As "MaxBudget"
From "Movie"
Inner Join "Movie Category" On "Movie"."MovieID" = "Movie Category"."MovieID"
Group by "GenreName"

-- Find the average rating for each movie which has director born in New York City or blue eye color.
Select Avg("Rating")
From "Actor Position"
Inner Join "Actor" On "Actor Position"."ActorID" = "Actor"."ActorID"
Inner Join "Movie" On "Actor Position"."MovieID" = "Movie"."MovieID"
Where "BirthLocationID" = (Select "BirthLocationID" From "Birth Location" Where "City" = 'New York City') 
Or "EyeColor" = 'Blue'

-- Find all the movies that have actors born in at least two different countries.
-- 1st way:
Select "Title"
From "Movie"
Where "MovieID" In (
	Select Distinct AP1."MovieID"
	From "Actor" A1, "Actor" A2, "Birth Location" AB1, "Birth Location" AB2, "Actor Position" AP1, "Actor Position" AP2
	Where A1."BirthLocationID" = AB1."BirthLocationID"
	And A2."BirthLocationID" = AB2."BirthLocationID"
	And AB1."Country" != AB2."Country"
	And A1."ActorID" = AP1."ActorID"
	And A2."ActorID" = AP2."ActorID"
	And AP1."MovieID" = AP2."MovieID")

-- 2nd way: (better)
Select "Title"
From "Movie"
Where "MovieID" In (
	Select "MovieID"
	From (
		Select "MovieID", Count(Distinct "Country") As "Countries"
		From "Actor"
		Inner Join "Birth Location" On "Actor"."BirthLocationID" = "Birth Location"."BirthLocationID"
		Inner Join "Actor Position" On "Actor"."ActorID" = "Actor Position"."ActorID"
		Group By "MovieID"
	) As A
	Where A."Countries" >= 2)

-- Find how many awards each movie in total has received and rank the movies (display the title) by the amount of awards.
Select "Title", Count("Movie Award"."MovieID") As "Awards"
From "Movie"
Left Join "Movie Award" On "Movie"."MovieID" = "Movie Award"."MovieID"
Group By "Title"
Order By "Awards" DESC