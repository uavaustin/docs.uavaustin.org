# Data Types and Variables

In this chapter we'll cover making variables with different basic data types in
Python.

These examples are best done in the Python interpreter. You can start this like
in the first part of the
[Hello World Chapter](../getting-started/hello-world.md) with `python` (or
`python3` or `python3.6`) in your terminal. Lines that start with `>>>` are
intended to be typed into the interpreter.

## Numbers

Python has both floats and integers. Floats are double-precision IEEE 754
numbers.

Basic numeric operations return the value in the interpreter. Here's an example
of adding and subtracting numbers.

```python
>>> 1 + 2
3

>>> 66 - 67
-1
```

Multiplication and division are what you might expect.

```python
>>> 2 * 5
10

>>> 5 / 2
2.5
```

In Python, regular division will always return a `float`. To get integer
division, use the `//` operator.

```python
>>> 4 / 2
2.0

>>> 7 // 2
3
```

> *Note*: In Python 2, `5 / 2` will evaluate to `2` since by default, integer
> divison will truncate. Python 3 will give `2.5`.

The `%` operator gives a remainder after division.

```python
>>> 17 % 12
5
```

You can use also `**` to raise values to a power.

```python
>>> 3 ** 2
9
```

Standard mathematical order of operations is respected. To deviate from that,
or clarify the meaning of an expression, you can use parentheses.

```python
>>> 4 * 5 + 2 * 3
26

>>> (4 * 5) + (2 * 3)
26

>>> 4 * (5 + 2) * 3
84
```

These expressions can be assigned to variables. Variables in Python do not need
to be declared ahead of time, nor do they require types to be labeled. Once a
variable is assigned a type, it can be reassigned to a value, even of a
different type. Python convention is to give variable names in `snake_case`.

```python
>>> a = 5
>>> a  # A variable by itself will make the interpreter print it.
5

>>> print(a)  # We can use the print function to print it too.

>>> print(b)  # This variable doesn't exist!
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'b' is not defined

>>> a = 6.5
>>> a
6.5
```

If we assigned a variable equal to another variable which is a number, then
changing the original won't change the new one.

```python
>>> a = 2
>>> b = a
>>> a
2

>>> b
2

>>> a = 3
>>> a
3

>>> b

2
```

We can add and update values with `+=`.

```python
>>> c = 7
>>> c += 5
>>> c
12
```

Similarly, you can use `-=`, `*=`, `/=`, `//=`, `%=`, `**=` for the same
behavior with the other mathematical operators. 

> *Note:* `++` is not an operator in Python like in many other languages,
> you'll need to use `+= 1`.

To convert a value from a `float` to an `int`, or vice-versa, you can do the
following:

```python
>>> int(4.6)  # This will round down (truncate)
4

>>> float(2)
2.0
```

## Booleans

Boolean values in Python can either be `True` or `False`.

Naturally, you can directly assign these to a variable.

```python
>>> is_lucky = True
```

The `not` operator will return the opposite boolean value.

```python
>>> not is_lucky
False
```

The comparison and equality operators will return boolean values. These are
`<`, `<=`, `>`, `>=`, `<=`, `==`, and `!=`.

```python
>>> 7 > 4
True

>>> 3 <= 3
True

>>> 8 < 3
False

>>> 55 == 55.0  # We can still compare ints and floats.
True

>>> 67 != 67
False
```

`and` and `or` are the logical AND and OR.

```python
>>> True and True
True

>>> True and False
False

>>> True or False
True

>>> False or False
False
```

## Strings

Strings contain textual data. They can be enclosed in either single or
double-quotes. Strings can also span multiple lines when starting or ending
with either three single or double-quotes. UAV Austin convention prefers the
use of single-quotes for normal strings, and double-quotes for multi-line
strings.

```python
>>> status = 'hungry'
>>> animal = """
hippos
"""
```

Strings can be concatenated together using `+`.

```python
>>> game = status + animal
>>> print(game)
hungry
hippos
```

Since the hippos multi-line string has a newline after the first three
double-quotes, it is kept when concatenating strings.

Note that numbers cannot be immediately concatenated to strings. They must be
converted to strings first!

