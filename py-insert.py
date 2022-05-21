from datetime import timedelta
import psycopg2
import pandas as pd

conn = psycopg2.connect(
    host="localhost",
    database="Movies",
    user="postgres",
    port="5432",
    password="123456",
)

cur = conn.cursor()


def select_query(sub_query_1, sub_query_2, sub_query_3=None):
    query = f"""Select {sub_query_1} From {sub_query_2}"""

    if sub_query_3 != None:
        query += f"""Where {sub_query_3}"""

    return query


def insert_query(sub_query_1, sub_query_2, sub_query_3):
    query = f"""Insert into {sub_query_1} ({sub_query_2}) values ({sub_query_3})"""

    return query


# Insert
'''
query = """Insert into "Movie" ("Title", "Duration", "ReleaseDate", "Rating", "Budget", "Gross") values ('Hugo', interval '126' minute, '2011-11-23', 7.5, 170000000.0, 185800000.0)"""

cur.execute(query)

query = insert_query(
    """ "Movie" """,
    """ "Title", "Duration", "ReleaseDate", "Rating", "Budget", "Gross" """,
    """ 'The Nice Guys', interval '116' minute, '2016-05-20', 7.4, 50000000, 62800000""",
)

cur.execute(query)
'''

'''
query = """Insert into "Birth Location" ("City", "State", "Country") values ('Pittsburgh', 'Pennsylvania', 'United States')"""

cur.execute(query)

query = insert_query(
    """ "Birth Location" """,
    """ "City", "State", "Country" """,
    """ 'Bombay', 'Maharashtra', 'India' """,
)

cur.execute(query)
'''

'''
query = """Insert into "Actor" ("BirthLocationID", "FirstName", "LastName", "DateOfBirth", "EyeColor") values ((Select "BirthLocationID" From "Birth Location" Where "City" = 'London' And "Country" = 'Canada'), 'Ryan', 'Gosling', '1980-11-12', 'Blue')"""

cur.execute(query)

sub_query = select_query(
    """ "BirthLocationID" """,
    """ "Birth Location" """,
    """ "City" = 'Laleham' And "Country" = 'England' """,
)

query = insert_query(
    """ "Actor" """,
    """ "BirthLocationID", "FirstName", "LastName", "DateOfBirth", "EyeColor" """,
    f""" ({sub_query}), 'Gabrielle', 'Anwar', '1970-02-04', 'Grey' """,
)

cur.execute(query)
'''


query = """Insert into "Actor Position" ("ActorID", "MovieID") values ((Select "ActorID" From "Actor" Where "FirstName" = 'Ryan'), (Select "MovieID" From "Movie" Where "Title" = 'The Nice Guys'))"""

cur.execute(query)

sub_query_1 = select_query(
    """ "ActorID" """, """ "Actor" """, """ "FirstName" = 'Gabrielle' """
)

sub_query_2 = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'Scent of a Woman' """
)

query = insert_query(
    """ "Actor Position" """,
    """ "ActorID", "MovieID" """,
    f"""({sub_query_1}), ({sub_query_2})""",
)

cur.execute(query)


'''
query = """Insert into "Director" ("BirthLocationID", "FirstName", "LastName", "DateOfBirth") values ((Select "BirthLocationID" From "Birth Location" Where "City" = 'Pittsburgh' And "Country" = 'United States'), 'Shane', 'Black', '1961-12-16')"""

cur.execute(query)

sub_query = select_query(
    """ "BirthLocationID" """,
    """ "Birth Location" """,
    """ "City" = 'Bombay' And "Country" = 'India' """,
)

query = insert_query(
    """ "Director" """,
    """ "BirthLocationID", "FirstName", "LastName", "DateOfBirth" """,
    f""" ({sub_query}), 'Aamir', 'Khan', '1965-03-14' """,
)

cur.execute(query)
'''

'''
query = """Insert into "Director Position" ("DirectorID", "MovieID") values ((Select "DirectorID" From "Director" Where "FirstName" = 'Martin'), (Select "MovieID" From "Movie" Where "Title" = 'Hugo'))"""

cur.execute(query)

sub_query_1 = select_query(
    """ "DirectorID" """, """ "Director" """, """ "FirstName" = 'Shane' """
)
sub_query_2 = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'The Nice Guys' """
)

query = insert_query(
    """ "Director Position" """,
    """ "DirectorID", "MovieID" """,
    f"""({sub_query_1}), ({sub_query_2})""",
)

cur.execute(query)
'''

'''
query = (
    """Insert into "Award Category" ("CategoryName") values ('Best Visual Effects')"""
)

cur.execute(query)

query = insert_query(
    """ "Award Category" """, """ "CategoryName" """, """ 'Best Film Editing' """
)

