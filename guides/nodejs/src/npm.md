# NPM

[`npm` (Node Package Manager)](https://www.npmjs.com) is the default package
manager for Node.js and is also used for front-end JavaScript. It has the
largest package index of any package manager for any programming language and
has packages for a ton of things. There are a couple other package managers for
Node.js such as yarn and pnpm, however, they also use the npm package index.

`npm` should have been included with your Node.js installation.

## Creating a `npm` Project

`package.json` is the file that contains the metadata about a Node.js project
for `npm`. You can create a new project using `npm init` and it will generate a
`package.json` for you. Let's go ahead and do just that.

First, we'll create a project directory and `cd` to it.

```shell
$ mkdir my-npm-project
$ cd my-npm-project
```

Now that we've created the folder and moved inside it, we'll call `npm init`.
The utility will ask a bunch of questions about our project. We'll just create
it with the default options that it suggests. Just keep hitting enter on all
the prompts.

```shell
$ npm init
This utility will walk you through creating a package.json file.
It only covers the most common items, and tries to guess sensible defaults.

See `npm help json` for definitive documentation on these fields
and exactly what they do.

Use `npm install <pkg>` afterwards to install a package and
save it as a dependency in the package.json file.

Press ^C at any time to quit.
package name: (my-npm-project)
version: (1.0.0)
description:
entry point: (index.js)
test command:
git repository:
keywords:
author:
license: (ISC)
About to write to /path/to/your/my-npm-project/package.json:

{
  "name": "my-npm-project",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}


Is this ok? (yes)
```

Great! Now we have a basic project set up. We can see the contents of the
`package.json` file in the `npm` output. Let's go over what these things mean:

- **name**: This represents the name of the package, normally this is the same
  as the name of the directory. If we were to publish this package to the `npm`
  package index, this is the name it would use.
- **version**: The version of our package.
- **description**: A short description of what our package is. This is
  displayed on npmjs.org if the package is published.
- **main**: The main JavaScript file for the the package. If we are to
  `require('my-npm-project')`, then this is the file that is loaded.
- **scripts**: This section has scripts you can call using `npm`. If we run
  `npm test` in this directory, then the `scripts.test` command will be
  executed. *In general*, to run scripts of any name you'll need to use
  `npm run <script-name>`, in this case, it would be`npm run test`. For this,
  `npm test` happens to work directly since it is a special case.
- **author**: The author of the package.
- **license**: The terms this package is licensed under. Normally this is
  accompanied with a `LICENSE` file with the terms.

There are [a bunch](https://docs.npmjs.com/files/package.json) of other fields
that can be in a `package.json`, but those are out of scope for now.

Let's get the main JavaScript file going. Create a file named `index.js` in the
`my-npm-project directory`. As an example, we can put the hello world example
in it:

```js
console.log('Hello, World!');
```

Now, if we run `node .` in this directory, it'll run our hello world script.

```shell
$ node .
Hello, World!
```

Since `index.js` is labeled at the main file in `package.json`, `node` knows
which script to run when referencing the project directory.

## Installing Dependencies

The most useful part of `npm` is to install packages. To keep it simple for
now, we'll just make our hello world script a little prettier. Let's print it
in blue letters.

To do this, we'll install the
[`chalk npm package`](https://www.npmjs.com/package/chalk). This is one of many
`npm` libraries that you can install to make it easier to work with colors in
the terminal. You can check the `npm` page to see usage instructions.

```shell
$ npm install chalk
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN my-npm-project@1.0.0 No description
npm WARN my-npm-project@1.0.0 No repository field.

+ chalk@2.4.1
added 7 packages in 1.186s
```

7 packages were installed since `npm` handled the sub-depedencies of `chalk`
itself. You can ignore the `package-lock.json` file it created.

Now we'll go ahead and use it. In our `index.js` file, we'll need to `require`
the `chalk` library. Afterwards, we'll use chalk to make our text blue.

```js
const chalk = require('chalk');

console.log(chalk.blue('Hello, World!'));
```

Now when running `node .`, we have color!

> *Note:* If you're on Windows, colors might not work. You can get around this
> by either using git bash to run the script, or checking
> [this page](https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences)
> on how to enable this in `cmd.exe` on Windows 10. It's not too important for
> this example.

The `package.json` file as been updated to include the dependencies now:

```json
{
  "name": "my-npm-project",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "chalk": "^2.4.1"
  }
}
```

Running `npm install` without a package name will install all the depedencies
listed in the `package.json` in that directory.

> *Note:* There is another section of dependencies called `devDependencies`.
> These are for packages that are required when building or testing the
> packages' contents, but aren't actually required inside the source code at
> runtime. You don't need to worry about it now, but when building real `npm`
> libraries you'll need to differeniate them. They are not installed when
> installing packages with `npm install --production`.

## Installing Packages Globally

Instead of installing a dependency for a specific project, you can also install
one into the global scope so that you can use a command anywhere.

For instance, we'll try out the
[`http-status-cli` package](https://npmjs.org/http-status-cli). This is a
little package that can print out what the meanings of HTTP status codes like
404 mean.

To install it, we'll just need to use `npm` like normal but with the `-g` flag
for global.

```shell
$ npm install -g http-status-cli
```

And now in the terminal you can use the globally installed package to find out
what 404 or any other code means.

```shell
$ http-status 404
404 - Not Found
  The best known of them all, the 404 status code indicates that the requested r
esource was not found at the URL given, and the server has no idea how long for.
$ http-status 201
201 - Created
  A 201 status code indicates that a request was successful and as a result, a r
esource has been created (for example a new page).
```

`npm` makes installing command-line utilities convenient. There are a bunch out
there.
