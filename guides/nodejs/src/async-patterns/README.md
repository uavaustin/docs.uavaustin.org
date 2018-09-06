# Async Patterns

Asynchronous programming allows multiple parts of a program to run
concurrently without necessarily needing to manage multiple threads.

How can multiple blocks of code run at the same time, all the while using a
single thread? The answer is that the code does not run at the same time;
rather, an *event loop* in the background switches rapidly between
coroutines that represent multiple paths of execution.

Using asynchronous programming, we can perform other tasks while waiting
on a long-running task to finish. Without it, our entire program could freeze
simply waiting on an I/O operation. Hence, the async paradigm is the driving 
force of the "event-driven I/O" concept that originally propelled 
Node.js to fame.

This section covers common async patterns and approaches in Node.js, including
callbacks, promises, `async`/`await` syntax, and event emitters.
