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

Python `for` loops are like for-each loops in other languages. A block is run
multiple times with each element in an iterable object. Let's use an easy
example:

```python
# Print the numbres from 0 to 9. 10 is an exclusive upper bound!
for i in range(0, 10):
    print(i)
```

Similarly, we can also use lists:

```python
aliases = ['yes', 'yeah', 'ye', 'mhmm', 'aye', 'yep']

# Print out a bunch of ways to say yes.
for alias in aliases:
    print(alias)
```

> *Note*: The `range` function in Python returns a *range* object, which for
> all intents and purposes, is like an iterator. Essentially, iterators keep
> producing values when asked. So in this case, after the loop finishes a
> block, another value is being extracted from `range`.
>
> Back in the days of Python 2 (yes, I know, gross), `range` used to return a
> list directly. This can have some performance problems since you don't need
> to create all the elements you need ahead of time if you're not even going to
> use them. To convert a *range* to a list like in the first example you can
> use `list(range(0, 10))`.

## `while` Loops

`while` loops repeat a block while a condition is `False`.

Here's an example:

```python
text = ''

# Just keep asking the user to type in 1.
while text != '1':
    text = input('Please enter the number one: ')

print('Okay, thanks.')
```

The `input` function prompts a user to type something in and then hit enter.

To run the example above you'll need to place this in a file and run it like
in the second part of the
[Hello World Chapter](../getting-started/hello-world.md).

> *Note*: The above example won't actually work in Python 2, since the `input`
> function coerces numbers into `int` types instead of leaving all input as
> strings like in Python 3. If the example isn't working. You might be using
> Python 2.

Hopefully you can think of better uses of `while` loops.

## `break` and `continue`

`break` and `continue` can be used to alter the flow of a `for` or `while`
loop.

`break` will cause the loop it is in to stop.

```python
a = 1

# Keep looping until stopped manually.
while True:
    # Increment the number by 2.
    a += 2

    # Stop when it's 9.
    if a == 9:
        break

# This should print 9.
print(a)
```

`continue` skips the rest of the loop and makes the loop go to the next
iteration.

```python
# Loop through even values from 2 to 20.
for i in range(2, 21, 2):
    # Skip if this is a multiple of 6.
    if i % 6 == 0:
        continue

    print(i)

# The numbers 2, 4, 8, 10, 14, 16, and 20 are printed above.
```

Note that for nested loops, `break` and `continue` apply to the inner-most
loop.

## `for` ... `else` and `while` ... `else`

These two constructs are rare in Python. However they're included here in this
chapter for completeness.

The `else` block on a `for` or `while` loop is run if the *loop did not
`break`*, i.e., if the loop was able to run all the way through and finish on
its own without needing the `break` statement.

See the following example:

```python
# Some cool things out there.
cool_things = ['ice cream', 'Antarctica', 'BoJack Horseman',
               'the emoji with the face wearing sunglasses']

# The things we want to find something cool in.
things = ['fire', 'Rick and Morty', 'other emojis']

# Go through each item and print out the first item that is cool.
for thing in things:
    if thing in cool_things:
        print(thing + ' is cool.')
        break
else:
    print('Nothing was cool. :/')
```

In the above, since none of the items in `things` are in `cool_things`, the
loop will never print out anything and break, so then, the `else` block will
say that nothing is there. If you add in an item from `cool_things` into
`things` then the `else` block won't run.

This is the typical use case of a `for` ... `else` or `while` ... `else`: to
handle when something wasn't found and the loop wasn't stopped on a successful
case.

Use this sparingly.

## `try` ... `except` Statements

`try` ... `except` blocks allow for code that might fail to execute.

Errors can be thrown with the `raise` keyword.

```python
try:
    raise ValueError('This is not going to work')
except ValueError:
    print('an error was thrown')
```

In the above, we only handle an exception if it is of type `ValueError`. If the
exception was not a `ValueError`, that block would not run and the exception
would go up to the scope the `try` ... `except` is in. Make sure to use the
correct exception for the use case instead of raising a general `Exception`.

You can chain multiple `except` blocks to handle different types of exceptions.

You can also use `as` to keep the exception object for use in the `except`
block.

```python
try:
    raise ValueError('This is not going to work')
except ValueError as e:
    print(e)
```

The above simply prints out the error.

The `finally` block can be attached for code to execute regardless of what
happens in the `try` or `except` block. This is good for cleanup open
resources.

```python
try:
    # Can't do this.
    bad_math = 1 / 0
except ValueError:
    # This won't run since the above is going to raise a
    # ZeroDivisionError.
    print('will not run this block')
finally:
    # The error will still propagate up, but we can print something
    # out before that happens.
    print('Watch out: exception incoming!')
```

## List Comprehensions

In a normal imperative way, we can build up the elements of a list using a
`for` loop. Let's say we want to make a list of the squares of 1 to 10. The
most obvious way is this:

```python
squares = []

for i in range(1, 11):
    squares.append(i ** 2)
```

We just keep appending the square of each number from the `for` loop to the end
of the loop.

Another way of approaching this is to use Python *list comprehensions*. These
effectively allow you to build lists with `for` loops in an inlined way.

For the squares example, we can do that with the following list comprehension:

```python
squares = [i ** 2 for i in range(1, 11)]
```

The expression on the left goes in as each element of the list, and the loop
logic goes after inside the list brackets.

Use list comprehensions for simple things. A good rule is that a list
comprehension that needs to wrap onto the next line is too long.
