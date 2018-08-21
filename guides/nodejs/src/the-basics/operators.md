# Operators

JavaScript is also a *weakly typed* language, i.e., the language is not strict
with its type rules and allows does many type conversions on operations. This
can lead to some unexpected behaviors.

This chapter gives a quick overview of the main operators in the language.

## Numeric Operators

These work with numerical values.

- `a + b` - Addition.
- `a - b` - Subtraction.
- `a / b` - Division.
- `a * b` - Multiplication.
- `a % b` - Remainder.
- `a ** b` - Exponentiation.
- `+a` - Unary plus.
- `-a` - Unary negation.
- `a++` - Postfix increment.
- `a--` - Postfix decrement.
- `++a` - Prefix increment.
- `--a` - Prefix decrement.

Typically, the convention is to prefer the postfix operators in loops. Though
it is best to use them sparingly to prevent confusing logic.

Using types other than numbers in the above will often lead to the result of
`NaN`.

## Assignment

- `a = b` - Assignment.
- `a += b` - Addition assignment.
- `a -= b` - Subtraction assignment.
- `a /= b` - Division assignment.
- `a *= b` - Multiplication assignment.
- `a %= b` - Remainder assignment.

## Relational Operators

- `a < b` - Less than.
- `a > v` - Greater than.
- `a <= v` - Less than or equal to.
- `a >= b` - Greater than or equal to.
- `a in b` - Check if an object `a` has a property `b`.
- `a instanceof b` - Check if `a` is an instance of object `b`.

## Equality Operators

- `a == b` - Equality.
- `a != a` - Inequality.
- `a === b` - Strict Equality.
- `a !== b` - Strict Inequality.

The difference between the strict and non-strict variety is that the first set
of equality operators will do type conversions to check for equality. For
example, `1 == '1'` is considered to be `true`. This is normally not desired
behavior, and so it is best to use `===` and `!==` when possible to avoid
potential problems due to type conversions.

[See here](https://stackoverflow.com/a/359509) for a more detailed comparison
of `==` and `===`.

## Logical Operators

- `a && b` - Logical AND.
- `a || b` - Logical OR.
- `!a` - Logical NOT.

> *Note:* The value of `a && b` is equal to `a` if either `a` or `b` is falsy,
> otherwise, it is equal to `b`. Similarly, `c || d` is equal to `c` if `c` is
> truthy, otherwise, it is equal to `d`.
>
> In normal logical operations this does not
> influence the behavior, however, this is quite useful for setting default
> values in case something is `undefined`, or making sure a property can be
> accessed in an object.
>
> For example, `a.b && a.b.c` will returned the value of the nested `c`
> property if it is truthy and if it's already been established that `b`
> exists. Getting the value of `a.b.c` throws an error if `b` doesn't exist.
> This syntax apperas when inlining values instead of needing an `if` statement
> or ternary operator.

## String Concatenation

The addition operator (`+`) can be used for string concatenation. This can
include values of different types as well.

```js
let num = 42;
console.log('my favorite number is ' + num + '!');
```

There is also an additional syntax called
[templates literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Template_literals)
which allow strings to embed expression in the same way. Instead of using a
quote to enclose a string, backticks are used instead, and expressions can be
included inside a dollar sign and curly braces (`${expr}`). The following is
the same as the above:

```js
let num = 42;
console.log(`my favorite number is ${num}!`);
```

## Other Operators

- `cond ? expr1 : expr2` - Ternary Operator (explained in the [next chapter](./control-flow.md)).
- `delete a.b` - Deletes a property `b` from object `a`.
- `typeof a` - Returns type of `a` as a string.

## More Information

There a bunch of other operators in the language (such as bitwise operators).
To see a more exhaustive list, see the
[MDN Web Docs reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators).
