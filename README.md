# Flyway migration tool

This service perform schema migration procedure to our database.

## compose setup

```yml
your-database:
  image: postgres:latest
  networks:
    - your-backend-network

flyway-container:
  image: THIS-IMAGE
  restart: on-failure
  networks:
    - your-backend-network
  depends_on:
    - your-database
  volume:
    - ./path/to/your/flyway.conf:/flyway/conf/flyway.conf
```

## Docker compose usage

```shell

cd ./path/to/your/project

# Cleanup database (WARNING! You will lose all your data)
docker-compose run flyway-container clean

# Migration schema
docker-compose run flyway-container migrate
```

## How to add migration scripts

- write the script
- follow the script naming convention: https://flywaydb.org/documentation/migrations#sql-based-migrations
- add the script to the `sql` directory.
