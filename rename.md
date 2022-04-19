## Batch rename file names

```python
import glob
import os
import re

regex = re.compile(r"\W+", re.IGNORECASE)

for file in glob.glob("*.png"):
    _, fullname = os.path.split(file)
    basename, ext = os.path.splitext(fullname)
    basename = regex.sub('_', basename.lower())
    print(fullname, basename + ext)
    os.rename(fullname, basename + ext)

```
