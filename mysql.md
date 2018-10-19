# mysql Commands for the terminal

Replace the capitalized text with your own values.

| Command | Description | 
|--       |--           |
| `mysql -h hostname -u root -p` | Login, use -h only if needed. | 
| `mysql> source PATH/TO/FILE.sql` | Executes a sql file. |
| `help COMMAND` | Display help for a particular command. |
| `source script.sql` | Execute a script. |
| ` SELECT * FROM tableName \G;` | Pretty print output |

```bash
# Use the demo database;
$ USE demo;

# Show the table
$ SHOW TABLES;

# Describe a table
$ DESCRIBE address;

$ DROP USER 'jeffrey'@'localhost';
```

## Sample Create Table

```
CREATE TABLE IF NOT EXISTS sample (
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gender CHAR(1) NOT NULL,
	name VARCHAR(80) NOT NULL,
	description VARCHAR(255) NOT NULL,
	some_boolean BOOLEAN NOT NULL DEFAULT 0,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	deleted_at DATETIME
);
```

<!--
mysqlbinlog --set-charset = utf8


## View the character
show variables like '%char%';


Run the following command to change the character set and collation of your database:
```mysql
ALTER DATABASE testdb CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```
Run the following command to change the character set and collation of your table:
```mysql
ALTER TABLE source CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
```


ALTER TABLE `source` CONVERT TO CHARACTER SET utf8 COLLATE utf8_general_ci
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

## Login as root
mysql -h 127.0.0.1 -P 3308 -u root -p


