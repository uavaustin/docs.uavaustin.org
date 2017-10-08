# UAV Austin Documentation

[![Build Status](https://travis-ci.org/uavaustin/docs.uavaustin.org.svg?branch=master)](
    https://travis-ci.org/uavaustin/docs.uavaustin.org)

Created with [GitBook](https://github.com/GitbookIO/gitbook).

[Read it here!](http://docs.uavaustin.org/)

## Building from Source

### Prerequisites

- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- [Node.js and npm](https://nodejs.org/en/) (A version over Node.js 6 should be
    fine)

### Getting the Repo and Installing

```
$ git clone https://github.com/uavaustin/docs.uavaustin.org.git
$ cd docs.uavaustin.org
$ npm install
```

This will get the repo and then install any needed npm and gitbook-cli
dependencies.

### Building the GitBook

```
$ npm run build
```

This will build the GitBook inside a `_book/` directory. `_book/index.html` is
the main page for the docs.

### Hosting the Book Locally

```
$ npm run serve
```

This builds the source and hosts a server as well (on something like
http://localhost:4000/).
