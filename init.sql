-- Only used for development where Postgres is run in Docker
create role blogpg with CREATEDB login password 'blogpg';

-- Only used for development where Postgres is run in Docker
-- create role blogpg with CREATEDB SUPERUSER login password 'blogpg';
