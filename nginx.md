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

```
# SSH into ec2
$ ssh -i test.pem ec2-user@private.ip

# Go to nginx dir
$ cd /etc/nginx

# Edit 
$ vi nginx.conf

# Test
$ sudo nginx -t

# Reload through signal
$ sudo nginx -s reload
```
## Nginx rewrite for SPA/HTML5 Push state support
```
 location / {
        rewrite ^/.*/$ / last; # Redirect everything to / (ex index.html) and let the JS router take care of the rest
        rewrite ^([^.]*[^/])$ $1/ permanent; # Force trailing slash
    }
```

## Worker connections not enough in elasticbeanstalk


```nginx
# For more information on configuration, see:
#   * Official English Documentation: http://nginx.org/en/docs/
#   * Official Russian Documentation: http://nginx.org/ru/docs/

user nginx;
worker_processes auto;
error_log /var/log/nginx/error.log;
pid /var/run/nginx.pid;

events {
    worker_connections 4864;
    use epoll;
    multi_accept on;
}

http {
    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    access_log  /var/log/nginx/access.log  main;

    sendfile            on;
    tcp_nopush          on;
    tcp_nodelay         on;
    keepalive_timeout   65;
    keepalive_requests 100000;
    types_hash_max_size 2048;

    include             /etc/nginx/mime.types;
    default_type        application/octet-stream;

    # Load modular configuration files from the /etc/nginx/conf.d directory.
    # See http://nginx.org/en/docs/ngx_core_module.html#include
    # for more information.
    include /etc/nginx/conf.d/*.conf;

    index   index.html index.htm;

    server {
        listen       80 default_server;
        listen       [::]:80 default_server;
        server_name  localhost;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
        }

        # redirect server error pages to the static page /40x.html
        #
        error_page 404 /404.html;
            location = /40x.html {
        }

        # redirect server error pages to the static page /50x.html
        #
        error_page 500 502 503 504 /50x.html;
            location = /50x.html {
        }

        # proxy the PHP scripts to Apache listening on 127.0.0.1:80
        #
        #location ~ \.php$ {
        #    proxy_pass   http://127.0.0.1;
        #}

        # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
        #
        #location ~ \.php$ {
        #    root           html;
        #    fastcgi_pass   127.0.0.1:9000;
        #    fastcgi_index  index.php;
        #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
        #    include        fastcgi_params;
        #}

        # deny access to .htaccess files, if Apache's document root
        # concurs with nginx's one
        #
        #location ~ /\.ht {
        #    deny  all;
        #}
    }

# Settings for a TLS enabled server.
#
#    server {
#        listen       443 ssl;
#        listen       [::]:443 ssl;
#        server_name  localhost;
#        root         /usr/share/nginx/html;
#
#        ssl_certificate "/etc/pki/nginx/server.crt";
#        ssl_certificate_key "/etc/pki/nginx/private/server.key";
#        # It is *strongly* recommended to generate unique DH parameters
#        # Generate them with: openssl dhparam -out /etc/pki/nginx/dhparams.pem 2048
#        #ssl_dhparam "/etc/pki/nginx/dhparams.pem";
#        ssl_session_cache shared:SSL:1m;
#        ssl_session_timeout  10m;
#        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
#        ssl_ciphers HIGH:SEED:!aNULL:!eNULL:!EXPORT:!DES:!RC4:!MD5:!PSK:!RSAPSK:!aDH:!aECDH:!EDH-DSS-DES-CBC3-SHA:!KRB5-DES-CBC3-SHA:!SRP;
#        ssl_prefer_server_ciphers on;
#
#        # Load configuration files for the default server block.
#        include /etc/nginx/default.d/*.conf;
#
#        location / {
#        }
#
#        error_page 404 /404.html;
#            location = /40x.html {
#        }
#
#        error_page 500 502 503 504 /50x.html;
#            location = /50x.html {
#        }
#    }

}
```

## Engineers.my

```nginx

server {
       listen           80;
       server_name      events.engineers.my;
       return           301 https://$host$request_uri;
}

server {
       listen           443;
       server_name      events.engineers.my;
       error_page       500 502 503 504  /50x.html;
       access_log       /var/log/nginx/events.engineers.my.access.log combined;
       include		/etc/nginx/ssl.conf;
       client_max_body_size 10m;

       location /v1/events {
                rewrite                 ^/(.*)/$ /$1 permanent;

                proxy_pass              http://172.17.0.1:30000/v1/events;
                proxy_set_header        Host $host;

                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
       }

       location /v1/photos {
                rewrite                 ^/(.*)/$ /$1 permanent;

                proxy_pass              http://172.17.0.1:30000/v1/photos;
                proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
       }

       location /swagger {
                rewrite                 ^/(.*)/$ /$1 permanent;

                proxy_pass              http://172.17.0.1:30000/swagger;
                proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;
       }

       location / {
                rewrite                 ^/.*/$ /$1 last;
                proxy_pass              http://172.17.0.1:31000;
                proxy_set_header        Host $host;
                proxy_set_header        X-Real-IP $remote_addr;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Forwarded-Proto $scheme;

                # Set basic auth
                # auth_basic "Restricted";
                # auth_basic_user_file /etc/nginx/.htpasswd;
       }

       location = /50x.html {
                root			/var/www/nginx-default;
       }
}
```
