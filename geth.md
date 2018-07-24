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

## Geth Clique

Start a geth that connects to Rinkeby PoA:
```bash
geth --rinkeby --nodiscover
```

Output:

```bash
<NOT_SHOWN>
INFO [07-24|12:39:27] IPC endpoint opened                      url=/Users/yourusername/Library/Ethereum/rinkeby/geth.ipc
```

Connect to the geth console:
```bash
geth attach /Users/yourusername/Library/Ethereum/rinkeby/geth.ipc
```

Output:
```
Welcome to the Geth JavaScript console!

instance: Geth/v1.8.11-stable/darwin-amd64/go1.10.3
 modules: admin:1.0 clique:1.0 debug:1.0 eth:1.0 miner:1.0 net:1.0 personal:1.0 rpc:1.0 txpool:1.0 web3:1.0
```

You can now interact with the clique api:
```
> clique
{
  proposals: {},
  discard: function(),
  getProposals: function(callback),
  getSigners: function(),
  getSignersAtHash: function(),
  getSnapshot: function(),
  getSnapshotAtHash: function(),
  propose: function()
}
> clique.getSnapshot()
{
  hash: "0x6341fd3daf94b748c72ced5a5b26028f2474f5f00d824504e4fa37a75767e177",
  number: 0,
  recents: {},
  signers: {
    0x42eb768f2244c8811c63729a21a3569731535f06: {},
    0x7ffc57839b00206d1ad20c69a1981b489f772031: {},
    0xb279182d99e65703f0076e4812653aab85fca0f0: {}
  },
  tally: {},
  votes: null
}
```
