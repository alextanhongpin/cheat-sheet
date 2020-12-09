## Jupyter not using MacOS python3 

When the kernel is missing for Jupyter Lab:
```bash
$ python3 -m pip install ipykernel
$ python3 -m ipykernel install --user
```


## Setting up Unittest with Jupyter

```python
import unittest

class TestSum(unittest.TestCase):
    def test_sum(self):
        self.assertEqual(2, 2)
        
if __name__ == '__main__':
    unittest.main(argv=['first-argument-is-excluded'], exit=False)
```
