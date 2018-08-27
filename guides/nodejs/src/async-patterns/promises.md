# Promises

A *promise* is a container for a value that does not exist yet, but will exist
in the future. A promise may have three states: *pending* (the value does not 
exist yet), *fulfilled* (the value exists), or *rejected* (the value does not exist due to an error).

Promises did not natively exist in JavaScript until ECMAScript 2015; before
then, libraries such as [Bluebird](http://bluebirdjs.com) were used instead
to provide support for this type of asynchronous programming.

When we call an async function, it immediately returns a pending `Promise` 
object. When the async function is complete, the promise is set to fulfilled or
rejected, and an event is fired.

```js
fetchPlaylist().then(playlist => {
  console.log(playlist);
}).catch(console.error);
```

In this example, `fetchPlaylist` is an async function that returns a promise.
We wrap this promise with `then`, which calls a callback when the promise
is fulfilled. In the case that the promise is rejected, the callback in `catch`
is called instead.

> *Note*: All promise rejections must be handled. Without a `catch` clause,
> the program will suffer an "Unhandled promise rejection" error, since
> promises that are wrapped with callbacks are unable to throw ordinary 
> exceptions.

However, we still have not solved the callback hell problem. In the next
section, we will introduce new syntax that solves the problem once and for all.
