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
```js
const aws = require('aws-sdk')
aws.config.update({
    region: 'ap-southeast-1',
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
})
```
