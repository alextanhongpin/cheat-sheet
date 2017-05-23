# wrk is a Http Benchmarking tool


## Basic Usage
```bash
$ wrk -t10 -c100 -d10s http://127.0.0.1:8080/index.html
```

This runs a benchmark for 10 seconds, using 10 threads, and keeping 100 HTTP connections open.
