# AWS Cheatsheet

## Changing profile

You will have different IAM policy and have it configured in your `.aws/credentials` file. You need to change to another profile:
```bash
$ aws configure --profile profileName
```


## Dynamodb

Get the total count of items in the table

```bash
$ aws dynamodb scan --table-name job-production --select "COUNT"
```
