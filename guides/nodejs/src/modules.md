# Modules

Programming is pretty difficult when you can only use one file. Let's change
that. This chapter introduces Node.js modules.

## CommonJS `require(...)`

CommonJS refers to the style of module loading most prevalent in Node.js.

As opposed to using something like an `import` statement at the top of a file,
modules in Node.js are typically loaded using  the `require(...)` function.
This function returns the entire contents of a module.

> *Note*: There are some other systems in use. You can also
> [build modules for Node.js in C++](https://nodejs.org/docs/latest-v8.x/api/addons.html#addons_c_addons)
> and `require` them as well. These can be *painful* to write so don't get too
> excited about using C++ with Node.js.

For this chapter, we'll use the
[`path` module](https://nodejs.org/dist/latest-v8.x/docs/api/path.html#path_path)
in Node.js. Too see the modules that Node.js offers, see the
[API Documentation](https://nodejs.org/dist/latest-v8.x/docs/api/).

Now for a simple example of using `require(...)`:

```js
// We have to assign the module to a variable. In theory, we can name
// it whatever we want. This is a constant since we don't plan to
// re-assign this value.
const path = require('path');

// A common thing to do in the path library is to build up a full
// path by parts. You can do that using path.join(...). Remember that
// the .. pattern goes up a directory.
let fullPath = path.join('a/b/c', '../d', 'cool-file.txt');

// Prints a/b/d/cool-file.txt on Linux / macOS. Uses backslashes on
// Windows.
console.log(fullPath);
```

The above gives an example for building paths that'll work on all
Linux, macOS, and Windows. We *could* check if we were on Windows and
handle the building paths with backslashes ourselves, but why not use
a library if it's already there!

### Destructuring Assignment

So what if we want to `require` `join` directly. In the previous example we had
to access it out of the entire exports of `path`. We can use a JavaScript
feature called destructuring assignment to do it.

Destructuring assignment lets you assign variables in the shape of an object.
Let's see this in action.

```js
// We have an object with properties.
let things = {
  one: 1,
  two: 2,
  three: 3
};

// Having to say things.one, things.two, and things.three takes too
// much typing. So we can get the values of one, two, and three, out
// all at once!
let { one, two, three } = things;

// Now one, two, and three have been assigned values from the object
// called things.

console.log(two);  // 2
```

Similarly, we can do the same with arrays:

```js
let [a, b] = [1, 2];

console.log(b)  // 2
```

Now back to our `join` example:

```js
const { join } = require('path');

let fullPath = join('a/b/c', '../d', 'cool-file.txt');
console.log(fullPath);
```

This does the same thing, but we now we can get `join` without having to deal
with it inside `path`. With long module names, this can save some space and
makes things more readable (unless it's hard to tell where something came
from).

## Creating Modules

Now it's time for the opposite point of view. How do we make modules that we
can use?

Let's start with a sample directory setup inside a folder called
`modules-intro/`:

```text
modules-intro
├── one.js
├── two.js
└── three.js
```

We're going to `one.js` and `two.js` from inside `three.js`.

### Normal Exports in `one.js`

Code in your Node.js files is not automatically available to other files. You
have to explicitly export it in order for it to be available. The primary way
of doing this is by setting properties of `exports`.

Here's a typical example for `one.js`:

```js
// one.js

// Prints all the positive integers up to and including an upper
// limit.
exports.printNumbers = (upper) => {
  for (let i = 1; i <= upper; i++) {
    console.log(i);
  }
};

// My own personal favorite. In caps since it's a constant.
exports.FAVORITE_NUMBER = 37;
```

In the above we have a module which if we load it has a property
that's a function and one that is a constant.

### A Single Export in `two.js`

Now we'll export one thing to represent the entire module. We can do this by
setting the value of `module.exports`.

Here's what we'll have in `two.js`:

```js
// two.js

// Our export is a function that is a factorial implementation.
module.exports = function fac(n) {
  if (n === 0) return 1;
  else return n * fac(n - 1);
};
```

In the above we export a simple factorial function. The function is given the
name `fac` so that it can call itself recursively, however, this *does not*
mean the function is called `fac` to the outside. Instead, the result of using
`require` on this module is the function directly.

> *Note*: `exports` and `module.exports` actually refer to the same thing. If
> we were to just say `exports = ...` in the above, then we would be changing
> the whole value of the exports instead of adding to it, and so exporting
> wouldn't work.

### Putting it Together in `three.js`

Now we can combine these files together and be able to use them.

Here's our content for `three.js`:

```js
// three.js

// Importing the other modules relative to this file (hence the
// `./`). The `js` can also be left off.
const { printNumbers, FAVORITE_NUMBER } = require('./one');
const factorial = require('./two');  // We can name this whatever.

// Print all the numbers up to the constant.
printNumbers(FAVORITE_NUMBER);

// Now print the factorial of it.
console.log(factorial(FAVORITE_NUMBER));
```

Now if we run this on the command-line, we'll get the output we
expect:

```shell
$ node three.js
1
2
3
4

<...>

36
37
1.3763753091226343e+43
```

This, of course, is a simple example. But you can do just about anything. Go
wild.
