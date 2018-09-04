# Functions

Functions are neat things. Let's do those.

## A Basic Function

Here's a basic case of wrapping our hello world example into it's own function.

```python
def say_hello():
    print('Hello, World!')

# Call the function.
say_hello()
``` 

`def` in Python is used for defining functions!

If you either save this to a file and run the script, or run this in the
interactive Python session on the command-line, you'll get the same print out
as before.

> *Note:* The convention in Python is to use `snake_case` naming for functions
> and variables.

The function above has no return value! It's just is printing something out.
Use `return` to return a value like in t

## Arguments

Let's take our example above, but be able to say hello to specific people.
We'll take an argument `person` and print that like *Hello, Joe!*, for example.

```python
def greet(person):
    # Using the string format method to insert the name!
    print('Hello, {:s}!'.format(person))

# Prints out 'Hello, Joe!'
greet('Joe')
```

## Keyword Arguments

Let's make a power function. This'll compute values like \\( 5 ^ 3 \\).

```python
def pow(base, exp):
    return base ** exp

num = pow(5, 3)
print(num)  # 125
```

In the above we can see that in the function, `base` is assigned to `5` and
`exp` is assigned to `3`. At the end we return the value so that we can assign
the variable `num` from the result.

...But what if we wanted to put the exponent first and the base second?

Regular arguments entered into a function are what we call *positional
arguments*, but we can label which argument is which with *keyword arguments*.

Note that keyword arguments can only be entered after all the positional
arguments.

Here's how we can flip the arguments:

```python
num_2 = pow(exp=5, base=3)  # 3 ^ 5 = 243
```

And you can mix them together (note that keyword arguments can only be entered
after all the positional arguments):

```python
num_3 = pow(5, exp=3)  # 125
```

## Default Arguments

Using a similar notation to putting keyword arguments in the function calls
like in the above, we can give the arguments of a function default values.

For the power example, we'll define another `pow` function but this time make 
the exponent default to 2.

```python
def pow_2(base, exp=2):
    return base ** exp

num_4 = pow_2(5)     # 25
num_5 = pow_2(5, 3)  # 125
```

And, of course, you can use keyword arguments when you call a function with
default values, but you don't have to pass it if you don't want to.
