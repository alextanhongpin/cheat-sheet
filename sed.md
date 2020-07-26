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


## Inject before line

```
inject:
	gsed -i '/Inject code here/i another code' text.txt
```

Multi-line:

```bash
define template_import
	gsed -i "/inject code here/Ii \
	userRepository: container(UserRepository).asClass(),\n\
	userService: container(UserService).asClass().singleton(), \
	" text.txt
endef
```

## Remove line with pattern

Note, multi line remove not supported...so we run each command separately.

```bash
# With GNU sed, we can use ignore case.
define remove_line
	gsed -i '/userService/Id' text.txt; \
	gsed -i '/userRepository/Id' text.txt
endef

# With macos sed, we can't, use regex instead.
define remove_line
	sed -i '' '/[u|U]serService/d' text.txt; \
	sed -i '' '/[u|U]serRepository/d' text.txt
endef
```
