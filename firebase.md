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
