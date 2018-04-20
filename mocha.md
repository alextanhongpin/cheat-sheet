# Mocha


## Describe and It is not defined

```js
// Add this to the top of each file
/* global define, it, describe */
```

Or in `package.json`:

```json
{
  "env": {
    "node": true,
    "mocha": true
  }
}
```
