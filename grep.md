# Search for matching text in file content in a directory

The command below will get the line matching the 'keyword' for every file/folders in the root directory, excluding the `vendor` directory.

```bash
$ grep -R --exclude-dir=vendor 'keyword' .
```
