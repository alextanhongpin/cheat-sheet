## Basic Dockerfile for Microsoft SQLServer

```docker-compose
version: '3.1'
services:
  db:
    image: microsoft/mssql-server-linux:2017-CU4
    restart: always
    environment: 
    - ACCEPT_EULA=Y
    - SA_PASSWORD=Qwerty12345
    ports:
    - 1433:1433
```

## Adding sql script

```bash
$ docker exec -it 87754d1e9a46 /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P "Qwerty12345" -d ConfigurationConfig -i ./ConfigurationDb.sql
```

## Optionally

Install `Sql Operations Studio`, connect to the database and run the query.
