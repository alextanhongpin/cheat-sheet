## Resolve 499 error

You can see, 499 corresponds to the “client has closed connection”. This is most likely because the server-side processing time is too long, the client “impatient” the.
Determines whether the connection with a proxied server should be closed when a client closes the connection without waiting for a response.

```nginx
proxy_ignore_client_abort on;
```

