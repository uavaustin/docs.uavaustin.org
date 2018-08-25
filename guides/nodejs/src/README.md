# Introduction

This guide gives an introduction to Node.js, a server-side JavaScript runtime.

JavaScript serves as the scripting language for the browser. Node.js provides a
set of libraries that enable the use of JavaScript to have file system access,
host HTTP servers, etc. for the server. Node.js uses the V8 JavaScript engine
from Chrome.

JavaScript is a dynamically and weakly typed language. The language itself is
very flexible and can come to a shock from backgrounds like C++ or Java.

## Structure

This guide assumes some prior programming language experience in a language
such as Java, Python, or C++. Concepts common to most programming languages are
run through quickly in the beginning. After that come topics more unique to
Node.js. All of this is broken up into 3 sections:

- The first chapters of this guide cover the ideas of JavaScript in general. In
  this, the basics of the languages are covered, followed by the use of modules
  to split up code into different files, the creation of classes, and the use
  of functional programming in JavaScript.

- Afterwards, asynchronicity is introduced, which will be shown primarily
  through the use of the Node.js file system (`fs`) module. There are many
  different patterns of modeling asynchronous behavior in JavaScript, which can
  be a somewhat steep learning curve for some.

- To close, the Node Package Manager&mdash;known as NPM&mdash;is introduced,
  which allows for the downloading of JavaScript packages from a massive
  package repository, and Babel, an NPM library that allows for the use of
  next-generation JavaScript.

To get going, go to the [Getting Started](getting-started/index.html) section
to get your environment set up.
