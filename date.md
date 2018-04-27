## Getting RFC Date from terminal for build date

```bash
$ date -R
```

Output:

```bash
Fri, 27 Apr 2018 17:56:15 +0800
```

## ISO-8601 Compliant Date

```bash
$ date +%F
```

Output:

```bash
2018-04-27
```

## RFC3339 with macos date

```bash
# -u stands for UTC
$ date -u +"%Y-%m-%dT%H:%M:%SZ"
```

Output:

```bash
2018-04-27T10:23:29Z
```

## RFC3339 with macos gdate

```bash
$ gdate --rfc-3339=seconds
```

Output:

```bash
2018-04-27 18:16:26+08:00
```

## RFC3339 with macos gdate UTC

```bash
$ gdate -u --rfc-3339=seconds
```

Output:

```bash
2018-04-27 10:16:34+00:00
```

## Golang

```bash
time.Now().UTC().Format(time.RFC3339)
```

Output:

```bash
2018-04-27T10:23:29Z
```

## NodeJS

```js
const moment = require('moment')
console.log(moment().utc().format())
console.log(moment().format())
```

Output:

```
2018-04-27T10:26:21Z
2018-04-27T18:26:21+08:00
```
