## Create an array of ones

```python
np.ones((3, 4))
```

## Create an array of zeros

```python
np.zeros((2,3,4), dtype=np.int16)
```

## Create an array with random values

```python
np.random.random((2,2))
```

## Create an empty array

```python
np.empty((3,2))
```

## Create a full array

```python
# 7 is a constant value
np.full((2,2), 7)
```

## Create an array of evenly-spaced values

```python
# Create an array that starts at 10 with steps of 5
np.arange(10, 25, 5)
```

## Create an array of evenly-spaced values

```python
# Creates an array of 9 values that lies between 0 and 2
np.linspace(0, 2, 9)
```

## Load numpy array from text

```python
# This is your data in the text file
# Value1  Value2  Value3
# 0.2536  0.1008  0.3857
# 0.4839  0.4536  0.3561
# 0.1292  0.6875  0.5929
# 0.1781  0.3049  0.8928
# 0.6253  0.3486  0.8791

# Import your data
x, y, z = np.loadtxt('data.txt',
                    skiprows=1,
                    unpack=True)
# Unpack returns the columns as separate arrays
```

## Load numpy array with missing values

```python
# Your data in the text file
# Value1  Value2  Value3
# 0.4839  0.4536  0.3561
# 0.1292  0.6875  MISSING
# 0.1781  0.3049  0.8928
# MISSING 0.5801  0.2038
# 0.5993  0.4357  0.7410

my_array2 = np.genfromtxt('data2.txt',
                      skip_header=1,
                      filling_values=-999)
```

## Save numpy arrays

```python

import numpy as np
x = np.arange(0.0, 5.0, 1.0)
np.savetxt('test.out', x, delimiter=',')
```

## Operations

```python
# x.shape and y.shape must be equal
np.add(x, y)
np.substract(x, y)
np.multiply(x, y)
np.divide(x, y)
np.remainder(x, y)
```

## Aggregate functions

```python
a.sum()
a.min()
b.max(axis=0) # Maximum value of an array row
b.cumsum(axis=1) # Cumulative sum of elements
a.mean()
b.median()
a.corrcoef() # Correlation coefficient
np.std(b) # Standard deviation
```

## AND, OR, NOT

```python
# a AND b
np.logical_and(a, b)

# a OR b
np.logical_or(a, b)

# a NOT b
np.logical_not(a, b)
```

## Subset, slice and index arrays

```python
a[start:end] # items start through the end (but the end is not included!)
a[start:]    # items start through the rest of the array
a[:end]      # items from the beginning through the end (but the end is not included!)

# Select items at index 0 and 1
print(my_array[0:2])

# Select items at row 0 and 1, column 1
print(my_2d_array[0:2,1])

# Select items at row 1
# This is the same as saying `my_3d_array[1,:,:]
print(my_3d_array[1,...])
```

## Boolean indexing

```python
x = np.array([[1,2], [3,4]])
print(x[x > 1]) # array([2, 3, 4])

y = (x >= 1)
# array([[False,  True],
       [ True,  True]], dtype=bool)
       
print(x[y])
# array([2, 3, 4])

# Select element at (0, 0) and (1, 1)
print(x[[0, 1], [0, 1])
# array([1, 4])

# Select a subset of the rows and columns
x[[0, 1]][:,[1]]
# array([[2],
#       [4]])

# `:,` means keep the rows, and you can repeat the columns as much as you want
x[[0,1]][:,[0, 1, 0, 1]]
# array([[1, 2, 1, 2],
#        [3, 4, 3, 4]])
```

## Transpose

```python
# use Transpose
np.transpose(my_2d_array)

# Or use T
my_2d_array.T
```

## Resize
If you pass your original array together with the new dimensions, and if that new array is larger than the one that you originally had, the new array will be filled with copies of the original array that are repeated as many times as is needed.

However, if you just apply np.resize() to the array and you pass the new shape to it, the new array will be filled with zeros.
```python
print(x.shape)

# Resize x to ((6, 4))
np.resize((6,4))

# Alternative
x.resize((6,4))
```

## Reshape
Besides resizing, you can also reshape your array. This means that you give a new shape to an array without changing its data

```
# Print the size to see what's possible
print(x.size)

# Reshape x to (2, 6)
print(x.reshape((2,6)))

# Flatten x
z = x.ravel()
```

## Append

```python
print(x, x.shape, x.size)
# array([[1, 2],
       [3, 4]])
# shape = (2,2)
# size = 4

np.append(x, [[1,2], [3,4]])
# array([1, 2, 3, 4, 1, 2, 3, 4])
# shape (8,)
# size 8

np.append(x, [[1,2], [3,4]], axis=0)
# array([[1, 2],
#        [3, 4],
#        [1, 2],
#        [3, 4]])
# shape = (4, 2)
# size = 8

np.append(x, [[1,2], [3,4]], axis=1)
# array([[1, 2, 1, 2],
#       [3, 4, 3, 4]])
# shape = (2, 4)
# size = 8
```

## Delete and Insert Array

```python
# Insert 4 at index 1
np.insert(my_array, 1, 4)

# Delete the value at index 1
np.delete(my_array, [1])
```

## Join adn Split Arrays
```python
# Concatentate `my_array` and `x`
print(np.concatenate((my_array,x)))

# Stack arrays row-wise
print(np.vstack((my_array, my_2d_array)))

# Stack arrays row-wise
print(np.r_[my_resized_array, my_2d_array])

# Stack arrays horizontally
print(np.hstack((my_resized_array, my_2d_array)))

# Stack arrays column-wise
print(np.column_stack((my_resized_array, my_2d_array)))

# Stack arrays column-wise
print(np.c_[my_resized_array, my_2d_array])
```

## Horizontal/Vertical Split
```python
# Split `my_stacked_array` horizontally at the 2nd index
print(np.hsplit(my_stacked_array, 2))

# Split `my_stacked_array` vertically at the 2nd index
print(np.vsplit(my_stacked_array, 2))
```

## Visualizing Histogram

```python

# Initialize your array
my_3d_array = np.array([[[1,2,3,4], [5,6,7,8]], [[1,2,3,4], [9,10,11,12]]], dtype=np.int64)

# Pass the array to `np.histogram()`
print(np.histogram(my_3d_array))

# Specify the number of bins
print(np.histogram(my_3d_array, bins=range(0,13)))
```

## Plotting the histogram
```python
# Import numpy and matplotlib
import numpy as np
import matplotlib.pyplot as plt

# Construct the histogram with a flattened 3d array and a range of bins
plt.hist(my_3d_array.ravel(), bins=range(0,13))

# Add a title to the plot
plt.title('Frequency of My 3D Array Elements')

# Show the plot
plt.show()
```
