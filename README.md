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

## Starting the container ##
As we are using a docker compose file starting the container is pretty easy:

```bash
docker compose up
```

You should see something like this on your terminal:

```bash
WARN[0000] /Users/bjensen/Development/rails_blog_pg/docker-compose.yml: the attribute `version` is obsolete, it will be ignored, please remove it to avoid potential confusion 
unable to get image 'postgres:14': Cannot connect to the Docker daemon at unix:///Users/bjensen/.docker/run/docker.sock. Is the docker daemon running?
bjensen@MMM2pro-Bjrn rails_blog_pg % docker compose up
[+] Running 15/15
 ✔ database Pulled                                                                                                                                                                    7.9s 
   ✔ 7ce705000c39 Already exists                                                                                                                                                      0.0s 
   ✔ a17abc86e878 Already exists                                                                                                                                                      0.0s 
   ✔ 533f47cc37b3 Already exists                                                                                                                                                      0.0s 
   ✔ 2c171c713eb0 Already exists                                                                                                                                                      0.0s 
   ✔ ed0c27b12f94 Already exists                                                                                                                                                      0.0s 
   ✔ 6a797b38b71e Already exists                                                                                                                                                      0.0s 
   ✔ 04627f37bf24 Already exists                                                                                                                                                      0.0s 
   ✔ f51bf6ebfbc0 Already exists                                                                                                                                                      0.0s 
   ✔ 7a636815af7b Pull complete                                                                                                                                                       5.9s 
   ✔ 215c42f6b78a Pull complete                                                                                                                                                       5.9s 
   ✔ 267a3f8f7fab Pull complete                                                                                                                                                       5.9s 
   ✔ 90b4408a45e2 Pull complete                                                                                                                                                       5.9s 
   ✔ 7d7cee0a2c46 Pull complete                                                                                                                                                       5.9s 
   ✔ c207d0db79d4 Pull complete                                                                                                                                                       5.9s 
[+] Running 3/3
 ✔ Network rails_blog_pg_default       Created                                                                                                                                        0.0s 
 ✔ Volume "rails_blog_pg_db_pg_data"   Created                                                                                                                                        0.0s 
 ✔ Container rails_blog_pg-database-1  Created                                                                                                                                        0.2s 
Attaching to database-1
database-1  | The files belonging to this database system will be owned by user "postgres".
database-1  | This user must also own the server process.
database-1  | 
database-1  | The database cluster will be initialized with locale "en_US.utf8".
database-1  | The default database encoding has accordingly been set to "UTF8".
database-1  | The default text search configuration will be set to "english".
database-1  | 
database-1  | Data page checksums are disabled.
database-1  | 
database-1  | fixing permissions on existing directory /var/lib/postgresql/data ... ok
database-1  | creating subdirectories ... ok
database-1  | selecting dynamic shared memory implementation ... posix
database-1  | selecting default max_connections ... 100
database-1  | selecting default shared_buffers ... 128MB
database-1  | selecting default time zone ... Etc/UTC
database-1  | creating configuration files ... ok
database-1  | running bootstrap script ... ok
database-1  | performing post-bootstrap initialization ... ok
database-1  | syncing data to disk ... ok
database-1  | 
database-1  | 
database-1  | Success. You can now start the database server using:
database-1  | 
database-1  |     pg_ctl -D /var/lib/postgresql/data -l logfile start
database-1  | 
database-1  | initdb: warning: enabling "trust" authentication for local connections
database-1  | You can change this by editing pg_hba.conf or using the option -A, or
database-1  | --auth-local and --auth-host, the next time you run initdb.
database-1  | waiting for server to start....2025-01-30 16:50:29.490 UTC [47] LOG:  starting PostgreSQL 14.15 (Debian 14.15-1.pgdg120+1) on aarch64-unknown-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
database-1  | 2025-01-30 16:50:29.490 UTC [47] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
database-1  | 2025-01-30 16:50:29.492 UTC [48] LOG:  database system was shut down at 2025-01-30 16:50:29 UTC
database-1  | 2025-01-30 16:50:29.494 UTC [47] LOG:  database system is ready to accept connections
database-1  |  done
database-1  | server started
database-1  | 
database-1  | /usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/init.sql
database-1  | CREATE ROLE
database-1  | 
database-1  | 
database-1  | waiting for server to shut down....2025-01-30 16:50:29.634 UTC [47] LOG:  received fast shutdown request
database-1  | 2025-01-30 16:50:29.635 UTC [47] LOG:  aborting any active transactions
database-1  | 2025-01-30 16:50:29.636 UTC [47] LOG:  background worker "logical replication launcher" (PID 54) exited with exit code 1
database-1  | 2025-01-30 16:50:29.636 UTC [49] LOG:  shutting down
database-1  | 2025-01-30 16:50:29.645 UTC [47] LOG:  database system is shut down
database-1  |  done
database-1  | server stopped
database-1  | 
database-1  | PostgreSQL init process complete; ready for start up.
database-1  | 
database-1  | 2025-01-30 16:50:29.750 UTC [1] LOG:  starting PostgreSQL 14.15 (Debian 14.15-1.pgdg120+1) on aarch64-unknown-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
database-1  | 2025-01-30 16:50:29.750 UTC [1] LOG:  listening on IPv4 address "0.0.0.0", port 5432
database-1  | 2025-01-30 16:50:29.750 UTC [1] LOG:  listening on IPv6 address "::", port 5432
database-1  | 2025-01-30 16:50:29.751 UTC [1] LOG:  listening on Unix socket "/var/run/postgresql/.s.PGSQL.5432"
database-1  | 2025-01-30 16:50:29.752 UTC [62] LOG:  database system was shut down at 2025-01-30 16:50:29 UTC
database-1  | 2025-01-30 16:50:29.756 UTC [1] LOG:  database system is ready to accept connections
```

