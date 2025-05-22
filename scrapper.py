import requests
from bs4 import BeautifulSoup
import psycopg2

# Connect to PostgreSQL
conn = psycopg2.connect(
    dbname="movies",
    user="melih",
    password="Ordu5052",
    host="localhost",
    port="5432"
)

# Create a cursor object
cursor = conn.cursor()


url = "https://www.imdb.com/chart/moviemeter/?ref_=nv_mv_mpm"
response = requests.get(url)
print(response.status_code)

if response.status_code == 200:
    print("Successfully fetched the page")
else:
    print("Failed to fetch the page. Using downloaded file.")
    with open("top_250_movies.html", "r") as file:
        response = file.read()

soup = BeautifulSoup(response, "html.parser")
print(soup.prettify())


counter = 0;
# Get the title, release year, rating of the movies
for movie in soup.find_all("li", class_="ipc-metadata-list-summary-item"):
    title = movie.find("h3", class_="ipc-title__text").text.strip()
    release_year = movie.find("span", class_="sc-4b408797-8 iurwGb cli-title-metadata-item").text.strip()
    rating = movie.find("span", class_="ipc-rating-star--rating")
    if rating and rating.text.strip():  # Check if rating_span is not None and has text
        rating = rating.text.strip()
    else:
        rating = "0.0"  # Assign NULL if no rating is found

    # Commit the data to the database
    cursor.execute("INSERT INTO movie (title, release_year, rating) VALUES (%s, %s, %s)", (title, release_year, rating))

    print(title, release_year, rating)
    counter += 1
print(counter)

# Commit the changes to the database
conn.commit()

# Display the data in the database
cursor.execute("SELECT * FROM movie")
results = cursor.fetchall()
for row in results:
    print(row)


