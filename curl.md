## Sending a regular CORS request using cUrl:

```bash
curl -H "Origin: http://example.com" --verbose \
  https://www.googleapis.com/discovery/v1/apis?fields=
```


## Sending a preflight request using cUrl:

```bash
curl -H "Origin: http://example.com" \
  -H "Access-Control-Request-Method: POST" \
  -H "Access-Control-Request-Headers: X-Requested-With" \
  -X OPTIONS --verbose \
  https://www.googleapis.com/discovery/v1/apis?fields=
```


## Uploading file

```bash
$ curl -F 'file[]=@/absolute/path/filename.jpeg" http://localhost:8080
```

## Measure response time

https://stackoverflow.com/questions/18215389/how-do-i-measure-request-and-response-times-at-once-using-curl
```
// .bashrc or .zprofile
curl_time() {
    curl -so /dev/null -w "\
   namelookup:  %{time_namelookup}s\n\
      connect:  %{time_connect}s\n\
   appconnect:  %{time_appconnect}s\n\
  pretransfer:  %{time_pretransfer}s\n\
     redirect:  %{time_redirect}s\n\
starttransfer:  %{time_starttransfer}s\n\
-------------------------\n\
        total:  %{time_total}s\n" "$@"
}
```
