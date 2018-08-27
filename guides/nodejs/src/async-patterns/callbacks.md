# Callbacks

A *callback* is a function that is called after a function's execution has
been completed. It is the original form of asynchronous programming in Node.js.

Instead of pausing the program until a certain function has been executed,
we immediately exit the function, and the function runs on its own. When the 
execution of that function is done, the main execution of the program pauses for 
a moment, and the *callback function* that we specified is then called and run.

Most languages prefer file I/O in this way:

```js
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

The greatest weakness of callbacks is when each one depends on the previous one:

```js
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

To rectify this issue, we must study another approach to asynchronous programming
known as *promises*.