# Callbacks

A *callback* is a function that is called after a function's execution has
been completed. It is the original form of asynchronous programming in Node.js.

Instead of pausing the program until a certain function has been executed,
we immediately exit the function, and the function runs on its own. When the 
execution of that function is done, the main execution of the program pauses for 
a moment, and the *callback function* that we specified is then called and run.

## I/O

Most languages prefer file I/O in this way:

```js
const fs = require('fs');

let data = fs.readFileSync('testFile.txt'); // a long pause here
console.log(data);
```

However, Node.js prefers file I/O using callbacks:

```js
fs.readFile('testFile.txt', (err, data) => {
  if (err) throw err;
  console.log(data);
}); // no delay here
console.log('Hi');
```

Notice that `Hi` gets printed before the data of `testFile.txt`, *despite
the code being written after the callback!*

> *Note*: It is bad practice to use the "Sync" `fs` functions in Node.js unless
> it is in something where asynchronous behavior doesn't matter, such as a
> short one-time script or in an a setup section that must complete before
> anything else can happen.
>
> If a synchronous `fs` function is called otherwise, it temporarily stops
> other operations from running asynchronously. This can prove to be a problem
> when running an HTTP server or making HTTP requests.

The greatest weakness of callbacks is when each one depends on the previous one:

```js
const fs = require('fs');
const http = require('http');

fs.readFile('testFile.txt', (err, data) => {
  if (err) throw err;
  let req = http.request('http://example.com/upload', { method: 'POST' }, (res) => {
    console.log('Got a response: ' + res.statusCode);
    res.on('end', () => {
      // We cannot actually get `res.data` (it's a little more complicated than
      // that), but assume that we could.
      fs.writeFile('testFileResponse.txt', res.data, (err) => {
        if (err) throw err;
        console.log('Wrote response to file');
      });
    })
  });
  req.write(data);
  req.end();
});
```

While the scenario in the code above may seem fantastical, this nesting of 
callbacks highlights a serious problem with callbacks known as *callback hell*.
Callback hell is dangerous because it can result in messy code and
difficult-to-trace bugs.

By convention, an error argument is often passed as the first argument in a
callback. If the error is `null` or `undefined` (it is normally best to just to
allow both), then the operation succeeded. Otherwise, the operation failed and
that error should be handled. In the example above we can see that this will
simple throw the error.

## Sleeping

So far, we haven't talked about any sleep functions in JavaScript... and that's
because there isn't one. 

Things in JavaScript are asynchronous, and a sleep function is inherently
synchronous which makes for a big problem.

Instead, there are two other things we can use: *timeouts* and *intervals*.

### Timeouts

Timeouts as simple. You pass a callback that gets executed after an amount of
time.

Here's a quick example:

```js
console.log('Ha...');

setTimeout(() => {
  console.log('choo.');
}, 1000);

console.log('...');
```

If you run this, you'll notice that this is printed as:

```text
Ha...
...
< a break for a second >
choo.
```

The code after creating the timeout will run first, even if the timeout is 0
ms.

If we wanted to have another timeout run after that, we would simply create
another timeout inside the callback that's there. We do this instead of just
making another interval at the top level that happens to be longer, since the
time until a timeout runs isn't completely gauranteed.

```js
console.log('Ha...');

setTimeout(() => {
  console.log('choo.');
  
  setTimeout(() => {
    console.log('> Bless you!');
  }, 3000);
}, 1000);

consoloe.log('...');
```

### Intervals

Intervals keep calling a callback on a provided interval. You can create a
spammy message in your terminal every second with this:

```js
setInterval(() => {
  console.log('Is this annoying yet?');
}, 1000);
```

The first iteration of the interval doesn't run until the first second as
passed.

The `setInterval(...)` function does also return back an interval object. To
make the interval stop, you can pass this object into `clearInterval(...)`.
Similarly, you can cancel a timeout from happening with `clearTimeout(...)`.

To make our lives better, we must study another approach to asynchronous 
programming known as *promises*.
