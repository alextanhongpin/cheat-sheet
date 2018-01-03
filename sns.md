# Tips and Tricks

- Publish to multiple endpoints using SNS such as Lambda, HTTP, email etc...you have plenty of ways to get data through it
- Build distributed system using SNS
- SNS cannot publish to Elasticbeanstalk internal url - the endpoints has to be public



## Publishing to SNS

```javascript

const AWS = require('aws-sdk')
AWS.config.update({
  region: '<REGION>',
  credentials: new AWS.SharedIniFileCredentials({ profile: '<YOUR_PROFILE>' })
})

const SNS_TOPIC = 'arn:aws:sns:<REGION>:<CONSUMER_ID>:<TOPIC>'
const sns = new AWS.SNS()

function send () {
  const payload = {
    // JSON object you want to post
  }

  const params = {
    Message: JSON.stringify(payload),
    TopicArn: SNS_TOPIC
  }

  sns.publish(params, (error, done) => {
    if (error) {
      console.log(error)
      return
    }
    console.log('success', done)
  })
}

send()
```
