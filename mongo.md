# Logging in specific database with auth

```bash
$ mongo engineersmy -u user -p PWD 
```

# Exporting as csv/json as authenticate user

```bash
# As CSV
$ mongoexport --db engineersmy --collection events --out hello.csv --type csv -u user -p PWD

# As JSON
$ mongoexport --db engineersmy --collection events --out hello.json -u user -p PWD 

# Or
$ mongoexport --authenticationDatabase=admin -d scraper -o user.json --jsonArray -c users -u root
```


# Importing json data

```bash
$ mongoimport --db dbName --collection collectionName -u user -p PWD fileName.json
```

# Dumping the mongo records

```bash
$ mongodump -u root --authenticationDatabase=admin --db=scraper --collection=users --out dump/
```

