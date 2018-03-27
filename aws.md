# AWS Cheatsheet

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
AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} aws s3 cp s3://url/data.zip data.zip```


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
