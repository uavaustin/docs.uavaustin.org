# Control Flow

Control flow makes up the most important building blocks in a programming
language: handling logic and dealing with looping constructs.

We'll start with `if` statements first.

## `if` Statements

An `if` statement allows for basic branching on a conditional value (or
something that can be coerced into a conditional value).

The syntax is like that of Java or C.

```js
if (someExpression) {
  console.log('if block');
}
```

If `someExpression` is a value that is truthy, then the string
is printed.

Truthy values are those that are not `false`, `0`, `''`, `null`, `undefined`,
and `NaN`. *Note that empty objects are truthy.*


An `else` block can handle running statements if the condition is not truthy.

```js
if (false) {
  console.log('1');
} else {
  console.log('2');
}
```

In this case, `2` is printed out.

`else if` can check another condition if the ones above are false.

```js
let num = 100;

if (num % 3 === 0) {
  console.log('Divisible by 3.');
} else if (num % 5 === 0) {
  console.log('Divisible by 5');
} else {
  console.log('Not divisble by 3 or 5');
}
```

## `for` Loops

> // TODO

## `for` ... `in` Loops

> // TODO

## `for` ...  `of` Loops

> // TODO

## `while` Loops

`while` loops repeat a code block while a condition is truthy.

```js
let a = 1;

while (a !== 32) {
  console.log('a is ' + a);

  // Double the value of a.
  a *= 2;
}
```

The example above will keep doubling the value of `a` until it reaches `32`. At
that point the condition is false and the loop is done.

## `do` ... `while` Loops

`do` ... `while` loops are like while loops, except that the condition is
checked after an iteration instead of before. This means they are guaranteed to
run the block at least once.

```js
let message = '';
let i = 0;

do {
  // Increment i by two and add it to the end of the message string.
  i += 2;
  message += i;
} while (i < 8);

// This should print out '2468'.
console.log(message);
```

These don't pop up too often in JavaScript code, but they are good to know.

## `break` and `continue`

> // TODO

## `switch` Statements

> // TODO

## `try` ... `catch` Statements

> // TODO

## Ternary Operators (`?:`)

> // TODO

## Shorthand

The curly braces in `if` statements, `for` loops, and `while` loops, can be
left off if there's only one statement in the body. Like so:

```js
if (someExpression) {
  console.log('It is true!');
}

// Or also...

if (someExpression)
  console.log('It is still true...');
```

In most circumstances it's normal to just keep the curly braces, you never know
if you'll want to add more statements inside the body.

A neat use case of leaving of the blocks is with very short `if else`
statments.

```js
if (someExpression) console.log('true');
else console.log('false');
```
