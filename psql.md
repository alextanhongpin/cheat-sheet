# PostgreSQL

Useful hints:

- End each command with the `;`

### Connect to the terminal application:

```bash
$ psql
```


### Creating Database

Creating a new database with the name `mydb`
```sql
CREATE DATABASE mydb;
```


### Drop Database

Delete the `mydb` database.
```sql
DELETE DATABASE mydb;
```


### Connect to Database

Connect to the database with the name `mydb`.
```sql
// Connect to the database
\c mydb;
```


## Create a Table

Create a new table with the name `mytable`.
```sql
CREATE TABLE mytable (
    table_id INTEGER NOT NULL,
    src TEXT,
    CONSTRAINT "PRIM_KEY" PRIMARY KEY (photo_id)

    FOREIGN_KEY (user_id)
    REFERENCES user_tbl (user_id)
)```


## List all Tables

```bash
$ \d
```


## View Specific Table

```bash
$ \d mytable
```


## Alter Table

Alter the table `mytable` by adding a new column `alt`.
```sql
ALTER TABLE mytable ADD COLUMN alt TEXT;
```

## Clear Table

Empty the table

```sql
TRUNCATE TABLE mytable;
```


## Insert Row

Insert a new row into table `mytable`
```
INSERT INTO mytable
(photo_id, src) VALUES (1, 'SOMETHING');

// Query the sql
SELECT * FROM photo_tbl;
```
