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

## Configurating the Rails Database Connection ##
By executing the command

```bash
rails new rails_blog_pg --database=postgresql
```

a new rails appliciation is creating using [**PostgreSQL**](https://www.postgresql.org/) as a database:

```yml
# config/database.yml
default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
development:
  <<: *default
  database: blogpg_development
test:
  <<: *default
  database: blogpg_test
production:
  <<: *default
  database: blogpg_production
  username: blogpg
  password: <%= ENV['BLOGPG_DATABASE_PASSWORD'] %>
```

 But there are some challenges we need to overcome. In order to be able to use our [**PostgreSQL**](https://www.postgresql.org/) database inside [**Docker**](https://www.docker.com/) we need to set up some additional data inside our **database.yml** configuration:

 ```yml
 default: &default
  adapter: postgresql
  encoding: unicode
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  database: <%= ENV['DATABASE_NAME'] || "blogpg" %>
  username: <%= ENV['DATABASE_USER'] || "blogpg" %>
  password: <%= ENV['DATABASE_PASSWORD'] || "blogpg" %>
  port: <%= ENV['DATABASE_PORT'] || "5432" %>
  host: <%= ENV['DATABASE_HOST'] || "127.0.0.1" %>
development:
  <<: *default
  port: 5434
test:
  <<: *default
  database: blogpg_test
  port: 5434
production:
  <<: *default
  database: blogpg_production
  username: blogpg
  password: <%= ENV['BLOGPG_DATABASE_PASSWORD'] %>
 ```

## Links
- [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) - The blogpost that I worked through in order to understand how this works
- [**Rails**](https://github.com/rails/rails) - The framework used to create the blog
- [**PostgreSQL**](https://www.postgresql.org/) - The database used in this example
- [**Docker**](https://www.docker.com/) - The container technology used because I didn't want to install and run [**PostgreSQL**](https://www.postgresql.org/) locally on my computer
