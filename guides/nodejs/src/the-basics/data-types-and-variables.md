# Data Types and Variables

JavaScript is a _dynamically typed_ language. This means that variables do not
have a type attached to them and be assigned to values of all types.

```js
// Declare a variable foo.
let foo;

// foo starts as a number.
foo = 37;

// foo is now a boolean.
foo = false;
```

In the above, we declare with a variable `foo`. We're then able to set it to
whatever value we want, or not at all.

Like many languages, statements in JavaScript are terminated with semicolons.

> *Note:* Semicolons are not technically required in JavaScript, and some even
> recommend not using them. JavaScript uses automatic semicolon insertion to
> add in semicolons on newlines when they can be assumed. There are corner
> cases that can mess people up. The best practice is to always use semicolons.

## Data Types

There are seven data types in JavaScript.

- Six primitive data types:
  - Boolean
  - Null
  - Undefined
  - Number
  - String
  - Symbol
- and Object

### Primitives

All types except for objects are immutable. These values cannot be changed.
That is not to say however that the variables assigned to a primitive cannot be
changed. Here is a short description for each:

| Type | Value |
| :--- | :--- |
| Boolean | A Boolean is a logical value that can either be `true` or `false`. |
| Null | The Null type has one value: `null`. It represents the absense of a value. |
| Undefined | A variable which has not been assigned a value has the value `undefined`. |
| Number | All numbers in JavaScript are double precision 64-bit numbers. |
| String | Strings represent textual data. They are enclosed in single quotes, double quotes, or backticks. |
| Symbol | Symbols are values that can be checked for uniqueness. We'll ignore them in this guide. |

While many languages have just `null`, JavaScript has both `null` and
`undefined`. Normally, the nuance between these two values can be ignored.

All numbers, including integers, are all floating point numbers. `Infinity`
`-Infinity`, and `NaN` also also numbers.

### Objects

Other values in JavaScript are considered objects. Objects in JavaScript can
considered collections of key and value pairs. These keys are the properties of
the object.

The simplest way to create an object in JavaScript is through the object
literal syntax:

```js
let foo = {
  bar: 55,
  baz: false
};

console.log(foo.bar);  // Prints 55.
console.log(foo.baz);  // Prints false.
console.log(foo.foobar);  // Prints undefined.
```

If an object hasn't have a key, then the value is `undefined`.

Object keys can listed as strings if they are not valid identifiers.

```js
let headers = {
  Accept: 'application/json',
  'Content-Type': 'application/json'
};

console.log(headers['Accept']);
console.log(headers['Content-Type']);
```

Object properties can be fetched using strings inside brackets along with the
normal dot notation.

### Arrays

The `Array` type is actually of type `Object` in JavaScript. The array literal
syntax is as follows:

```js
let things = ['red', true, 9];
```

Note that arrays can be composed of different types.

Arrays can be indexed with brackets. Indexing begins at `0`. The `length`
property gives the number of elemnts in the array.

```js
let colors = ['red', 'white', 'blue'];

console.log(colors[1]);  // Prints white.
console.log(colors.length);  // Prints 3.
```

### Variables

Variables in JavaScript are declared with `var`, `let`, and `const`. `var` is
traditionally used in older JavaScript code, and it's use is no longer
recommended. `var` is scoped to the inner-most function, as opposed to the
block like `let`. This is will be dicussed more in the
[functions section](./functions.html).

Declaring a variable with `let` or `const` can only be done once per scope.

```js
let hello = 'world';
let anotherOne = 3;

let hello;  // SyntaxError: Identifier 'hello' has already been declared
```

Assignment can also happen when a variable is declared. If the variable is not
assigned, the value is `undefined`.

```js
let a;

console.log(a);  // Prints undefined.
```

Variables can be reassigned with `var` or `let`.

```js
let day = 'Monday';

day = 'Tuesday';
```

However, variables declared with `const` cannot be reassigned.

```js
const GRAVITY = 9.81;

GRAVITY = 10;  // TypeError: Assignment to constant variable.
```

Properties of a `const` object can be mutated though!

```js
const FOO = {
  bar: 3
};

console.log(FOO.bar);  // Prints 3.

// Setting the value to an object.
FOO.bar = { foobar: 'baz' };

console.log(FOO.bar);  // Prints { foobar: 'baz' }.
```
