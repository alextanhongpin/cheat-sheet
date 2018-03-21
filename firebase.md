## Creating reference to collections

```js
const ref = firebase.database().ref('fruits')
```

## Setting values

```js
const fruitsRef = firebase.database().ref('fruits/')

fruitsRef.set({
  apple: { 
    price: 1.50
  },
  banana: {
    price: 2.50
  }
})
```

## Updating values

```js
const fruitsRef = firebase.database().ref('fruits/apple')
fruitsRef.update({
  price: 2.25
})
```

## Push

This will generate a unique id for each items pushed.

```js
const fruitsRef = firebase.database().ref('fruits')
fruitsRef.push({
  price: 1.5,
  name: 'apple'
})

fruitsRef.push({
  price: 2.5,
  name: 'banana'
})
```

## Key

```js
const fruitsRef = firebase.database().ref('fruits')
const keys = fruitsRef.key()
```

## Transactional data

```js
const fruitsRef = firebase.database()
const bananaRef = fruitsRef.child('fruits').child('-KGb1Ls-gEErWbAMMnZC').child('price')

bananaRef.transaction(function (price) {
  return price * 1.05
})
```

## Fetch all data

```js
const ref = firebase.database().ref()

ref.on('value', (snapshot) => {
  console.log(snapshot.val())
}, function (error) {
  console.log(error)
})
```

## child_added Event

```js
const fruitsRef = firebase.database().ref('fruits')
fruitsRef.on('child_added', (data, prevChildKey) => {
  const newFruit = data.val()
  console.log(newFruit.name)
  console.log(newFruit.price)
  console.log(prevChildKey)
})
```

## child_changed Event

```js
fruitsRef.on('child_changed', (data) => {
  const fruit = data.val()
  console.log(fruit)
})
```

## child_removed Event

```js
fruitsRef.on('child_removed', (data) => {
  const fruit = data.val()
  console.log(fruit)
})
```

## Detaching Callbacks

```js
fruitsRef.on('value', (data) => {
  console.log(data.val())
}, (error) => {
  console.log(error)
})

// Remove all callbacks with the value event type
fruitsRef.off('value')

// Remove all callbacks
fruitsRef.off()
```

## Order by child

```js
fruitsRef.orderByChild('name').on('child_added', (data) => {
  console.log(data.val().name)
})
```

## Order by key

```js
fruitsRef.orderByKey().on('child_added', (data) => {
  console.log(data.key)
})
```

## Order by value

```js
fruitsRef.orderByValue().on('value', (data) => {
  data.forEach((data) => {
    console.log(data.key, data.val())
  })
})
```

## Limit to First

**limitToFirst** method returns the specified number of items beginning from the first one

```js
const firstFruitRef = firebase.database().ref('fruits').limitToFirst(1)

firstFruitRef.on('value', (data) => {
  console.log(data.val())
}, (error) => {
  console.log(error)
})
```

## Limit to Last

**limitToLast** method returns a specified number of items beginning from the last one.

```js
const lastFruitRef = firebase.database().ref('fruits').limitToLast(1)

lastFruitRef.on('value', (data) => {
  console.log(data.val())
}, (error) => {
  console.log(error)
})
```

## Filters

```js
const fruitsRef = firebase.database().ref('fruits')

fruitsRef.orderByChild('name').startAt('banana').on('child_added', (data) => {
  console.log('start at filter:', data.val().name)
})

fruitsRef.orderBychild('name').endAt('banana').on('child_added', (data) => {
  console.log('end at:', data.val().name)
})

fruitsRef.orderByChild('name').equalTo('banana').on('child_added', (data) => {
  console.log('equal to filter:', data.val().name)
})

fruitsRef.orderByChild('price').startAt(10).on('child_added', (data) => {
  console.log('age filter:', data.val().name)
})
```


## Check Connectivity

```js
const connectedRef = firebase.database().ref('.info/connected')

connectedRef.on('value', (snapshot) => {
  if (snapshot.val() === true) {
    console.log('connected')
  } else {
    console.log('not connected')
  }
})
```