```python
>>> 'My fav # is ' + 37
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: can only concatenate str (not "int") to str

>>> 'My fav # is ' + str(37)
'My fav # is 37'
```

Strings can even be multipled to make them repeat.

```python
>>> print('HeadOn. Apply directly to the forehead.\n' * 3)
HeadOn. Apply directly to the forehead.
HeadOn. Apply directly to the forehead.
HeadOn. Apply directly to the forehead.
```

As you can see, we can escape newlines with `\n`. And yes, the
[HeadOn commercials](https://www.youtube.com/watch?v=Is3icfcbmbs) are the
worst.

## None

`None` is used in Python for the absence of a value. This is often called
`null` or `nil` in other languages. `None` can be assigned to variables.

```python
test = None
```

Note that you cannot use numeric operators with `None`, just like how strings
are strict about what you can add with them. Even though Python is dynamically
typed, i.e., you don't need to know the type of variables at runtime, it is
still strongly typed. This means that operators are designed to take values of
consistent types. Expressions such as `3 < None` do not have meaning in Python
and will throw errors.

## Lists and Tuples

Lists and tuples both can be used to hold a collection of values.

### Lists

Lists can be created with square brackets. The following is a simple list of
things:

```python
>>> my_list = [55, 'hello', None, 'cheese']
```

As you can see, lists can be composed of different types.

Lists can also have lists inside them:

```python
>>> another_list = [1, 2, 3, [4, 5, 6]]
```

Lists are zero-indexed. You can index them using square brackets as well.

```python
>>> my_list[1]
hello
```

Indicies can also be negative (where `-1` is the last element) and you can
slice a list as well.

```python
>>> my_list[-2]
None
```

```python
>>> my_list[2:]
[None, 'cheese']

>>> my_list[1:3]
['hello', None]

>>> my_list[::-1]
['cheese', None, 'hello', 55]
```

[See here](https://stackoverflow.com/a/509295) for a more in-depth description
of slices.

### List Operations

`len` returns the length of a list:

```python
>>> len(my_list)
4
```

You can use the `+` operator to add lists together to make a new list.

```python
>>> my_list + another_list
[55, 'hello', None, 'cheese', 1, 2, 3, [4, 5, 6]]
```

`in` will check if an item is in a list.

```python
>>> 55 in my_list
True
```

`not in` does the opposite.

```python
>>> 55 not in my_list
False
```

You can reassign an element of a list.

```python
>>> my_list[2] = 'a new value!'
>>> my_list
[55, 'hello', 'a new value!', 'cheese']
```

`del` can remove an element.

```python
>>> del my_list[1]
>>> my_list
[55, 'a new value!', 'cheese']
```

There are a bunch of methods you can use on lists as well. See the
[data structures page](https://docs.python.org/3.6/tutorial/datastructures.html)
in the offical Python tutorial for more details.

### Tuples

Tuples are similar to lists, except that they cannot be modified after they are
created. Elements inside a tuple can still be mutated, however.

Tuples are created with parenthesis instead of square brackets.

```python
>>> a = (1, 2, 'hey')
>>> a
(1, 2, 'hey')
```

The same operators such as indexing, `len`, `in`, and `+` still work on tuples,
however, you cannot add or remove elements with a tuple.

## Dictionaries

Dictionaries use key-value pairs to store elements.

```python
>>> person = {
        'Name': 'PersonFace McGee',
        'Likes': ['memes'],
        'Dislikes': ['their name']
    }
>>> person
{'Name': 'PersonFace McGee', 'Likes': ['memes'], 'Dislikes': ['their name']}
```

The syntax for accessing elements, updating, and deleting elements works
similarly to lists.

```python
>>> person['Name']
'PersonFace McGee'

>>> person['Name'] = 'Something Better'
>>> person
{'Name': 'Something Better', 'Likes': ['memes'], 'Dislikes': ['their name']}

>>> del person['Dislikes']
>>> person
{'Name': 'Something Better', 'Likes': ['memes']}
```

As with lists, there's methods you can use with dictionaries. See the
[data structures page](https://docs.python.org/3.6/tutorial/datastructures.html)
in the offical Python tutorial for more details as well.
