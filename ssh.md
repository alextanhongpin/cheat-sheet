## Copy stuff from a ssh to local directory

```bash
$ scp alex@private.ip:filename .

# e.g.
$ scp alex@sunshine.engineers.my:/etc/docker-compose/event-ui/data.json .
```

## SSH Amazon EC2

Use the chmod command to make sure that your private key file isn't publicly viewable. For example, if the name of your private key file is my-key-pair.pem, use the following command:

```bash
$ chmod 400 /path/my-key-pair.pem

$ ssh -i /path/my-key-pair.pem ec2-user@ec2-198-51-100-1.compute-1.amazonaws.com
```
