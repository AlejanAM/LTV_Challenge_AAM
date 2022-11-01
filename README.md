# About this project

This project consists in a challenge for LTV FullStack Ruby Engineer.
To complete this project I had to use Ruby v2.6.6, MariaDB/MySQL as
database and Redis in memory database for background jobs.

# URL shortener

The logic used to solve the problem was entering a URL and the output is a short URL.
Based on the given  list ( [*'0'..'9', *'a'..'z', *'A'..'Z'] ) to generate a short
URL. When stonring the URL in MariaDB it generates an unique id, this id will serve
the purpose of being the shortcode, converting the id (Base 10) to the short code(Base 62).

The shortcode will redirect to the full URL from short code (Base 62) to id (Base 10) when
entering the short URL. By doing that it will access to MariaDB and search the full URL by
the recent conversion of the short code to id.

# Intial Setup

    docker-compose build
    docker-compose up mariadb
    # Once mariadb says it's ready for connections, you can use ctrl + c to stop it
    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml build

# To run migrations

    docker-compose run short-app rails db:migrate
    docker-compose -f docker-compose-test.yml run short-app-rspec rails db:test:prepare

# To run the specs

    docker-compose -f docker-compose-test.yml run short-app-rspec

# Run the web server

    docker-compose up

# Adding a URL

    curl -X POST -d "full_url=https://google.com" http://localhost:3000/short_urls.json

# Getting the top 100

    curl localhost:3000

# Checking your short URL redirect

    curl -I localhost:3000/abc
