# mysql Commands for the terminal

Replace the capitalized text with your own values.

| Command | Description | 
|--       |--           |
| `mysql -h hostname -u root -p` | Login, use -h only if needed. | 
| `mysql> source PATH/TO/FILE.sql` | Executes a sql file. |
| `help COMMAND` | Display help for a particular command. |
| `source script.sql` | Execute a script. |

```bash
# Use the demo database;
$ USE demo;

# Show the table
$ SHOW TABLES;

# Describe a table
$ DESCRIBE address;

$ DROP USER 'jeffrey'@'localhost';
```
