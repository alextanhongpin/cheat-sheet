
Dump all data from elasticsearch to a json data:

```
$ elasticdump \
  --input=http://production.es.com:9200/my_index \
  --output=test.json \
  --type=data
```