cur.execute(query)
'''

'''
query = """Insert into "Award" ("AwardName", "CategoryName") values ('Academy Awards', 'Best Visual Effects')"""

cur.execute(query)

query = insert_query(
    """ "Award" """,
    """ "AwardName", "CategoryName" """,
    """ 'Academy Awards', 'Best Film Editing' """,
)

cur.execute(query)
'''

'''
query = """Insert into "Movie Award" ("Date", "AwardName", "CategoryName", "MovieID") values ('2012-02-26', 'Academy Awards', 'Best Visual Effects', (Select "MovieID" From "Movie" Where "Title" = 'Hugo'))"""

cur.execute(query)

sub_query = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'The Departed' """
)

query = insert_query(
    """ "Movie Award" """,
    """ "Date", "AwardName", "CategoryName", "MovieID" """,
    f""" '2007-02-25', 'Academy Awards', 'Best Film Editing', ({sub_query}) """,
)

cur.execute(query)
'''

'''
query = """Insert into "Festival" ("FestivalName") values ('San Francisco International Film Festival')"""

cur.execute(query)

query = insert_query(
    """ "Festival" """, """ "FestivalName" """, """ 'New York Film Festival' """
)

cur.execute(query)
'''

'''
query = """Insert into "Movie Festival" ("FestivalName", "MovieID", "Date") values ('Toronto International Film Festival', (Select "MovieID" From "Movie" Where "Title" = 'The Irishman'), '2019-09-16')"""

cur.execute(query)

sub_query = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'Hugo' """)

query = insert_query(
    """ "Movie Festival" """,
    """ "FestivalName", "MovieID", "Date" """,
    f""" 'New York Film Festival', ({sub_query}), '2011-10-10' """,
)

cur.execute(query)
'''

'''
query = """Insert into "Genre" ("GenreName") values ('Comedy')"""

cur.execute(query)

query = insert_query(
    """ "Genre" """,
    """ "GenreName" """,
    f""" 'Family' """,
)

cur.execute(query)
'''

'''
query = """ Insert into "Movie Category" ("MovieID", "GenreName") values ((Select "MovieID" From "Movie" Where "Title" = 'The Departed'), 'Drama') """

cur.execute(query)

sub_query = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'Parasite' """
)

query = insert_query(
    """ "Movie Category" """,
    """ "MovieID", "GenreName" """,
    f""" ({sub_query}), 'Drama' """,
)

cur.execute(query)
'''

'''
query = """Insert into "Cinema" ("CinemaName", "Location", "TypesOfHall") values ('Cineplex Cinemas', 'Yonge Dundas Centre', 'cine-complex') """

cur.execute(query)

query = insert_query(
    """ "Cinema" """,
    """ "CinemaName", "Location", "TypesOfHall" """,
    """ 'Cineplex Cinemas', 'Scotiabank Theatre Toronto', 'cine-complex' """,
)

cur.execute(query)
'''

'''
query = """ Insert into "Ticket" ("MovieID", "CinemaName", "Location", "SeatNo", "Price", "DateTime", "Type") values ((Select "MovieID" From "Movie" Where "Title" = 'Parasite'), 'Cineplex Cinemas', 'Yonge Dundas Centre', 'D04', '18.0', '20191115 07:30:00 PM', 'IMAX') """

cur.execute(query)

sub_query = select_query(
    """ "MovieID" """, """ "Movie" """, """ "Title" = 'Parasite' """
)

query = insert_query(
    """ "Ticket" """,
    """ "MovieID", "CinemaName", "Location", "SeatNo", "Price", "DateTime", "Type" """,
    f""" ({sub_query}), 'Cineplex Cinemas', 'Scotiabank Theatre Toronto', 'D04', '19.0', '20191115 07:30:00 PM', 'VIP' """,
)

cur.execute(query)
'''

'''
query = """Insert into "University" ("UniName", "Private", "UniTotalStudents", "RepresentativeColor") values ('California State University, Sacramento', FALSE, 32000, 'Green') """

cur.execute(query)

query = insert_query(
    """ "University" """,
    """ "UniName", "Private", "UniTotalStudents", "RepresentativeColor" """,
    """ 'Newcastle University', FALSE, 28000, 'Sky Blue' """,
)

cur.execute(query)
'''

'''
query = """ Insert into "Department" ("DepartmentName", "UniID", "DepartmentTotalStudents") values ('Engineering', (Select "UniID" From "University" Where "UniName" = 'Newcastle University'), 3000) """

cur.execute(query)

sub_query = select_query(
    """ "UniID" """,
    """ "University" """,
    """ "UniName" = 'California State University, Sacramento' """,
)

query = insert_query(
    """ "Department" """,
    """ "DepartmentName", "UniID", "DepartmentTotalStudents" """,
    f""" 'Theater', ({sub_query}), 3000""",
)

cur.execute(query)
'''

conn.commit()
