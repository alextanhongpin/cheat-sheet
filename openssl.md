Create a public-private key pair. The pair is stored in the generated `mykey.pem` file.

```bash
$ openssl genrsa -out mykey.pem 1024
```

Extract the public key and print it out.

```bash
$ openssl rsa -in mykey.pem -pubout > mykey.pub
```

To just output the public part of a private key:

```bash
$ openssl rsa -in key.pem -pubout -out pubkey.pem
```
