# Functional Programming

Functional programming is the only programming paradigm that is actually
functional, whereas other paradigms do not do anything at all.

Jokes aside, functional programming refers to the use of *functions* to
concisely manipulate and filter data.

## Introduction

Traditionally, most iterative solutions involve the use of a `for` loop:

```js
// Print and increment every element in the array by 1
for (let i = 0; i < arr.length; i++) {
  console.log(arr[i]);
  arr[i]++;
}
```

While searching through Stack Overflow, however, you may have seen another
approach to iteration using `forEach`:

```js
arr.forEach(function (element, index) {
  console.log(element);
  arr[index]++;
});
```

Here, we use a *function*, rather than a `for` loop, to represent the body
of the loop.

What if we wanted to create a new array out of this loop? We could take
a traditional approach:

```js
let arr2 = [];
for (let i = 0; i < arr.length; i++) {
  arr2[i] = arr[i] + 1;
}
```

We could also take a functional approach using `map`:

```js
let arr2 = arr.map(function (x) {
  return x + 1;
});
```

Using `map`, the original array `arr` is left unmodified, and a new array is
created for us.

Notice that this syntax is somewhat verbose. We can use *arrow notation*
instead to represent the function:

```js
let arr2 = arr.map(x => x + 1);
```

This means that for every `x` in the array (`x` is the first argument passed into the function we created; it could be any variable name), return `x + 1`.

## Reference

### `Array.prototype.map`

Transforms a given array by a given function and returns the result as a
new array.

#### Example

Let `points` be an array of x, y, z points:

```js
let xPoints = points.map(point => point.x);
```

`xPoints` will then contain an array of numbers corresponding to the `x`
coordinate of each point. The order of the points is preserved.

### `Array.prototype.filter`

Returns a new array containing only the elements that pass a given condition.

#### Example

Let `points` be an array of x, y, z points:

```js
let pointsInBounds = points.filter(point =>
  Math.abs(point.x) < 100 &&
  Math.abs(point.y) < 100 &&
  Math.abs(point.z) < 100
);
```

`pointsInBounds` will then contain only the points that are located within 100 units from the origin (0, 0, 0) on all three axes.

### `Array.prototype.reduce`

Returns a value as an aggregate of all of the elements of an array.

#### Example

Let `cart` be an array of items containing `price`:

```js
let total = cart.reduce((total, product) => total + product.price);
```

`total` will contain the total price of all of the items in `cart` (minus tax,
of course).

## Chaining

Due to their immutability, the results of these basic functions can be chained
and nested within one another for elaborate computations. For the purposes of
brevity, however, we will not cover a complex example.

## Composition

Like in algebra, we can wrap a function within another function:

```js
let f = x => x * 2;
let g = x => f(x) + 1;
console.log(g(2)); // 5
```

It is also possible to modify the special `this` variable manually when
calling a function by using `Function.prototype.bind`:

```js
function someLegacyJsMethod() {
    return this.x;
}

let point = { x: 2, y: 8, z: 1 };
let func = someLegacyJsMethod.bind(point);
console.log(func()); // 2
```

Alternatively, we may use `bind` to partially fill the arguments of a function
without calling the function:

```js
let f = (x, y, z) => x + y + z;
let g = f.bind(this, 1, 2);
console.log(g(3)); // 6
```

You will only see use of `bind` in special circumstances, such as callbacks,
where the value of `this` is lost or ambiguous.
