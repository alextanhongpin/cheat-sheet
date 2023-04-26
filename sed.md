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


## Rewrite source code


The `src/hello.txt` contains:

```txt
this is a text to replace "here"

\`\`\`go
func main() {
	->setHost()
	->setPort()
}
\`\`\`
```

This script searches for the pattern `->setHost` and replace the whole line with `->setHostAndPort()`.

It then deletes the line with `->setPort()`.

```Makefile
all:
	rm ./src/hello.txt
	cp hello.txt ./src/hello.txt
	for file in $(shell ag -i setHost -l src); do \
		echo $$file; \
		sed -i '' 's/->setHost.*/->setHostAndPort()/g' $$file; \
		sed -i '' '/->setPort/d' $$file; \
	done
```



Output:

<!--You can escape backticks with four backticks-->
````
this is a text to replace "here"

```go
func main() {
	->setHostAndPort()
}
```
````

## How to insert a multi-line content from a file to the next line of the matched content in another file

The file `src/main.go` contains the following:
```go
package main

import "fmt"

func main() {
	fmt.Println("hello world")
}
```

The `script.sh` contains the following:

```bash
file=src/main.go

# Create a new template.
# The single quote for EOF is to escape special characters.
cat <<'EOF' > template.txt
	fmt.Println("hello again");
EOF

if [ -f "$file" ]; then
	# Idempotent writes.
	# Check if the file already contains the pattern.
	# Only insert new lines if the file does not contain the pattern yet.
	if ! grep -q "hello again" $file; then
		# Search for the line that
		# contains the text, and inserts
		# the new content from the
		# template in the line after that
		# text.
		sed -i '' '/fmt.Println("hello world").*/r template.txt' $file
	fi
fi


# Remove template if exists.
# Silent errors if file do not exists.
rm -f template.txt
```


Remember to run `chmod u+x script.sh`. Run `./script.sh`. The `src/main.go` now contains:

```go
package main

import "fmt"

func main() {
	fmt.Println("hello world")
	fmt.Println("hello again");
}
```
