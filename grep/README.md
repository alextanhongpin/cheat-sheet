# Grep Guide
Use grep to extract out only the results that contains “L337”, “Honda” and “Blue”:

```bash
$ cat vehicles.txt | grep -A 5 L337 | grep -A 4  -B 1 Honda | grep -A 3 -B 2 Blue
```