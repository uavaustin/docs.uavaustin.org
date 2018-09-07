# Modules

Instead of starting this chapter with a snarky comment, we'll go straight into
this topic.

From time to time, naturally you're going to need to access Python code written
in a different file.

## Working with Pi

While you could hardcode the value of pi in every Python file you
create, it's not exactly the most practical thing to do. So we'll need to
*import* it. This will show several ways pi can be imported.

The most basic way is to import the entire
[`math` module](https://docs.python.org/3.6/library/math.html) of Python.

```python
import math

print('The value of pi is: {:.10f}'.format(math.pi))
```

> *Note*: This is using the Python 3 string formating function. This
> is similar to how you would do it in many languages with `sprintf`
> or like, except that instead of using percent signs, you place the
> formatting string inside curly braces with a colon before it. See
> [the Python documentation](https://docs.python.org/3.1/library/string.html#format-examples)
> for examples.

This will allow you to use anything in the `math` module as well. So we can do
this:

```python
cos_pi = math.cos(math.pi)
print('The value of cos(pi) is: {:.10f}'.format(cos_pi))
```

We don't really need to import *everything* in the `math` module. So we can
also just import only pi. We won't be able to access `math.cos` with this. This
also 

```python
from math import pi

print('The value of pi is stills: {:.10f}'.format(pi))

math.cos(pi)  # This will error!
```

As an aside, you can import a module directly and do an `from` ... `import` on
a module.

This is valid (though strange):

```python
import math
from math import pi

print('The value of pi is stills: {:.10f}'.format(pi))

math.cos(pi)  # Fine now.
```

> *Note*: You can import multiple things at the same time like
> `from math import pi, cos`, though importing too many things in a file like
> this can make it difficult to trace where certain functions are coming from.

## Aliasing Imports

For some libraries, there's conventions for renaming them to a shorter name.

Let's take `numpy` for example. This is a popular Python library that does fast
numerical operations in Python. (You have to install this since it's not
included by default in Python. We'll discuss how to do this later, but if
you're feeling brave you can just execute `pip3.6 install numpy` in your
terminal to install the package. You can also just take this example for
granted.)

To rename an import, you can use `as`.

```python
import numpy as np

# This will print:
#   array([ 0. ,  0.1,  0.2,  0.3,  0.4,  0.5,  0.6,  0.7,  0.8,  0.9,  1. ])
#
# Note that this is a numpy array instead of a regular Python list.
print(np.arange(0.0, 1.1, 0.1))
```

`numpy` is often shortened because of how often it is used. When a project uses
`numpy` it is common to use it a ton.

You can mix the `as` syntax with `from` and do something like
`from math import pi as pie` if you'd really want to.

Aliasing imports comes with a warning: *Don't alias something unless there's an
established convention (like `numpy`) or unless you need to since another name
is conflicting in the same file.* Using strange aliases in a file can make it
very confusing for other programmers to read!

## Your Own Modules

Now it's time for the opposite point of view. How do we make modules that we
can use?

Let's start with a sample directory setup inside a folder called
`modules_intro/`:

```text
modules_intro
├── __init__.py
├── __main__.py
├── one.py
├── two.py
└── nested
    └── three.py
```

So what are all these files for?

- `one.py` and `two.py` are just two normal Python modules. Nothing special
  here.
- `three.py` is a Python module inside a nested directory. This makes importing
  a little different.
- `__init__.py` and `__main__.py` are special module names that we'll talk
  about in a bit.

### Starting with `one.py`

For our first module, we'll just do something simple.

Note the docstring syntax for giving a function documentation using a
multi-line string.

```python
# one.py

def get_numbers(upper):
    """Return all the integers from 0 to a limit, inclusive.

    This is simply creating a range and then converting this into a
    list.
    """

    return list(range(0, upper + 1))


# Prints [0, 1, 2, ..., 10].
print(get_numbers(10))
```

This is straight-forward enough. If we are to run
`python3.6 modules_intro/one.py` then the numbers will be printed out. Make
sure that your current directory is the one that the `modules_intro/` folder is
inside.

Let's try something though: if you open up an interactive python session and
import the `one.py` module, it'll print out the numbers when you import!

```text
$ python3.6
>>> import modules_intro.one
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
>>> modules_intro.one.get_numbers(4)
[0, 1, 2, 3, 4]
```

So that's not great at all. But we can see above that when we import the file,
since it's inside the `modules_intro` folder, we just need to put a period to
go down into the directly (and the `.py` extension is removed).

Now let's keep the behavior of being able to run the file directly, but still
be able to use our `get_numbers` function inside `one.py`. To do this, we have
to put the `print(get_numbers(10))` inside an `if` statement that can check if
the file is the *main* file or not:

```python
# one.py

def get_numbers(upper):
    """Return all the integers from 0 to a limit, inclusive.

    This is simply creating a range and then converting this into a
    list.
    """

    return list(range(0, upper + 1))


if __name__ == '__main__':
    # Prints [0, 1, 2, ..., 10] only when run directly.
    print(get_numbers(10))
```

> *Note*: Things beginning and ending with double underscores are special in
> Python!

Now both running `module_intro/one.py` and importing it do what we want.

```text
$ python3.6 modules_intro/one.py
[0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

$ python3.6
>>> import modules_intro.one
>>> modules_intro.one.get_numbers(4)
[0, 1, 2, 3, 4]
```

When dealing with multi-file projects, or making a Python file that you might
want to use more in the future, it's great to put the block of code you want to
execute at runtime in an `if __name__ == '__main__':`.

> *Note*: Many like to make a *main* function as well and make the *if main*
> part just be a wrapper for that:
>
> ```python
> def main():
>     # Our main function logic...
>     pass
>
>
> if __name__ == '__main__':
>     main()
> ```

### Using `one.py` in `two.py`

Let's go to the next module, which is just in the same directory as `one.py`.

Now, before we saw that to import `one.py` from the outside, we just did
`import module_intro.one`. Importing a file in the *same* directory is a bit
different.

In `two.py` we'll have a simple factorial implementation, and a function that
returns the factorial of numbers up to a value. For the second, function, we'll
use the `get_numbers` function. Our factorial implementation is intended to be
private and not used outside the module.

```python
# two.py

from . import one


# By convention, private functions start with an underscore.
def _fac(n):
    if n == 0:
        return 1
    else:
        return n * _fac(n - 1)


def get_fac(upper):
    """Return integer factorials up to and including a limit."""
    return [_fac(i) for i in one.get_numbers(upper)]
```

So to import an entire module from the same directory, we import the module
name from `.`. Remember that `.` represents the current directory.

Of course, we can test this with an interactive Python session:

```text
$ python3.6
>>> import modules_intro.two
>>> modules_intro.two.get_fac(6)
[1, 1, 2, 6, 24, 120, 720]
```

### Going into the Nested Folder with `three.py`

Now we'll move into the nested folder in `modules_intro/nested/three.py`. For
this file we'll make a function that returns the sum of the factorials for a
number and below:

\\[ \text{fac_sum}(n) = \sum_{i = 0}^{n}{i!} \\]

```python
# three.py

from ..two import get_fac


def fac_sum(n):
    """Return the sum of the factorials up to and including a value.

    This justs the built-in sum function in Python to do the work.
    """

    return sum(get_fac(n))
```

In the above we can see that we use a `from` ... `import` to import the
`get_fac` function directly. `..` is the directory above, and we can put the
module name after that to be able to import `get_fac` out of it.

### Making the Directory Work Like a Module with `__init__.py`

So to use our `get_fac` function from the outside, we'd have to import it all
way as `modules_intro.nested.three.get_fac`
(or `from modules_intro.nested.three import get_fac`). Well, this is
ridiculous, especially considering this is the highest level function.

So what we can do is create a special file called `__init__.py` inside our
directory. This allows for some custom behavior when we want to use our folder
as a Python module. This file essentially represents the directory.

Let's create it and import the `fac_sum` function:

```python
# __init__.py

from .nested.three import fac_sum
```

So if we open up a Python interpreter we can now use it without having to go
down deep where `fac_sum` is defined.

```text
$ python3.6
>>> import modules_intro
>>> modules_intro.fac_sum(10)
4037914
```

This is a little bit of a weird behavior. Things in a Python module are
accessible from the outside, including imports. We can use this to be able to
lift functions and classes and whatnot to the top level.

While you can use `__init__.py` as a simple thing that lifts up the
definitions, some libraries use it to actually define a lot of there functions
and whatnot there. It's a matter of style really.

### Giving our Module an Entrypoint with `__main__.py`

We know how to run a regular Python script... but how do you run a directory?
Since we can make a directory work like a module with `__init__.py` will that
run if we do `python3.6 modules_intro`? The short answer is no, but we can use
another special file name to make this kind of setup work: `__main__.py`.

As you might expect, `__main__.py` is a file that runs when you run a module
from the command-line. As an example, we can just use the following contents
to print out the sum of `fac_sum(10)`:

```python
# __main__.py

from . import fac_sum


print(fac_sum(10))
```

So now we can run try to run `modules_intro` from the command-line:

```shell
$ python3.6 modules_intro
python3.6 modules_intro
Traceback (most recent call last):
  File "/path/to/.../python3.6/runpy.py", line 193, in _run_module_as_main
    "__main__", mod_spec)
  File "/path/to/.../python3.6/runpy.py", line 85, in _run_code
    exec(code, run_globals)
  File "modules_intro/__main__.py", line 3, in <module>
    from . import fac_sum
ImportError: attempted relative import with no known parent package
```

...So we need to do one more thing. Python doesn't like this at all. What you
actually need to do to run this is to pass the `-m` flag on the command-line
which indicates that you are running a module. Why the error appears above is
kind of complicated because Python has a convoluted import system, but just
trust me on this.

```shell
$ python3.6 -m modules_intro
4037914
```

You can make this more exciting if you were to ask for input for the number, or
even better, to accept it as a command-line argument, though this is just a
simple example.

> *Note*: The `-m` flag extends more to just a module in your current
> directory: it also extends to any module in Python. For example, you run
> `pytest` (a popular Python testing framework) this way. This can resolve
> problems for when you have the same thing installed across multiple Python
> versions, e.g., `python3.6 -m pytest` and `python3.5 -m pytest` will allow
> both to work, when one of the versions will shadow the other when just using
> `pytest`.