## Creating the database ##
Creating the initial database in [**Rails**](https://github.com/rails/rails) is easy. Just execute

```bash
rails db:create
```

and you should have a working [**PostgreSQL**](https://www.postgresql.org/) database inside [**Docker**](https://www.docker.com/). Let's check it. Just open a new terminal window and use the [**PostgreSQL**](https://www.postgresql.org/) we have installed using [**homebrew**](https://brew.sh/):

```bash
psql -h 127.0.0.1 -p 5434 -U blogpg
# enter password from init.sql
```

Use the \l command to list all databases and you should see the folling:

```
blogpg=> \l
                                                     List of databases
    Name     |  Owner   | Encoding | Locale Provider |  Collate   |   Ctype    | Locale | ICU Rules |   Access privileges   
-------------+----------+----------+-----------------+------------+------------+--------+-----------+-----------------------
 blogpg      | blogpg   | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | 
 blogpg_test | blogpg   | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | 
 postgres    | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | 
 template0   | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
             |          |          |                 |            |            |        |           | postgres=CTc/postgres
 template1   | postgres | UTF8     | libc            | en_US.utf8 | en_US.utf8 |        |           | =c/postgres          +
             |          |          |                 |            |            |        |           | postgres=CTc/postgres
(5 rows)
```

**blogpg** and **blogpg** have been created using

```bash
rails db:create
```

So it seems that everything is working.

## Links
- [**"Setup a Rails Project with Postgres and Docker"**](https://danielabaron.me/blog/rails-postgres-docker/) - The blogpost that I worked through in order to understand how this works
- [**Rails**](https://github.com/rails/rails) - The framework used to create the blog
- [**PostgreSQL**](https://www.postgresql.org/) - The database used in this example
- [**Docker**](https://www.docker.com/) - The container technology used because I didn't want to install and run [**PostgreSQL**](https://www.postgresql.org/) locally on my computer
