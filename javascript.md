# Setting Unit Test

```json
{
  // ... not shown
  "scripts": {
    "test": "node ./node_modules/.bin/mocha test/**.js"
  },
  "standard": {
    "env": ["mocha"]
  }
}

```

# Describe and It is not defined mocha

.eslintrc and .eslintignore files are not supported by standard. Your options are:
```
Add /*eslint-env mocha */ to the top of the file with mocha globals.
Or, add "env": [ "mocha" ] to the package.json under the "standard" property.
```

# Open as json in new tab

```
something = window.open("data:text/json," + encodeURIComponent(mysdata),
                       "_blank");
```


# Trigger events on another tab

Useful for triggering global events across different browser tab, such as forcing users to log out from other tabs.

Use localStorage `storage` event.
