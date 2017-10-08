# Logging in specific database with auth

```bash
$ mongo engineersmy -u user -p ***REMOVED***
```

# Exporting as csv/json as authenticate user

```bash
# As CSV
$ mongoexport --db engineersmy --collection events --out hello.csv --type csv -u user -p ***REMOVED***

# As JSON
$ mongoexport --db engineersmy --collection events --out hello.json -u user -p ***REMOVED***
```


# Importing json data

```bash
$ mongoimport --db dbName --collection collectionName -u user -p ***REMOVED*** fileName.json
```
