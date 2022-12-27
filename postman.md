In the `Tests` tabs, we can access the json payload:

```js
const json = pm.response.json()

pm.collectionVariables.set('token', json.data.token)
```
