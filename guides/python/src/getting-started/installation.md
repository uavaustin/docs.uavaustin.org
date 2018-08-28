# Installation

Before we can do anything, we'll need to get Python installed on your machine.
You might already have Python 2 or an older version of Python 3 installed.
Though for this guide and for most UAV Austin code, Python 3 is required.

> *Note:* Throughout the guide there are references to terminal commands. Lines
> that you enter start with a `$`. You don't actually need to type the `$`, it
> is simply shown for convenience.

## Installing Python

Follow the guide for your system to install the latest version of Python 3. At
the time of writing, this is Python 3.7.0.

### Windows

Go the [Python installation page](https://www.python.org/downloads/windows/)
and click on the link for the latest Python 3 release. At the bottom of the
next page you should be able to find the *Windows x86-64 executable installer*.

During installation, if prompted, *make sure to check the box indicated that you
want Python added to your PATH*.

> *Note*: If the terminal is reporting that the `python` command cannot be
> found, either you did not install Python, or it is not on your PATH. You can
> try `python --version` in PowerShell instead to see if that is successful.

### macOS

For macOS installation, we'll be using [Homebrew](https://brew.sh).

If you already have Homebrew installed, you can skip down to where Python is
being installed with `brew`.

Before installing Homebrew, you'll need to install the XCode command-line
tools.

```shell
$ xcode-select --install
```

To fetch Homebrew and put it on your path for immediate usage, run the
following:

```shell
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$ export PATH=/usr/local/bin:/usr/local/sbin:$PATH
```

Now, to get Python 3 you can simply use `brew` to install it.

```shell
$ brew install python3
```

Homebrew keeps it's Python 3 bottle fairly up to date.

### Linux

> This section assumes an debian-like system using `apt`. If this is not
> applicable, you might need to adapt these instructions for your own package
> manager and/or system.

For Linux, we'll need to build from source since the package managers currently
use older Python versions. This might take a while.

At the time of writing, the latest stable Python is 3.7.0. The installation can
be adapted for newer versions.

- Update apt.

  ```shell
  $ sudo apt update
  ```

- Get the GCC toolchain and other build dependencies.

  ```shell
  $ sudo apt install build-essential
  ```
  
  Install Python prerequites.

  ```shell
  $ sudo apt install    \
      libssl-dev        \
      zlib1g-dev        \
      libncurses5-dev   \
      libncursesw5-dev  \
      libreadline-dev   \
      libsqlite3-dev    \
      libgdbm-dev       \
      libdb5.3-dev      \
      libbz2-dev        \
      libexpat1-dev     \
      liblzma-dev       \
      libffi-dev        \
      uuid-dev          \
      tk-dev
  ```

- Fetch the Python source and decompress.

  ```shell
  $ wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz
  $ tar xf Python-3.7.0.tar.xz
  ```

- Build from source.

  ```shell
  $ cd Python-3.7.0
  $ ./configure
  $ make -j8
  ```

- Install. If you wish to not replace your current `python3` installation in
  your path, then use `sudo make altinstall` instead. If using this method, you
  will need to refer to this version of Python as `python3.7`.

  ```shell
  $ sudo make install
  ```

> In the case that building from source is too troublesome, you can simply
> install Python with `sudo apt install python3 python3-pip`. This version
> might be somewhat outdated and could cause some compatability problems down
> the road. However, it will suffice for the short-term.

## Verifying your Installation

To verify that your Python installation was successful, open up your terminal
and run the following:

```shell
$ python --version
```

This should print out the version you installed above. If this printed out a
Python 2 version because of a pre-existing installation, or did printed that
this was not a valid command, you might need to specify to use Python 3. For
that, use `python3` or `python3.7` instead as your Python command.

```shell
$ python3.7 --version
```
 
The above is more gauranteed to work with multiple Python installations.

## Text Editors

Having a decent text editor helps a bunch in development.

There are a bunch of great text editors to use. A good short list is the
following:

- [Sublime Text](https://www.sublimetext.com)
- [Atom](https://atom.io)
- [VS Code](https://code.visualstudio.com)

Everyone has their own favorite, but each of these are solid choices to go
with. VS Code tends to be the most fully featured of these three.

Before moving forward, I'd recommend at least installing one of these.

If you'd like to use an IDE, [PyCharm](https://www.jetbrains.com/pycharm) is a
popular Python IDE. It is recommended to still have a general purpose text
editor.
