# Creating a basic [Rails](https://github.com/rails/rails) app using [PostgreSQL](https://www.postgresql.org/) in a [Docker](https://www.docker.com/) container

## Motivation ##
I am working on several web apps using different technologies. One thing I really don't like to do is installing everything I need on my machine. I prefer to keep my machine as clean as possible. Therefore I was asking myself how to set up a [**Rails**](https://github.com/rails/rails) project using a different database than [**SQLite**](https://www.sqlite.org/). So I decided to set up a [**Rails**](https://github.com/rails/rails) project following Daniela Baron's blog post [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) which is pretty much the technology we are using in my current team as well.

## Getting started ##
As I was not able to set up a connection to the [**PostgreSQL**](https://www.postgresql.org/) inside the [**Docker**](https://www.docker.com/) container I thought I had to install the [**PostgreSQL**](https://www.postgresql.org/) client on my machine. As I am using [**homebrew**](https://brew.sh/) setting this up was pretty straight forward:

```bash
brew install postgresql
```

The next step would be creating the basic application structure of our [**Rails**](https://github.com/rails/rails) application. Please note that you have to specify which database you want to use. In our case it is  [**PostgreSQL**](https://www.postgresql.org/). You can set it up like this:

```bash
rails new rails_blog_pg --database=postgresql
```

## Links
- [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) - The blogpost that I worked through in order to understand how this works
- [**Rails**](https://github.com/rails/rails) - The framework used to create the blog
- [**PostgreSQL**](https://www.postgresql.org/) - The database used in this example
- [**Docker**](https://www.docker.com/) - The container technology used because I didn't want to install and run [**PostgreSQL**](https://www.postgresql.org/) locally on my computer
