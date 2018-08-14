# Installation

The first step is to get Node.js on your system. We'll download Node.js for
Linux and macOS using `nvm`, and for Windows, the similar `nvm-windows`. After,
we'll make sure the `node` command works from the terminal, and that we have a
text editor to work with to get our hello world going in the next chapter.

> *Note:* Throughout the guide there are references to terminal commands. Lines
> that you enter start with a `$`. You don't actually need to enter it, it is
> simply shown for convenience. `>` is used for a Windows-specific section.

## Installing Node.js

Follow the guide for your system to get going.

### Windows

Follow the
[installation instructions for `nvm-windows`](https://github.com/coreybutler/nvm-windows#installation--upgrades).

Afterwards, run `nvm version` in Command Prompt or PowerShell to confirm that
`nvm-windows` has been installed.

Next, fetch the list of currently available Node.js versions that can be
installed.

```shell
> nvm list available
```

Install the latest version of Node.js 8. Substitute the most recent version you
see from the command above.

```shell
> nvm install 8.x.x
```

Next, run the command prompted to make this your current Node.js version.

```shell
> nvm use 8.x.x
```

To test that our install works, run the following:

```shell
> node --version
> npm --version
```

At the time of writing, I get the Node.js version `v8.11.3` and NPM `v5.6.0`.
Yours might be more recent.

If you're having difficulties installing with this method, you can try
installing Node.js directly from the installers on nodejs.org.
[See here.](https://nodejs.org/en/download/)

### macOS and Linux

*The installation here is taken from the
[`nvm` installation guide](https://github.com/creationix/nvm#installation)*.

The first step is to install the most recent version of `nvm` (Node Version
Manager). `nvm` allows for the easy installation and switching of Node.js
versions.

```shell
$ curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
```

Next, we'll clone the `nvm` repository to `~/.nvm` and make sure it is loaded
to your profile.

```shell
$ export NVM_DIR="$HOME/.nvm"
$ [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

Now we'll install Node.js.

This guide is based on Node.js 8. At the current time of writing, this is the
recommended version of Node.js. We'll install the latest version of Node.js 8
using `nvm`. This will also set your default version. (Carbon is the name for
the Node.js 8 LTS.)

```shell
$ nvm install lts/carbon
```

To test that our install works, run the following:

```shell
$ node --version
$ npm --version
```

At the time of writing, I get the Node.js version `v8.11.3` and NPM `v5.6.0`.
Yours might be more recent.

If you're having installation problems, see the `nvm` guide linked at the top
of this subsection for help.

## Text Editors

Instead of using IDEs, the recommended way to get started with Node.js is with
a terminal and a text editor. In UAV Austin development, especially with
certain repositories, a lot of of things will need to be done by the
command-line.

There are a bunch of great text editors to use. A good short list is the
following:

- [Sublime Text](https://www.sublimetext.com)
- [Atom](https://atom.io)
- [VS Code](https://code.visualstudio.com)

Everyone has their own favorite, but each of these are solid choices to go
with. VS Code tends to be the most fully featured of these three.

Before moving forward, I'd recommend at least installing one of these.
