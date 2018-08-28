# Objects and Classes

An object in JavaScript can be perceived as a map from a string to a primitive,
a function, or another object (see ["Objects" in 3.2](http://docs.uavaustin.org/guides/nodejs/the-basics/data-types-and-variables.html#objects)).

We know the basic syntax for creating an object:

```js
// A loud dog
let dog = {
  volume: 2
};
```

But we can also place a function inside an object and call it:

```js
let dog = {
  volume: 2,
  bark: function () {
    console.log('Bark!');
  }
};

dog.bark(); // Bark!
```

Now `dog` is acting more like a class. But what if we want to get a property
inside `dog` and use it in `bark`?

```js
let dog = {
  volume: 2,
  bark: function () {
    console.log('Bark! Volume: ' + volume);
  }
};

dog.bark(); // ReferenceError: volume is not defined
```

This will not work - the interpreter thinks that we are trying to reference
a variable called `volume`. But in reality, we wish to reference
the property `volume` inside the object `dog`.

We could try this instead:

```js
let dog = {
  volume: 2,
  bark: function (dog) {
    console.log('Bark! Volume: ' + dog.volume);
  }
};

dog.bark(dog); // Bark! Volume: 2
```

This prints the result that we expected, but note that we referenced `dog`
twice on the function call. We want to make `dog.bark` act more like a class
method that can access the property of the object it belongs to.

```js
let dog = {
  volume: 2,
  bark: function () {
    console.log('Bark! Volume: ' + this.volume);
  }
};

dog.bark(); // Bark! Volume: 2
```

When we call a function inside of an object in this way, we modify a special
variable called `this`, which is intended to refer to the currently scoped
object, very much akin to Java. In this case, `this` has been assigned to
`dog`.

## Classes using prototypes

We wish to make `dog` into a real class named `Dog` that can be created using
a constructor, so that we can make many instances of `Dog` that we can call
`bark` on.

```js
function Dog(volume) {
  this.volume = volume;
};

Dog.prototype.bark = function () {
  console.log('Bark! Volume: ' + this.volume);
};

let dog = new Dog(2);
dog.bark(); // Bark! Volume: 2
```

Notice two keywords here: `prototype` and `new`. When we call `new`, the `this`
keyword is assigned to an empty object (`{}`), with a special exception: everything
from `Dog.prototype` is copied over to the empty object. When the function call
finishes, `this` is used as the return value and is ultimately assigned to `dog`.

For future reference, when class method is mentioned using `prototype`, we mean
that the class method is not static - i.e. the method must be called from an
instance of the class.

## Classes using ES6 syntax

Since ECMAScript 6 (officially known as ECMAScript 2015, or ES2015), a more
comfortable syntax has been developed for classes:

```js
class Dog {
  constructor(volume) {
    this.volume = volume;
  }

  bark() {
    console.log('Bark! Volume: ' + this.volume);
  }
}

let dog = new Dog(2);
dog.bark(); // Bark! Volume: 2
```

ES6 classes also allow us to define static methods by prepending the
function with `static`. Static methods do not require an instance
of the object to be created before calling the method.

### Getters and setters

Prefixing a class method with `get` or `set` allows it to be accessed as if it
were a property:

```js
class Foo {
  constructor() {
    this._bar = 1;
  }

  get bar() {
    return this._bar;
  }

  set bar(value) {
    if (typeof value !== 'number') {
      throw new TypeError('value must be a number');
    }

    this._bar = value;
  }
}

let foo = new Foo();
console.log(foo.bar); // 1
foo.bar = 3;
console.log(foo.bar); // 3
foo.bar = 'test'; // TypeError: value must be a number
```

### Inheritance

It is also possible to inherit classes using the `extends` operator in ES6.
Inheritance causes us to *inherit* the methods from the class we wish to inherit
from (the *superclass*). We call the superclass's constructor by calling
`super()` at the beginning of our class's constructor.

## Tricks

### `Object.assign`

Suppose we wanted to copy all of the properties of object `foo` onto object `bar`.
We could do the following:

```js
let bar = {
  text: 'baz'
};

bar.a = foo.a;
bar.b = foo.b;
bar.c = foo.c;
```

This requires us to know ahead of time the properties that `foo` has and then copy
each property one by one. This is very tedious if we have dozens of properties in the
object that we wish to copy. Instead, we can use `Object.assign`:

```js
let bar = {
  text: 'baz'
};

Object.assign(bar, foo);
```

Now `bar` contains `text`, along with whatever properties `foo` might have.

### Spread syntax

Since ECMAScript 2018, it is also possible to merge objects together without
the use of `Object.assign`:

```js
let baz = {
  ...foo,
  ...bar
};
```

It is also possible to replace this syntax:

```js
let x = 2;
let y = 3;
let z = 4;
let coords = { x: x, y: y, z: z };
```

with the following:

```js
let x = 2;
let y = 3;
let z = 4;
let coords = { x, y, z };
```

### Destructuring

We can extract multiple variables from an object, provided that our variable
names correspond to the properties in the object:

```js
let coords = { x: 2, y: 3, z: 4 };
let { x, y, z } = coords;

console.log(x); // 2
console.log(y); // 3
console.log(z); // 4
```

## Converting to JSON

An object can be *serialized* (converted) into JSON with a simple function:

```js
let json = JSON.stringify(object);
```

The function returns a string representation of the specified object, which is
entirely safe to pass over the network.

To convert it back to an object, we simply call its inverse:

```js
let obj = JSON.parse(json);
```

Note, however, that not all objects can be safely converted to JSON:

 - *Circular references* (objects that refer to themselves) will cause an error
  during `JSON.stringify`.
 - All methods are lost, and classes lose their type when stringified.
 - Multiple properties that refer to the same object will now refer to different
  objects with identical properties.
