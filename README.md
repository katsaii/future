# Future

A cross-platform micro-library for managing asynchronous code. Originally
designed for the [Catspeak programming language](https://github.com/NuxiiGit/catspeak-lang),
and later made into its own library.

_Developed by
[katsaii](https://www.katsaii.com/)._

## Overview

If you have ever heard of [JavaScript Promises](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise),
you're already halfway there. Futures offer a similar method of organising
asynchronous code using "callbacks":
```js
var future = new Future();

future.andThen(function(result) {
  show_message(result); // displays 10
});

future.accept(10);
```

Just like JavaScript Promises, it is possible to chain multiple futures:
```js
future_file_text_read("test-file.txt")
  .andThen(function(content) {
    return future_json_parse(content);
  }).andThen(function(json) {
    show_message(json);
  });
```