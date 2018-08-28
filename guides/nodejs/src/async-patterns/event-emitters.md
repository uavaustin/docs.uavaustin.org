# Event Emitters

Event emitters are objects that *emit* events which can be observed and handled.

When an event occurs, what can we use to handle the event? Naturally, we
can use a pattern that we have already learned: callbacks.

## Chatroom

Suppose we wish to represent a chatroom and handle various
events from it, such as when a user joins or leaves the room, and when a message
is received.

```js
class Chatroom extends EventEmitter {
  constructor() {
    super();
    this.on('join', client => {
      console.log(`${client.name} joined the room.`);
    });
    this.on('leave', client => {
      console.log(`${client.name} left the room.`);
    });
    this.on('message', (client, msg) => {
      console.log(`${client.name}: ${msg}`);
    });
  }
}

class Client {
  constructor(room, name) {
    this.room = room;
    this.name = name;
    this.joined = true;
    this.room.emit('join', this);
  }

  say(msg) {
    if (!this.joined) {
      throw new Error('must be currently in a room to talk');
    }

    this.room.emit('message', this, msg);
  }

  leave() {
    this.joined = false;
    this.room.emit('leave', this);
  }
}

let room = new Chatroom();
let client = new Client(room, 'Foo'); // Foo joined the room.
client.say('hello'); // Foo: hello
client.leave(); // Foo left the room.
```

We have just built a simple chatroom in a few lines of JavaScript.

Notice that the `Chatroom` class inherits the `EventEmitter` class, which
exposes the `emit` and `on` functions; the bread and butter of event-driven
I/O. Anyone can listen to any event in an event emitter, and the number
of listeners on any event is indefinite.

## Networking

Event emitters and promises can be combined to create a powerful pattern for
networking.

Suppose we wish to send a request to a server over an arbitrary network
protocol and wait for a response. The problem, however, is that any number of
irrelevant packets may also come in while we are waiting for our desired
response packet. The traditional solution to this often involves a handler 
table and a global variable that indicates whether or not someone is waiting 
for a response for a particular packet (and perhaps the corresponding list of 
pending promises for that request, in our case).

Instead of a handler table, we can instead use event emitters to wait for
a response:

```js
class GameClient extends EventEmitter {

  // ...

  send(msg) {
    this.socket.write(JSON.stringify(msg));
  }

  requestPlayerList() {
    return new Promise(resolve => {
      this.send({ type: 'player-list' });
      this.once('player-list', msg => {
        resolve(msg.players);
      });
    });
  }
}

// ...

let players = await client.requestPlayerList();
```

Using `once` instead of `on`, the event listener is automatically removed
once the `player-list` event has been received.
