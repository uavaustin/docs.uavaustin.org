# File I/O

In this section, we will explore some of the basic methods you can use in python to read and write files. 

### Opening a File

Python's built-in function ```open()``` is used to open files. The return of this function is a file object. 

```python
>>> f = open("test.txt")    # open file in current directory
>>> f = open("C:/Python33/README.txt")  # specifying full path
```

We can specify the mode while opening a file. In mode, we specify whether we want to read ```'r'```, write ```'w'``` or append ```'a'``` to the file. We also specify if we want to open the file in text mode or binary mode.

The default is reading in text mode. In this mode, we get strings when reading from the file.

On the other hand, binary mode returns bytes and this is the mode to be used when dealing with non-text files like image or exe files.

The following is how to write in text-mode: 

```python
f = open("test.txt",'w')  # write in text mode
```

### Write to File 
We will now show to write to a file using the ```'w'``` mode.

```python
with open("test.txt",'w') as f:
   f.write("my first file\n")
   f.write("This second line\n")
```
 This code creates a new file ```test.txt``` in the current working directory if the file doesn't exist. If it already exists, using mode ```'w'```, the file will be overwritten. 

 ### Reading Files
 ```python
>>> f = open("test.txt",'r')
>>> f.read()     # read in the rest till end of file
 ```

You can also read lines through a for loop:

```python
>>> for line in f:
...     print(line, end = '')
...
This is my first file
This file
contains three lines
```