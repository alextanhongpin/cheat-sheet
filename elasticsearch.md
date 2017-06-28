Setting up elasticsearch with elasticsearch-head with docker

```bash
$ docker run -p 9200:9200 -e "http.host=0.0.0.0" -e "transport.host=127.0.0.1" -e "http.cors.enabled=true" -e "http.cors.allow-origin=*" --name elasticsearch docker.elastic.co/elasticsearch/elasticsearch:5.4.0

// Access the bin
$ docker exec -i -t elasticsearch bash

// Remove x-pack
$ elasticsearch-plugin remove x-pack

// Restart
$ docker restart elasticsearch 
```


Now you can connect the elasticsearch-head.
```bash
$ docker run -p 9100:9100 mobz/elasticsearch-head:5
```
