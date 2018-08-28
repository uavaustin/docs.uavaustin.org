# `async`/`await`

Despite the prevalence of asynchronous functions, most of our programming
remains linear in practice - hence the plight of "callback hell."

Instead of wrapping our promises with callbacks, why can't we just *wait* for
the promise to be fulfilled, all the while keeping the event loop going (so as
to not freeze other tasks)?

Since ECMAScript 2017, this functionality is now available:

```js
let results = await axios.get('https://example.com/posts/search?name=foo');
console.log(results.data); // a JSON object of our results, perhaps?
```

In this example, we use the [`axios`](https://www.npmjs.com/package/axios)
HTTP library to perform an asynchronous GET request. The flow of the program
clearly pauses on the `await` clause and then proceeds to the subsequent line.

However, we can only use `await` in functions that have been declared with
the `async` keyword, since `await` is, in reality, syntactic sugar to produce
a callback from our promise, rather than a magical conversion to traditional 
synchronous code.

```js
async function getResults() {
  return await axios.get('https://example.com/posts/search?name=foo');
}

getResults().then(results => console.log(results.data)).catch(console.error);
```

The top level of the script will always use at least one `.then` and `.catch`, since `await` cannot be used at the top level.

What about an `async` function that does not actually contain an await?

```js
async function add(a, b) {
  return a + b;
}

add(2, 2).then(console.log).catch(console.error);
```

We can observe that all `async` functions, regardless of whether they
depend on `await` or not, return a `Promise`. Conversely, functions
that directly return a `Promise` do not need to be marked `async` unless they
depend on `await`:

```js
function getResults() {
  return axios.get('https://example.com/posts/search?name=foo');
}

getResults().then(results => console.log(results.data)).catch(console.error);
```

This code produces the same outcome because `axios.get` already returns a `Promise` object.

## Catching exceptions

Catching rejected promises using `async`/`await` is equivalent to native
`try`/`catch` syntax:

```js
try {
  await thisCouldFail();
} catch (e) {
  console.error('It failed!!', e);
}
```

## Wrapping callbacks with promises

Many libraries, including Node.js itself, still use the old style of callbacks.
We can "promisify" a method by returning our own `Promise` object and fulfilling
it in the callback's body:

```js
function readFileAsync(file) {
  return new Promise((resolve, reject) => {
    fs.readFile(file, (err, data) => {
      if (err) reject(err);
      else resolve(data);
    });
  });
}
```

For most methods, this is all it takes to create a promised version of a
function that would otherwise require a callback.
