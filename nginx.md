## Resolve 499 error

You can see, 499 corresponds to the “client has closed connection”. This is most likely because the server-side processing time is too long, the client “impatient” the.
Determines whether the connection with a proxied server should be closed when a client closes the connection without waiting for a response.

```nginx
proxy_ignore_client_abort on;
```


## Including config in nginx.conf Elasticbeanstalk

Path: `.ebextensions/nginx.config`

```nginx
files:
  "/tmp/proxy.conf":
    mode: "000644"
    owner: root
    group: root
    content: |

      proxy_send_timeout 1200;
      proxy_read_timeout 1200;
      send_timeout       1200;
container_commands:
  00-add-config:
    command: cat /tmp/proxy.conf >> /var/elasticbeanstalk/staging/nginx/conf.d/elasticbeanstalk/00_application.conf
  01-restart-nginx:
    command: service nginx restart
```

