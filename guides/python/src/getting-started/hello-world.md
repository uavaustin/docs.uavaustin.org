# Hello World

Our first touch of Python will be a hello world example.

We'll do it two different ways.

## Interactive Python

The easiest way to get started with Python is messing around in the
interactive command-line shell.

Go ahead and open a terminal and type in `python`. You should see a prompt come
up on the left. Anything you type here is evaluated in real time.

To print out `Hello, world!` go ahead and execute the following:

```python
print('Hello, world!')
```

To exit the shell, enter `exit()`.

Your output should look like the following (though some data on the top might
be different for your system):

```text
Python 3.7.0 (default, Aug 27 2018, 13:03:14)
[Clang 9.0.0 (clang-900.0.39.2)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> print('Hello, World!')
Hello, World!
>>> exit()
```

> *Note*: If the Python version printed at the top of the shell is for
> Python 2. You'll need to use `python3` on the command-line instead of
> `python` from here on out.

## Running from a File

The more useful way to run this is to create a script and run it from the
command-line.

Create a file called `hello_world.py` with your favorite text editor. In my
case, I'll create it on my desktop so it is easy to find. The file contents
should read just as before:

```python
print('Hello, world!')
```

Navigate to the directory in your terminal that the file is in, and run
`python hello_world.py` to run the file. The output should be the same.

> If you're not sure how to change directories to where the file is, you might
> want to read up on how to do basic terminal commands.
> [Here's an example article.](https://lifehacker.com/5633909/who-needs-a-mouse-learn-to-use-the-command-line-for-almost-anything)
