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

The standard `for` loop pattern uses the initial value, condition, and
increment setup. The `for` loop will iterate a block while the condition
remains true. After each iteration, the increment is applied.

```js
for (let i = 0; i < 10; i++) {
  console.log(i);
}
```

The above will print out the numbers from `0` to `9`.

## `for` ... `in` Loops

The `for` ... `in` loop iterates over non-`Symbol`, enumerable properties of an
object.

With a basic object, this will simply print out the keys. In the example below,
we can loop through each key this object has, and print out the key and value.

```js
let prices = {
  fruit: 3.99,
  vegetables: 5.95,
  cereal: 2.99
};

for (let food in prices) {
  // Using the food as a key to get the price for each.
  console.log(food + ' has a price of $' + prices[food]);
}
```

This will print:

```text
fruit has a price of $3.99
vegatables has a price of $5.95
cereal has a price of $2.99
```

> *Note:* `for` ... `in` loops can have somewhat unexpected behavior when
> classes are involved due to how inheritance works in JavaScript. See the
> [Objects and Classes](../objects-and-classes.html) section for more
> information later on.

*A `for` ... `in` loop should not be used on an `Array`.*

## `for` ... `of` Loops

The `for` ... `of` loop iterates over
[iterable objects](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols).
This includes things such as an `Array` or `String`.

The following simply prints out each number in the list.

```js
let coolNumbers = [7, 37, 1337];

for (let num of coolNumbers) {
  console.log(num);
}
```

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

`break` and `continue` can be used to alter the flow of a `for` or `while`
loop.

`break` will cause the loop it is in to stop.

```js
let a = 1;

// Keep looping until stopped manually.
while (true) {
  // Increment the number by 2.
  a += 2;

  // Stop when it's 9.
  if (a === 9) {
    break;
  }
}

// This should print out 9.
console.log(a);
```

`continue` skips the rest of the loop and makes the loop go to the next
iteration.

```js
// Loop through even values from 2 to 20, inclusive.
for (let i = 2; i <= 20; i += 2) {
  // Skip if this is a multiple of 6.
  if (i % 6 === 0) {
    continue;
  }

  console.log(i);
}

// The numbers 2, 4, 8, 10, 14, 16, and 20 are printed above.
```

Note that for nested loops, `break` and `continue` apply to the inner-most
loop.

## `switch` Statements

`switch` statements allow for branching on expressions. Branches do allow for
fall-through, and so once a case is matched, all statements below are run until
`break` is used. The `default` case runs when nothing matches.

Here's an example:

```js
let unit = 'euro';

switch (unit) {
  // Cents fall-through with the dollar case so they are treated the same.
  case 'cent':
  case 'dollar':
    console.log('This is American currency');
    // The break is required to prevent the execution from going further.
    break;
  case 'euro':
    console.log('This is European currency');
    break;
  // Default will allow for anything else.
  default:
    console.log('Not sure what this is...');
}
```

## `try` ... `catch` Statements

`try` ... `catch` blocks allow for code that might fail to execute.

Errors can be thrown with the `throw` keyword.

```js
try {
  throw Error('This is not going to work');
} catch (err) {
  console.error(err);
}
```

This will log the error message.

`console.error(...)` is traditionally used for printing errors since it prints
to stderr.

The `finally` block can be attached for code to execute regardless of what
happens in the `try` or `catch` block:

```js
try {
  throw Error('This is not going to work');
} catch (err) {
  console.error(err);
} finally {
  console.log('hello');
}
```

At least one of `catch` or `finally` is required.

> *Note*: Unlike Java and some other langauges, there are no such things as
> multiple catch blocks. To only catch one type of error, you'll need to check
> what kind of error it is by either using `typeof` or inspecting its message
> and re-throw the error if it's not what you're expecting.

## Ternary Operators (`?:`)

Ternary operators work as inline `if` statements.

The syntax for the ternary operator (or `?:`) is as follows:

```text
condition ? expr1 : expr2
```

If the condition is truthy, then this above evaluates to `expr1`, otherwise, it
evaluates to `expr2`.

See the following example:

```js
let age = 17;

console.log(age >= 16 ? 'You can get a driver\'s license' : 'No driving');
console.log(age >= 18 ? 'You can buy cigarettes' : 'No smoking');
```

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

A neat use case of leaving off the blocks is with very short `if` ... `else`
statements.

```js
if (someExpression) console.log('true');
else console.log('false');
```
