# Dump TOML config

```bash
$ geth dumpconfig

$ geth --config /path/to/your_config.toml
```

## Mine Blocks

Will mine blocks at a rate or 1 block per second:

```bash
$ ganache-cli --blockTime 1
# or
$ ganache-cli -b 1
```

## Ganache-cli with WebSocket

Port is 8545, not 8546:

```bash
$ npm install -g ganache-cli@beta
```

```bash
$ geth --rpc --rpcaddr localhost --rpcport 8545 --rpcapi "db,eth,net,web3" --rpccorsdomain "http://localhost:3000" --rinkeby --ws --wsaddr localhost --wsport 8546 --wsorigins * --nodiscover
```

## Web3 Sending

This will create a transaction and emit the event if it has any:

```js
let contract = new web3.eth.Contract(contractABI, contractAddress)
contract.methods.greet().send({
  from: '0x552b2a819ec514a91b35fb45fe83dc96a1d4c319'
}).then(console.log)
```

## Binding Solidity directly

Use `go:generate` to generate the go binding:

```bash
$ abigen --sol token.sol --pkg main --out token.go
```
