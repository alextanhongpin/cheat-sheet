## Format string


```bash
$ echo hello.go | sed 's/.go/.sol/g'
```
Output:
```
hello.sol
```


## Case conversion
To camel case (gsed required):

```bash
$ brew install  gnu-sed

$ echo hello_world | gsed -E 's/_([a-z])/\U\w/g'
```

To PascalCase:
```
$ echo "this_is_the_string" | gsed -r 's/(^|_)([a-z])/\U\2/g'
$ echo "this-is-the-string" | gsed -r 's/(^|-)([a-z])/\U\2/g'
# ThisIsTheString
```

Substitute pattern:
```
(^|_) at the start of the string or after an underscore - first group
([a-z]) single lower case letter - second group
by
\U\2 uppercasing second group
g globally.
```

## Assign sed value to variable

```bash
comp=$(echo "$fullName"  | sed 's/ //g')
# or
comp=`echo "$fullName"  | sed 's/ //g'`
```
