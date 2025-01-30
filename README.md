# Creating a basic [Rails](https://github.com/rails/rails) app using [PostgreSQL](https://www.postgresql.org/) in a [Docker](https://www.docker.com/) container

## Motivation ##
I am working on several web apps using different technologies. One thing I really don't like to do is installing everything I need on my machine. I prefer to keep my machine as clean as possible. Therefore I was asking myself how to set up a [**Rails**](https://github.com/rails/rails) project using a different database than [**SQLite**](https://www.sqlite.org/). So I decided to set up a [**Rails**](https://github.com/rails/rails) project following Daniela Baron's blog post [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) which is pretty much the technology we are using in my current team as well.

## Links
- [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) - The blogpost that I worked through in order to understand how this works
- [**Rails**](https://github.com/rails/rails) - The framework used to create the blog
- [**PostgreSQL**](https://www.postgresql.org/) - The database used in this example
- [**Docker**](https://www.docker.com/) - The container technology used because I didn't want to install and run [**PostgreSQL**](https://www.postgresql.org/) locally on my computer
