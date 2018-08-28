# Control Flow

Python has fairly simple control flow to make up the basics of the programming
language.

This section does not use the `>>>` characters to indicate input in the
interpreter.

## `if` Statements

Python has an indentation-styled syntax. Instead of using traditional C-style
`if` statements:

```c
if (condition) {
    // statements
}
```

Python `if` statements are formatted as:

```python
if condition:
    # Statements
    print('hello')
```

`if` statements, as well as the other control flow mechanisms in Python require
statements to be inside. To have an `if` statements without any block to run,
you'll need to use the `pass` keyword.

Thus, the above can be written without the `print('hello')`:

```python
if condition:
    pass
```

> *Note*: It's not good to mix tabs and space characters in Python because of
> the fact that indention matters. To make it simple, use 4 spaces for
> indentation.

`if` statements can be followed by `elif` to check more conditions and an
`else` block to run if no other conditions are true.

```python
# A basic if/else.

if False:
    print('1')
else:
    print('2')

# 2 is printed.
```

```python
# An example with remainders.

num = 100

if num % 3 == 0:
    print('Divisible by 3.')
elif num % 5 == 0:
    print('Divisible by 5.')
else:
    print('Not divisble by 3 or 5.')
```

## `for` Loops

> // TODO

## `while` Loops

> // TOOD
