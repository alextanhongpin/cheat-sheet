# AWS Cheatsheet

## Installation

AWS ECS CLI
```bash
$ curl -o /usr/local/bin/ecs-cli https://s3.amazonaws.com/amazon-ecs-cli/ecs-cli-darwin-amd64-latest

$ chmod +x /usr/local/bin/ecs-cli

$ ecs-cli --version
ecs-cli version 1.6.0 (95406b1)
```

AWS EB CLI

```bash
$ pip install awsebcli --upgrade --user

# Alternatively
$ brew install awsebcli
```

AWS CLI

```bash
$ brew install awscli
```

## Changing profile

You will have different IAM policy and have it configured in your `.aws/credentials` file. You need to change to another profile:
```bash
$ aws configure --profile profileName
```

```bash
$ export AWS_ACCESS_KEY_ID=AKIAIOSFODNN7EXAMPLE
$ export AWS_SECRET_ACCESS_KEY=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
$ export AWS_DEFAULT_REGION=us-west-2
```

## Dynamodb

Get the total count of items in the table

```bash
$ aws dynamodb scan --table-name job-production --select "COUNT"
```


## Updating Region
```javascript
const aws = require('aws-sdk')
aws.config.update({
    region: 'ap-southeast-1',
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
})
```

## Setting Credentials

```javascript
const aws = require('aws-sdk')
const credentials = new aws.SharedIniFileCredentials({ profile: 'email-delivery' })
aws.config.credentials = credentials;
aws.config.region = 'ap-southeast-1'
```

## Copy data from S3
```
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} aws s3 cp s3://url/data.zip data.zip
```

## Elasticbeanstalk Worker Connections Not Enough

Increase worker connection from 1024 to 6144. The content of the file in `.ebextensions/nginx.config`:

```
files:
  "/etc/security/limits.conf":
    content: |
      *           soft    nofile          6144
      *           hard    nofile          6144
container_commands:
    01-worker-connections:
        command: "/bin/sed -i 's/worker_connections  1024/worker_connections  6144/g' /tmp/deployment/config/#etc#nginx#nginx.conf"
```

## Run AWS Command with profile

```bash
$ aws ... --profile profile_name
```

## Sample boilerplate code for AWS Elasticbeanstalk Worker Environment with SQS

```javascript
// app.js

const express = require('express')
const bodyParser = require('body-parser')
const request = require('request-promise')

const app = express()
const port = process.env.PORT || 3000

app.use(bodyParser.urlencoded({extended: false}))
app.use(bodyParser.json())

app.post('/', (req, res) => {
  const options = {
    method: 'POST',
    uri: 'URL_HERE',
    json: true,
    body: req.body,
    resolveWithFullResponse: true
  }

  request(options)
  .then((body) => {
    console.log(`success: ${body}`)
    return res.status(200).json({
      message: body
    })
  })
  .catch((error) => {
    console.log(`error: ${error.message}`)
    return res.status(400).json({
      error: error.message
    })
  })
})

app.listen(port, () => {
  console.log(`listening to port *:${port}. press ctrl + c to cancel.`)
})
```


## ECS Add Healthcheck

```bash
$ [ "CMD-SHELL", "curl -f http://localhost/ || exit 1" ]
```


## AWS Elasticbeanstalk 

When using Dockerrun.aws.json, remember to exclude other dependencies, such as `Dockerfile`, since it will attempt to rebuild the image using the dockerfile:

```
# Ignore all
*

# Only require the Dockerrun.aws.json
!Dockerrun.aws.json
```

And this is how a sample `Dockerrun.aws.json` would look like:

```json
{
    "AWSEBDockerrunVersion": "1",
    "Image": {
      "Name": "nginx:latest",
      "Update": "true"
    },
    "Ports": [
      {
        "ContainerPort": "8000"
      }
    ],
    "Volumes": [
	    {
		    "HostDirectory": "/var/app/go-ppn-gateway",
		    "ContainerDirectory": "/root/datadir"
	    }
    ],
    "Logging": "/var/log/nginx"
  }
```

## Allow only Cloudflare IPs

