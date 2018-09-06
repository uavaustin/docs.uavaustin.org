# Functions

Like in most languages, individual pieces of execution are blocked off into
functions in JavaScript. The syntax is mostly familiar to the other C-like
languages.

## A Basic Function

Here's a basic case of wrapping our hello world example into it's own function.

```js
function sayHello() {
  console.log('Hello, world!');
}

// Call the function.
sayHello();
```

If you either save this to a file and run the script, or run this in an
interactive Node.js session, you'll get the same print out as before.

Just like in the rest of the language, you don't provide return types for the
functions.

> *NOTE:* The convention in JavaScript is to use `camelCase` naming for
> normal functions (as well as variables in general).

## Arguments

Let's take our example above, but be able to say hello to specific people.
We'll take an argument `person` and print that like *Hello, José!*, for
example.

```js
function greet(person) {
  // Template literal syntax below!
  // Same as saying 'Hello, ' + person + '!'.
  console.log(`Hello, ${person}!`);
}

// Prints out 'Hello, José!'.
greet('José');
```

If we call `greet('José')` we'll get our expected output.

## Optional Arguments

The way JavaScript handles function arguments is a little different. What
happens if we call `greet()` without a person's name?

```js
function greet(person) {
  // Template literal syntax below!
  // Same as saying 'Hello, ' + person + '!'.
  console.log(`Hello, ${person}!`);
}

greet();
```

In the above, we actually get *Hello, undefined!*. Instead of having to say
that an argument in optional in JavaScript, we just don't provide it. Variables
which aren't passed into a function are set to the value `undefined`.
Similarly, if you pass in more arguments than a function can take, they are
simply ignored.

Next, we'll adapt our function to print out a generic *Hello.* message if no
person was provided.

```js
function greet(person) {
  // Print out the name too if it's truthy, i.e., not undefined,
  // null, '', and so on.
  if (person) {
    console.log(`Hello, ${person}!`);
  } else {
    console.log('Hello.');
  }
}

// Prints out 'Hello, José!'.
greet('José');
// Prints out 'Hello.'
greet();
```

## Default Arguments

JavaScript also allows for the use of default arguments. Values which are not
provided can have their value defaulted to another.

Here's an example with adding numbers:

```js
function add(a, b = 1) {
  return a + b;
}

// Prints 7.
console.log(add(4, 3));
// Prints 5.
console.log(add(4));
```

## Anonymous Functions

Not all functions created in JavaScript are assigned names. Functions can be
passed into different functions as arguments and can be bound to variables.

To create an anonymous function, simply don't provide the name like before:

```js
let a = function () {
  console.log('spooky');
}

// Runs the function.
a();
```

## Arrow Functions

Similar to anonymous functions, arrow functions are an additional syntax of
creating unnamed functions.

The above can effectively written as:

```js
let a = () => {
  console.log('spooky');
}

// Runs the function.
a();
```

The syntax `() => {}` is essentially the same as `function () {}`. It is just a
bit shorter.

There is more syntactic sugar with makes arrow functions nicer to use. If there
is only one argument passed, the parenthesis can be removed like so:

```js
let increment = a => {
  return a + 1;
}

// Prints 6.
console.log(increment(5));
```

The above can be shortened even more. When using the form
`(a, b, c...) => { return d }`, this can be shortened to `(a, b, c...) => d`.
Without the curly braces, the expression on the right is automatically
returned.

Therefore, we can shorten this to:

```js
let increment2 = a => a + 1;

// Prints 11.
console.log(increment2(10));
```

The above is very convenient for creating small functions.

> *Note*: Many JavaScript style guides recommend not removing the parenthesis
> around the arguments in arrow functions unless the braces are also removed
> on the right. Thus, `(a) => { /* */ }` and `a => expr` would be correct, but
> not `a => { /* */ }`.

We'll discuss the use of unnammed functions (anonymous and arrow) in more
detail in the [Functional Programming](../functional-programming.md) and
[Async Patterns](../async-patterns/index.html) chapters.

There are some small differences between arrow functions and regular functions
defined with `function`. Regular functions have a variables called `this`,
`arguments`, `super`, and `new.target` set as well, which are missing in arrow
functions. We'll get into some of these in the
[Objects and Classes](../objects-and-classes.md) chapter.
