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

## Example executing a source file from outside of Docker to Docker MySQL

```bash
$ docker exec -i <DOCKER_IMAGE_ID> mysql -u root < ./filename.sql
```

## Performance Tips

- Store UUID as binary