When creating an instance, say `Elasticbeanstalk` instance, there will be a unique url that is generated for the application: e.g. `cname-of-your-app.ap-southeast-1.elasticbeanstalk.com`. The problem is everyone can access this. If you route your application through Cloudflare with your own domain name, remember to whitelist the [Cloudflare IPs[(https://www.cloudflare.com/ips/) in the load balancer.

![Cloudflare IP](/assets/cloudflare_ip.png)

Services > EC2 > Network and Security (Security Groups) > Find the load balancer of the target instance > Select `Inbound` > Edit > Add Rule 

And the rule should be 
- Type: `Custom TCP`
- Protocol: TCP
- Port Range: 80
- Source: Custom 
- List of IPs: `103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,104.16.0.0/12,108.162.192.0/18,131.0.72.0/22,141.101.64.0/18,162.158.0.0/15,172.64.0.0/13,173.245.48.0/20,188.114.96.0/20,190.93.240.0/20,197.234.240.0/22,198.41.128.0/17,2400:cb00::/32,2405:b500::/32,2606:4700::/32,2803:f800::/32,2c0f:f248::/32,2a06:98c0::/29`

Also remove the default `0.0.0.0/0`, as this will allow anyone to access the instance.

## Enabling WebSocket

In `.ebignore`:

```
# Ignore all
*

# Only require the Dockerrun.aws.json
!Dockerrun.aws.json

# Required to enable the Websocket. The ** is to allow all subfolders.
!.ebextensions/**
```

In `.ebextensions/websocket_upgrade.conf`:
```
container_commands:
  enable_websockets:
    command: |
     sed -i '/\s*proxy_set_header\s*Connection/c \
              proxy_set_header Upgrade $http_upgrade;\
              proxy_set_header Connection "upgrade";\
      ' /tmp/deployment/config/#etc#nginx#conf.d#00_elastic_beanstalk_proxy.conf
```

In the `Elasticbeanstalk` Load balancer setting, instead of `HTTP`, use `TCP` and `SSL` respectively:


| Port | Protocol | Instance Port | Instance Protocol |
| --   | --       | --            | --                |
| 80   | TCP      | 80	| TCP |
| 443   | SSL      | 80	| TCP |

## SSH
```bash
$ chmod 400 mykeypair.pem
$ bash ssh -i .ec2/mykeypair.pem ec2-user@<public-DNS-of-the-instance>
```


## Security Group Inbound Rules

Point to another Security Group instead, rather than just pointing to a hardcoded instance private IP. Whenever the instance got recreated, the IP will change. Hence it's better to point to the security group instead.

![Security Group](/assets/security_group_aws.png)


## Allow DNS

```
#!/bin/sh
AWS_IP=$(curl http://checkip.amazonaws.com)
aws ec2 authorize-security-group-ingress --group-name awseb-e-zj7rmnppsa-stack-AWSEBSecurityGroup-1OSSN6V65CR7N \
         --protocol tcp --port 22 \
         --cidr $AWS_IP/32
```

## (Close to) Zero-Downtime Deployments 

When running a single instance, it is possible to set the deployment method to `Rolling with Additional Batch` for AWS Elasticbeanstalk. 

The way it works is as follow:

```
- when a new application version is deployed, an instance is created and added to the environment
- the application will be created
- the instance will swap, and if it works, the swap will be permanent
- the old instance will be removed
```

![rolling-with-additional-batch-1.png](./assets/rolling-with-additional-batch-1.png)
![rolling-with-additional-batch-2.png](./assets/rolling-with-additional-batch-2.png)

## Increase client_max_body_size

When deploying for nodejs, the file name must end with `.config`, not `.conf` as when deploying for golang (see the `websocket.conf` example above. The example below overrides the `client_max_body_size` (default is 1MB) which will cause requests larger than 1MB to fail, example when uploading images etc.

The file `.ebextensions/01_nginx.config` contains:

```nginx
files:
  "/etc/nginx/conf.d/01_proxy.conf":
    mode: "000644"
    owner: root
    group: root
    content: |
      client_max_body_size 50M;
      
container_commands:
  01_reload_nginx:
    command: |
      sudo service nginx restart 
```
