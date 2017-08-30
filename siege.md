siege -c50 -t60S -H 'Content-Type: application/json' 'http://domain.com/path/to/json.php POST {"ids": ["1","2","3"]}'


siege --concurrent=50 --content-type="application/json" 'http://example.com/api POST < /path/to/json-file.txt'
