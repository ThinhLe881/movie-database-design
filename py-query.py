from datetime import timedelta
import psycopg2
import pandas as pd

conn = psycopg2.connect(
    host="localhost",
    database="Movies",
    user="postgres",
    port="5432",
    password="123",
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


# Query:

query = """Select "Title", Count("Movie Award"."MovieID") As "Awards"
    From "Movie"
    Left Join "Movie Award" On "Movie"."MovieID" = "Movie Award"."MovieID"
    Group By "Title"
    Order By "Awards" DESC"""

cur.execute(query)
result = cur.fetchall()

data = [list(t) for t in result]
headers = ["Title", "Awards"]
df = pd.DataFrame(data, columns=headers)

# #############################################################################

sub_query = f"""Select "MovieID"
	From (
		Select "MovieID", Count(Distinct "Country") As "Countries"
		From "Actor"
		Inner Join "Birth Location" On "Actor"."BirthLocationID" = "Birth Location"."BirthLocationID"
		Inner Join "Actor Position" On "Actor"."ActorID" = "Actor Position"."ActorID"
		Group By "MovieID"
	) As A
	Where A."Countries" >= 2"""

query = f"""Select "Title"
    From "Movie"
    Where "MovieID" In ({sub_query})"""

cur.execute(query)
result = cur.fetchall()

data = [list(t) for t in result]
headers = ["Title"]
df = pd.DataFrame(data, columns=headers)

# #############################################################################

sub_query_1 = f""" "FirstName", "LastName", "Country" """
sub_query_2 = f""" "Director" """
sub_query_3 = f""" "Country" """
sub_query_4 = f""" 'Canada' """

query = f"""Select {sub_query_1} From {sub_query_2}
Inner Join "Birth Location" On "Director"."BirthLocationID" = "Birth Location"."BirthLocationID"
Where {sub_query_3} = {sub_query_4}"""

cur.execute(query)
result = cur.fetchall()

data = [list(t) for t in result]
headers = ["FirstName", "LastName", "Country"]
df = pd.DataFrame(data, columns=headers)

# #############################################################################

sub_query_1 = f""" "FirstName", "LastName" """
sub_query_2 = f""" "Director" """
sub_query_3 = f""" "LastName" """
sub_query_4 = f""" 'S%' """
sub_query_5 = f""" "LastName" """
sub_query_6 = f""" 'V%' """

query = f"""Select {sub_query_1} from {sub_query_2}
Where {sub_query_3} Like {sub_query_4} Or {sub_query_5} Like {sub_query_6};"""

cur.execute(query)
result = cur.fetchall()

data = [list(t) for t in result]
headers = ["FirstName", "LastName"]
df = pd.DataFrame(data, columns=headers)


print(df)