CREATE TABLE `source` (
  `name` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4


 INSERT INTO source (name) values ("Sử dụng thành thạo phần mềm bảo hiểm EFY");

 mysqlbinlog -d crm aedd504deb26-bin.000002 > crm-events.txt

 https://makandracards.com/makandra/2529-show-and-change-mysql-default-character-set

 https://dev.mysql.com/doc/refman/5.7/en/charset-applications.html

 
mysql -h 127.0.0.1 -P 3308 -u root -p 

https://medium.com/@adamhooper/in-mysql-never-use-utf8-use-utf8mb4-11761243e434


| utf8mb4  | UTF-8 Unicode                   | utf8mb4_general_ci  |      4 |
| utf8     | UTF-8 Unicode                   | utf8_general_ci     |      3 |-->

## Basic Docker Mysql

```docker-compose
version: '3.1'
services:
  db:
    image: mysql:8.0.3
    restart: always
    environment: 
    - MYSQL_DATABASE=idpconfig
    - MYSQL_ALLOW_EMPTY_PASSWORD=yes
    ports:
    - 3306:3306
```

## Run MySQL in Docker

```
$ docker run -d --rm -it -p 3306:3306 -e MYSQL_ROOT_PASSWORD=root mysql:8.0.12
$ mysql -h 127.0.0.1 -u root -p 
```

## Example executing a source file from outside of Docker to Docker MySQL

```bash
$ docker exec -i <DOCKER_IMAGE_ID> mysql -u root < ./filename.sql
```

# Performance

## Use UUID

[MySQL 8.0](https://mysqlserverteam.com/mysql-8-0-uuid-support/) has build-in UUID support. There are several pros and cons of using UUID instead of auto-incrementing the primary key.

Some other references:
- https://mysqlserverteam.com/storing-uuid-values-in-mysql-tables/

To run MySQL in Docker, follow the step [here](#run-mysql-in-docker)
```mysql
# Create a database first.
mysql > CREATE DATABASE uuidtest;
Query OK, 1 row affected (0.05 sec)

# Switch database.
mysql > USE uuidtest;
Database changed

# Create table.
mysql> CREATE TABLE t (id binary(16) PRIMARY KEY);
Query OK, 0 rows affected (0.10 sec)

# Create entry with a new UUID.
# Note that the second argument is set to true. This is required to rearrange the time-related bits so that consecutive generated values will be ordered. This will have less performance impact as the values will no longer be inserted in random locations. Read the reference for more info.
mysql> INSERT INTO t VALUES(UUID_TO_BIN(UUID(), true));
Query OK, 1 row affected (0.07 sec)

# View result.
mysql> SELECT BIN_TO_UUID(id) from t;
+--------------------------------------+
| BIN_TO_UUID(id)                      |
+--------------------------------------+
| 20467a31-c914-11e8-b0aa-0242ac110002 |
+--------------------------------------+
1 row in set (0.00 sec)
```

Calling `UUID_TO_BIN(UUID())`:
```sql
mysql> select bin_to_uuid(id) from t;
+--------------------------------------+
| bin_to_uuid(id)                      |
+--------------------------------------+
| d9b2615b-c915-11e8-99bb-0242ac110002 |
| dabdbf92-c915-11e8-99bb-0242ac110002 |
| db1a0ccb-c915-11e8-99bb-0242ac110002 |
| db5fda13-c915-11e8-99bb-0242ac110002 |
| db9e66ce-c915-11e8-99bb-0242ac110002 |
| dbdb2033-c915-11e8-99bb-0242ac110002 |
| dc62df00-c915-11e8-99bb-0242ac110002 |
| de0b358d-c915-11e8-99bb-0242ac110002 |
+--------------------------------------+
8 rows in set (0.00 sec)
```

Calling `UUID_TO_BIN(UUID(), true)`:

```sql

mysql> select bin_to_uuid(id) from t;
+--------------------------------------+
| bin_to_uuid(id)                      |
+--------------------------------------+
| 11e8c916-2271-6dfb-99bb-0242ac110002 |
| 11e8c916-2396-4757-99bb-0242ac110002 |
| 11e8c916-2406-c782-99bb-0242ac110002 |
| 11e8c916-245e-09a6-99bb-0242ac110002 |
| 11e8c916-24b4-a849-99bb-0242ac110002 |
| 11e8c916-2507-9ac7-99bb-0242ac110002 |
| 11e8c916-255e-d329-99bb-0242ac110002 |
| 11e8c916-25bb-0bb4-99bb-0242ac110002 |
+--------------------------------------+
8 rows in set (0.01 sec)
```

## CHAR(n) vs VARCHAR(n)

- `CHAR(n)` values are stored with the *exact* length specified.
- E.g. when storing a field "hello" in CHAR(100), 5 characters will be stored with 95 spaces right-padded. During retrieval, the trailing spaces are removed (can be set to return spaces through `PAD_CHAR_TO_FULL_LENGTH`).
- VARCHAR values are stored as a 1-byte or 2-byte length prefix plus data
# varchar(5) vs varchar(500)

- note you cannot index column that's over 900 bytes in size
- which makes varchar(500) or varchar(max) not suitable

# Basics

## Create Table

```sql
CREATE TABLE [IF NOT EXISTS] proglang_tbl (
  id INTEGER
  language VARCHAR(20),
  author VARCHAR(25),
  year INTEGER
);
```

## Insert


```sql
INSERT INTO 
  TABLE proglang_tbl 
  VALUES (1, 'Fortran', 'Backus', 1955)
```

# Constraint

A rule that you apply or abide by while doing SQL operations.

## Null Constraint

All fields by default are nullable in most database management system. A _null_ value does not mean 0 (zero) or empty string like ''. Treat it as empty or undefined.

```sql
CREATE TABLE proglang_tblcopy (
  id       INTEGER     NOT NULL,
  language VARCHAR(20) NOT NULL,
  author   VARCHAR(25) NOT NULL,
  year     INTEGER     NOT NULL,
  standard VARCHAR(10) NULL
);
```

Success:

```sql
INSERT INTO 
  TABLE proglang_tblcopy 
  VALUES (1, 'Fortran', 'Backus', 1990, null)
```

Error:

TODO: Add example of non null error.

## Selective Fields Insert

```sql
INSERT INTO
  TABLE proglang_tblcopy 
         (id, language, author, year, standard)
  VALUES (1, 'Prolog', 'Colmerauer', 1972, 'ISO')
```

## Check Constraint

Provides validation of what values are allowed in a particular field.

```sql
CREATE TABLE proglang_constraints (
  id       INTEGER     NOT NULL,
  language VARCHAR(20) NOT NULL,
  author   VARCHAR(25) NOT NULL,
  year     INTEGER     NOT NULL CHECK (year > 1950),
  standard VARCHAR(10) NULL
);
```

## Primary Key Constraint

```sql
CREATE TABLE proglang_tbltmp (
  id       INTEGER     NOT NULL PRIMARY KEY,
  language VARCHAR(20) NOT NULL,
  author   VARCHAR(25) NOT NULL,
  year     INTEGER     NOT NULL
  standard VARCHAR(10) NULL
);
```

TODO: Add error example when adding same primary key.

## Unique Key Constraint

```sql
CREATE TABLE proglang_tbuk (
  id       INTEGER     NOT NULL PRIMARY KEY,
  language VARCHAR(20) NOT NULL UNIQUE,
  author   VARCHAR(25) NOT NULL,
  year     INTEGER     NOT NULL,
  standard VARCHAR(10) NULL
);
```

  Difference between a Primary Key and a Unique Key. Primary key field cannot take `NULL` value. A unique can take a single record with null value. Also, you can only define one primary key constraint for a table, but multiple unique constraints. Primary key constraint is similar to `NOT NULL UNIQUE` constraint.

# Operations on Table

## Dropping Table

```bash
mysql> DROP TABLE proglang_tbl;
```

## Creating Table from existing Table

```sql
CREATE TABLE <new_table> 
  AS
SELECT <selection> FROM <old_table>;
```

Example:

```sql
CREATE TABLE proglang_tbl_new
  AS
SELECT * FROM proglang_tbl
```

## Modifying Table

```sql
ALTER TABLE <table_name> <operation> <field_with_clauses>
```

Example

```sql
ALTER TABLE 
  proglang_tbl 
ALTER COLUMN 
  author TYPE VARCHAR(30)
ADD COLUMN 
  current_status VARCHAR(32) NULL;
```

# Basic Queries

## Selecting a Limited number of Columns

```sql
SELECT 
  language, year
FROM 
  proglang_tb;
```

## Ordering the Results

By default, the order is ascending.

```sql
SELECT
  language, year
FROM 
  proglang_tbl 
ORDER BY 
  year;
```

Descending order:

```sql
SELECT
  language, year 
FROM
  proglang_tbl   
ORDER BY 
  year
DESC;
```

## Ordering by Multiple Columns


```sql
SELECT 
  language, year
FROM 
  proglang_tbl
ORDER BY
  year     DESC, 
  language ASC;
```

## Putting conditions with `WHERE`

```sql
SELECT 
  language, author
FROM
  proglang_tbl
WHERE
  standard = 'ANSI';
```

Combined with `ORDER_BY`:

```sql
SELECT
  language, author, year
FROM
  proglang_tbl
WHERE
  year > 1970
ORDER BY
  author;
```

## Combining Conditions

With `AND` operator:

```sql
SELECT
  language, author, year
FROM 
  proglang_tbl
WHERE 
  year > 1970 
    AND 
  standard IS NULL;
```

With `OR` operator:

```sql
SELECT 
  language, author, year
FROM 
  proglang_tbl
WHERE
  year > 1970 
    OR 
  standard is NULL
```

# Manipulating Data

## Inserting Data into a Table from another table

```sql
CREATE TABLE stdlang_tbl (
  language VARCHAR(20),
  standard VARCHAR(10)
);

INSERT INTO stdlang_tbl
  SELECT 
    language, standard
  FROM 
    proglang_tbl
  WHERE
    standard IS NOT NULL;
```

## Update existing data

```sql
UPDATE 
  proglang_tbl
SET
  year = year + 10;
```

## Update with `WHERE` condition

```sql
UPDATE 
  proglang_tble 
SET
  year = 1972
WHERE
  language = 'FORTH';
```

## Update multiple fields

```sql
UPDATE
  proglang_tbl
SET
  year = 1972,
  standard = 'ANSI'
WHERE
  language = 'FORTH';
```

## Deleting Data from tables

```sql
DELETE FROM
  proglang_tbl
WHERE
  language = 'FORTH';
```

## Deleting all records

```sql
DELETE FROM proglang_tbl;
```

# Organizing your data

## Splitting the table

```sql
CREATE TABLE newlang_tbl (
  id       INTEGER     NOT NULL PRIMARY KEY,
  language VARCHAR(20) NOT NULL,
  year     INTEGER     NOT NULL
  standard VARCHAR(10) NULL
);

CREATE TABLE authors_tbl (
  id          INTEGER     NOT NULL,
  author      VARCHAR(25) NOT NULL,
  language_id INTEGER     REFERENCES newlang_tbl(id)
);
```

# Doing More with Queries

## Counting the records

```sql
SELECT 
  COUNT(*) 
FROM 
  proglang_tbl;
```

This will return the count of records that are not `NUll`:

```sql
SELECT 
  COUNT(standard)
FROM
  proglang_tbl;
```

## Distinct Values

Note that `NULL` is considered a distinct value too.

```sql
SELECT 
  DISTINCT year
FROM 
  proglang_tbl;
```

## Count Distinct Values

When combined with `COUNT`, the `NULL` value will not be counted.

```sql
SELECT 
  COUNT(DISTINCT year)
FROM 
  proglang_tbl;
```

## Column Alias

```sql
SELECT 
  <col1> <alias1>
  <col2> <alias2>
FROM
 <table>;
```

Example:

```sql
SELECT 
  id, language, author creator
FROM proglang_tbl;
```


## Order of execution of SELECT queries

1. `FROM` clause
2. `WHERE` clause
3. `GROUP BY` clause
4. `HAVING` clause
5. `SELECT` clause
6. `ORDER BY` clause

This will not work, because the **WHERE** has a higher order of execution than **SELECT**:

```sql
SELECT
  id, language, author creator
FROM
  proglang_tbl
WHERE
  creator = 'Ross'
```

Error:

```sql
TODO: Display the error
```

This will work:

```sql
SELECT
  id, language, author creator
FROM
  proglang_tbl
ORDER BY 
  creator;
```

## Like Operator

- **% (Percent)**: Used to match multiple characters including a single character and no character
- **_(Underscore)**: Used to match exactly one character.


Languages starting with **'P'**:

```sql
SELECT *
FROM
  proglang_tbl
WHERE
  language 
LIKE 'P%';
```

Languages ending with **l** and 3 characters long:

```sql
SELECT * 
FROM 
  proglang_tbl
WHERE
  language
LIKE '__l';
```

# Calculated Fields

To show the number of years since the start of decade:

```sql
SELECT 
  language
  (year % 10) remain
FROM
  proglang_tbl;
```

To calculate the creation decade:

```sql
SELECT
  language,
  year - (year % 10) decade
FROM
  proglang_tbl;
```

Or:

```sql
SELECT
  language,
  (year / 10) * 10 decade
FROM
  proglang_tbl;
```

## String operations

```sql
SELECT 
  language,
  'The '||((year/10) * 10)||'s' decade
FROM
  proglang_tbl;
```

## Substring

Extracting the first two characters:

```sql
SELECT
  SUBSTR(language, 1, 2),
  year
FROM
  proglang_tbl;
```

## Upper and lower case

```sql
SELECT
  UPPER(language),
  LOWER(standard)
FROM
  proglang_tbl;
```

## Literal Values

Literal values are fixed fields inserted in specific positions of a record.

```sql
SELECT
  language,
  year,
  'AD'
FROM
  proglang_tbl;
```

# Aggregation and Grouping

## Average

```sql
SELECT 
  AVG(year)
FROM
  proglang_tbl;
```

Cast to integer:

```sql
SELECT
  CAST (AVG(year) AS INTEGER)
FROM
  proglang_tbl;
```

## Sum

```sql
SELECT 
  SUM(year) 
FROM 
  proglang_tbl;
```

## Min and Max

```sql
SELECT 
  MIN(year), 
  MAX(year)
FROM 
  proglang_tbl;
```


## Grouping Data

```sql
SELECT 
  standard
FROM 
  proglang_tbl
WHERE
  standard IS NOT NULL
GROUP BY 
  standard;
```

Multiple group:

```sql
SELECT
  standard,
  language
FROM
  proglang_tbl
WHERE
  standard IS NOT NULL
GROUP BY
  standard,
  language;
```

## Grouping and Aggregate Functions

```sql
SELECT
  standard,
  COUNT(*)
FROM
  proglang_tbl
GROUP BY
  standard;
```

## The **HAVING** clause


```sql
SELECT
  language,
  standard,
  year
FROM 
  proglang_tbl
GROUP BY
  standard,
  year,
  language
HAVING
  year < 1970;
```

# Joins

# Join operation on two tables

```sql
SELECT
  author, language
FROM 
  authors_tbl,
  newlang_tbl
WHERE
  language_id = id;
```

Or:


```sql
SELECT
  author, 
  language
FROM 
  authors_tbl JOIN newlang_tbl
  ON 
    language_id = id;
```

## Inner Joins

The kind of joins where all rows that don't match the join condition exactly are eliminated.

```sql
SELECT
  author, 
  language
FROM 
  authors_tbl INNER JOIN language_tbl
  ON
    language_id = id;
```

## Resolving ambiguity in Join Columns

```sql
SELECT
  author, language
FROM 
  authors_tbl a JOIN language_tbl b
  ON
    a.language_id = b.language_id;
```

## Outer Joins

The resultset consists of row that match the join condition and the rows that don't match the condition from one of the tables.

```sql
SELECT 
  language, 
  author
FROM
  newlang_tbl a LEFT OUTER JOIN authors_tbl b
  ON
    a.id = b.language_id;
```

## Cross Join

A.k.a *Cartesian Product*, resultset contains the output of all possible combinations of records.

```sql
SELECT 
  author
  language
FROM 
  authors_tbl, 
  newlang_tbl
``` 

Or:

```sql
SELECT 
  author
  language
FROM 
  authors_tbl CROSS JOIN newlang_tbl
``` 

## Self Join

```sql
SELECT 
  l1.id
  l1.language
  l2.language AS influenced
FROM
  inflang_tbl l1, 
  inflang_tbl l2
WHERE
  l1.ud = l2.influenced_by;
```

# Subqueries

```sql
SELECT 
  author 
FROM 
  authors_tbl
WHERE 
  language_id
IN (
  SELECT 
    id 
  FROM 
    newlang_tbl
  WHERE
    language = 'Tcl'
);
```

## Using Subqueries in **INSERT** statement

```sql
INSERT INTO authors_tbl 
  (author_id, author, language_id) 
VALUES 
  (7, 'Wirth', (SELECT id 
                FROM   newlang_tbl 
                WHERE  language = 'Pascal'));
```

# Working in Sets

## **UNION** Operator

```sql
SELECT 
  year
FROM
  proglang_tbl
WHERE 
  standard = 'ANSI'

UNION

SELECT 
  year
FROM 
  proglang_tbl
WHERE
  standard = 'ISO';
```

## **INTERSECT** Operator

```sql
SELECT 
  standard 
FROM 
  proglang_tbl
WHERE 
  year = 1964

INTERSECT

SELECT 
  standard 
FROM 
  proglang_tbl
WHERE 
  year = 1957;
```

## **DIFFERENCE** Operator

This does not work:

```sql
SELECT
  year
FROM 
  proglang_tbl
WHERE 
  standard IN ('ISO')
AND 
  standard NOT IN ('ANSI');
```

This works:

```sql
SELECT
  year
FROM 
  proglang_tbl
WHERE
  standard IN ('ISO')

EXCEPT

SELECT
  year
FROM
  proglang_tble
WHERE
  standard IN ('ANSI');
```

# Views

## Creating a View

```sql
CREATE VIEW <view_name> AS <query>
```

```sql
CREATE VIEW 
  language_chronology
AS
  SELECT 
    language, 
    year
  FROM 
    proglang_tbl
  ORDER BY
    years 
  ASC;
```

Selection:

```sql
SELECT 
  *
FROM 
  language_chronology;
```


## Modifying data thorugh views

```sql
UPDATE
  language_chronology
SET
  year = 1977
WHERE 
  language = 'Fortran';
```

## Deleting View

```sql
DROP VIEW <view_name>
```

# Indexing

## General syntax

```sql
CREATE [UNIQUE] INDEX 
  <index_name> 
ON 
  <table_name> (<column_list>);
```

## Create

```sql
CREATE INDEX 
  language_idx 
ON 
  proglang_tbl (language);
```

## Deleting Index

```sql
DROP INDEX <index_name>
```
