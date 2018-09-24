## Getting RFC Date from terminal for build date

```bash
$ date -R
```

Output:

```bash
Fri, 27 Apr 2018 17:56:15 +0800
```

## Formatting Date

```
%a = Short date, Sun
%A = Long date, Sunday
%b = Short Month, Feb
%B = Long Month, February
%d = Day of the month
%D = Date such as %m/%d/%y
%H = Hour in 24 hour format (00..23)
%I = Hour in 12 hour format (01..12) (this can be used with %p to append Am or PM)
%j = Day of the year
%m = Month in number format (01..12)
%M = Minute (00..59)
%p = Locale either AM or PM
%S = Second
%u = Day of the week
%V = Week number of year with Monday as first day of week (01..53)
%Y = Year
%z = Numeric timezone (e.g., -0400) or %Z with timezone abbreviation.
%t = for a tab 
%n = for a new line
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
