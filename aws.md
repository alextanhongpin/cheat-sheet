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

Be careful when renaming the file for the conf. For example, if you rename your /etc/nginx/conf.d/01_proxy.conf to /etc/nginx/conf.d/proxy.conf, the first 01_proxy.conf file you generated won't go away. You need to remove it first.

```
files:
  "/etc/nginx/conf.d/proxy.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
      client_max_body_size 50M;

container_commands:
  01_remove_proxy:
    command: "rm -rf /opt/elasticbeanstalk/support/conf/proxy.conf /etc/nginx/conf.d/proxy.conf"
  02_reload_nginx:
    command: "sudo service nginx reload"
```

NOTE: Found out that if the name is `.ebextensions/client_max_body_size.conf`, it will not work. The naming should be `.ebextensions/client_max_body_size.config`:
```nginx
files:
  "/etc/nginx/conf.d/proxy.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
      client_max_body_size 50M;

container_commands:
  reload_nginx:
    command: "sudo service nginx restart"
```

## Elasticbeanstalk Go nginx.conf

https://stackoverflow.com/questions/24860426/nginx-config-file-overwritten-during-elastic-beanstalk-deployment
https://aws.amazon.com/blogs/aws/elastic-beanstalk-update-support-for-java-and-go/

## Cloudwatch Conditional query

```[ip, , ,timestamp, url = *register* || url = *packages*, status = 200 || status = 401, ...]```


## Cleanup image for elasticbeanstalk docker

The file should be in `.ebextensions/docker_cleanup.conf`. Note that the command must be in "".
```
container_commands:
  remove_backup:
    command: "docker system prune -f --volumes"
```

If the command is executed correctly, you should see the logsin `cfn-init-cmd.log`:

```
2019-01-15 01:06:44,539 P2921 [INFO] Command 00removebackup
2019-01-15 01:06:44,541 P2921 [INFO] Completed successfully.
```
References:
- https://forums.aws.amazon.com/thread.jspa?threadID=171537

## Docker Elasticbeanstalk LogRotate

It seems that running the docker in Elasticbeanstalk will not clear the rotated logs, which will keep building until the maxfile system is used up. 

![root_file_system](./assets/root_file_system.png)
![max_root_file_system](./assets/max_root_file_system.png)

On second thoughts, it seems like some part of the logs are rotated, but not all. There are still parts that are continuosly being appended:

(Updated) It seems like the plain logs from `/var/log/eb-docker` is rotated correctly, hence the drop in the size for the root file system, but the json logging in `/var/lib/docker/containers/*/*.log` is not. Consider excluding the `/var/log/eb-docker` section in the `.config` below... [Source](https://forums.aws.amazon.com/thread.jspa?threadID=164502)


![root_file_system_stairs](./assets/root_file_system_stairs.png)

In ~~`.ebextensions/docker_logs_rotate.conf`~~ NOTE: if the extensions ends with `.conf`, it seems that the file will not be created. The correct naming should be `.ebextensions/dockerlogs_rotate.config`:


```
files:
  "/etc/logrotate.elasticbeanstalk.hourly/logrotate.elasticbeanstalk.dockerlogs.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
        /var/log/eb-docker/containers/eb-current-app/* {
        size 100M
        rotate 5 
        missingok
        compress
        notifempty
        copytruncate
        dateext
        dateformat %s
        olddir /var/log/eb-docker/containers/eb-current-app/rotated
        }
        /var/lib/docker/containers/*/*.log {
        size 100M
        rotate 5 
        missingok
        compress
        notifempty
        copytruncate
        dateext
        dateformat %s
        olddir /var/log/eb-docker/containers/eb-current-app/rotated
        }

  "/etc/cron.hourly/cron.logrotate.elasticbeanstalk.dockerlogs.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
        #!/bin/sh
        test -x /usr/sbin/logrotate || exit 0
        /usr/sbin/logrotate /etc/logrotate.elasticbeanstalk.hourly/logrotate.elasticbeanstalk.dockerlogs.conf
```

After deploying the `.ebextentions`, the logs in docker will now be rotated hourly:

![stable_root_file_system](./assets/stable_root_file_system.png)

- https://gist.github.com/almoraes/47a02e2832129dc8c5ffebac045774f8
- https://forums.aws.amazon.com/thread.jspa?threadID=164502
- https://stackoverflow.com/questions/36823982/aws-beanstalk-environment-isnt-rotating-docker-container-logs
- https://serverfault.com/questions/871653/amazon-aws-elastic-beanstalk-ebs-logs-to-cloudwatch-multi-docker-env


## Cloudwatch

Stream json logs to cloudwatch to enable us to perform many different queries.
```
# General query, match all.
"error"

# Query the nested json field with the name Sidekiq.
{$.name = "Sidekiq"}

# Query the nested json field with multiple conditions.
{($.name = "Sidekiq") && ($.level = "error") }
```

## Cloudwatch Insights

Get the average timestamp of the controller actions. NOTE: Using percentil is more accurate.
```
Cloud watch insights
fields @timestamp, @message
| sort @timestamp desc
| stats avg(duration_ms) as total by payload.controller, payload.action
| sort total desc
| limit 20
```

Get the total count of occurances of the log level (error, info etc)
```
fields @timestamp, @message
| sort @timestamp desc
| stats count(level) as total by level
| sort total desc
| limit 20
```

Get the 95th percentile of the the services grouped by the controller and actions.
```
fields @timestamp, @message
| sort @timestamp desc
| stats percentile(duration_ms, 95) as total by payload.controller, payload.action
| sort total desc
| limit 20
```

## Accessing environment variable in .ebextensions

https://stackoverflow.com/questions/29423608/accessing-environment-variables-in-aws-beanstalk-ebextensions
```
files:
  "/etc/nginx/nginx.conf" :
    mode: "000644"
    owner: root
    group: root
    content: |
      worker_processes `{"Fn::GetOptionSetting": {"Namespace": "aws:elasticbeanstalk:application:environment", "OptionName": "MYVAR"}}`;
```

## Eb init without interactive

```bash
$ eb init --region ap-southeast-1 --platform "arn:aws:elasticbeanstalk:ap-southeast-1::platform/Puma with Ruby 2.2 running on 64bit Amazon Linux/2.10.2" <application-name>
```

## Debugging memory
```
$ free -m
```
Output:
```
             total       used       free     shared    buffers     cached
Mem:          3887       2978        908         61         76        273
-/+ buffers/cache:       2628       1258
Swap:            0          0          0
```

```
$ free -h
```
Output:
```
             total       used       free     shared    buffers     cached
Mem:          3.8G       2.9G       907M        61M        76M       273M
-/+ buffers/cache:       2.6G       1.2G
Swap:           0B         0B         0B
```

## Finding threads processes

```bash
$ top -H

# Find threads belonging to process
$ top -H -p <PID>
```

## Apache
Checking version, finding what mom it is running
```
$ apachectl -V
```


### Tuning apache mpm event formula 
```
<IfModule mpm_event_module>
            StartServers              6         #default 3
            ServerLimit               512       #default 16
            ThreadsPerChild           25        #25
            MaxRequestWorkers      12800        #default 400(16x25, server limit * threadsPerChild)
	   ThreadLimit 25 # max equal to threadsPerChild
            MinSpareThreads           64        # MaxRequestWorkers / 4
            MaxSpareThreads          256        #64 MinSpareThreads * 3
            MaxConnectionsPerChild     0
</IfModule>
```

## Getting name

To get environment id and name (note that this is different than instance id)
```
files:
  /path/to/environmentInfo.txt:
    content : |
      Environment Name: `{"Ref": "AWSEBEnvironmentName" }`
      Environment Id:   `{"Ref": "AWSEBEnvironmentId" }`
```
https://marcelog.github.io/articles/get_aws_instance_id_ec2_read_metadata.html


## Docker container logs stdout

In `.ebextensions/log.config`:

```
option_settings:
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: StreamLogs
    value: true
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: DeleteOnTerminate
    value: false
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: RetentionInDays
    value: 7

files:
  "/etc/awslogs/config/stdout.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
      [docker-stdout]
      log_group_name=/aws/elasticbeanstalk/environment_name/docker-stdout
      log_stream_name={instance_id}
      file=/var/log/eb-docker/containers/eb-current-app/*-stdouterr.log

commands:
  "00_restart_awslogs":
    command: service awslogs restart
```
https://stackoverflow.com/questions/41979394/elastic-beanstalk-single-container-docker-use-awslogs-logging-driver
https://stackoverflow.com/questions/49543944/how-can-i-stream-a-specific-log-file-from-multi-container-docker-elastic-beansta

## Dockerrun v2

```yaml
{
    "AWSEBDockerrunVersion": 2,
    "volumes": [{

            "name": "rails-app",
            "host": {
                "sourcePath": "/var/app/current/rails-app"
            }
        },
        {
            "name": "keys",
            "host": {
                "sourcePath": "/etc/pki/tls/certs"
            }
        }
    ],
    "containerDefinitions": [{
        "name": "api",
        "image": "rails/api:latest",
        "essential": true,
        "memory": 512,
        "cpu": 1,
        "mountPoints": [{
                "sourceVolume": "rails-app",
                "containerPath": "/app/tmp”
            },
            {
                "sourceVolume": "keys",
                "containerPath": "/etc/pki/tls/certs"
            }
        ],
        "portMappings": [{
            "containerPort": 3000,
            "hostPort": 80
        }]
    }]

}
```


## Setting up Swap

To fix OOM (out of memory) issues:
```
commands:
  remove_old_swap:
     command: "rm -f /tmp/setup_swap.sh"
  01setup_swap:
    test: test ! -e /var/swapfile
    command: |
      /bin/dd if=/dev/zero of=/var/swapfile bs=1M count=2048
      /bin/chmod 600 /var/swapfile
      /sbin/mkswap /var/swapfile
      /sbin/swapon /var/swapfile
```

## Swap settings

Check if you have swap already, memory and disk size:
```
$ sudo swapon -s
$ free -m
$ df -h
```

Make swap file (change 1G to 4G if you want 4GB SWAP memory)

```
$ sudo fallocate -l 1G /swapfile
```

Check swapfile:
```
$ ls -lh /swapfile
```

Assign swap file:

```bash
$ sudo chmod 600 /swapfile
$ sudo mkswap /swapfile
$ sudo swapon /swapfile
```

Check if swap OK, memory and disk size:
```
$ sudo swapon -s
$ free -m
$ df -h
```

Adjust swap file settings
```
$ cat /proc/sys/vm/swappiness
$ cat /proc/sys/vm/vfs_cache_pressure

$ sudo sysctl vm.swappiness=10
$ sudo sysctl vm.vfs_cache_pressure=50
$ sudo nano /etc/sysctl.conf
```

```
# Swap file priority (0-100, 0: don't put to SWAP, 100: put on SWAP and free the RAM)
vm.swappiness=10 # default is 60

# Remove inode from cache: (100: system removes inode information from the cache too quickly)
vm.vfs_cache_pressure = 50
```


## Multi-container AWS Elasticbeanstalk

When running multi-container, we need to ensure that we specify the log groups for each container in order to send them to cloud watch.
Specifying only one pattern won’t send the logs to cloudwatch.

References:
- https://stackoverflow.com/questions/41979394/elastic-beanstalk-single-container-docker-use-awslogs-logging-driver
- https://gist.github.com/jwhiting/e58d9e6a19d9311df1894f1b03c035a1


```
option_settings:
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: StreamLogs
    value: true
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: DeleteOnTerminate
    value: false
  - namespace: aws:elasticbeanstalk:cloudwatch:logs
    option_name: RetentionInDays
    value: 14

files:
  "/etc/awslogs/config/stdout.conf":
    mode: "000755"
    owner: root
    group: root
    content: |
      [/var/log/containers/server-stdouterr]
      log_group_name=/aws/elasticbeanstalk/`{ "Ref" : "AWSEBEnvironmentName" }`/var/log/server-stdouterr.log
      log_stream_name={instance_id}
      file=/var/log/containers/server-*-stdouterr.log
      [/var/log/containers/worker-stdouterr]
      log_group_name=/aws/elasticbeanstalk/`{ "Ref" : "AWSEBEnvironmentName" }`/var/log/worker-stdouterr.log
      log_stream_name={instance_id}
      file=/var/log/containers/worker-*-stdouterr.log

commands:
  "00_restart_awslogs":
    command: service awslogs restart
```

## Getting Commit ID in CodeShip

This is equivalent to `git rev-parse --short HEAD`, but in Codeship this command is not available. So, we take the first 7 characters of the git commit with the method below:
```
$ git rev-parse HEAD | cut -c1-8
```

## Replace existing .json file with jq

Sometimes we need to use `jq` to find and replace a specific field:
```bash
$ cat test.json | jq .AWSEBDockerrunVersion='"4"'

$ cat test.json | jq --arg VERSION "$VERSION" ".containerDefinitions[0].image"="\"782306342803.dkr.ecr.ap-southeast-1.amazonaws.com/alextanhongpin/api:$VERSION\""

$ cat test.json | jq ".containerDefinitions[0].image"="$(git rev-parse --short HEAD):hello"
```

Do it this way:

```
set -e

# Take only the first 7 characters as the version.
export VERSION=$(echo $CI_COMMIT_ID | cut -c1-7)
export WORKDIR=deploy

# Create a copy of the old configuration.
mv $WORKDIR/Dockerrun.aws.json $WORKDIR/Dockerrun.aws.json.copy

# Set the latest version.
cat $WORKDIR/Dockerrun.aws.json.copy | jq --arg VERSION "$VERSION" ".containerDefinitions[].image"="\"782306342803.dkr.ecr.ap-southeast-1.amazonaws.com/alextanhongpin/api:$VERSION\"" > $WORKDIR/Dockerrun.aws.json

cat $WORKDIR/Dockerrun.aws.json | grep image
```

## Add memory monitoring AWS
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mon-scripts.html

```bash
packages:
  yum:
    perl-DateTime: []
    perl-Sys-Syslog: []
    perl-LWP-Protocol-https: []
    perl-Switch: []
    perl-URI: []
    perl-Bundle-LWP: []
sources: 
  /opt/cloudwatch: https://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip
  
container_commands:
  01-setupcron:
    command: |
      echo '*/5 * * * * root perl /opt/cloudwatch/aws-scripts-mon/mon-put-instance-data.pl `{"Fn::GetOptionSetting" : { "OptionName" : "CloudWatchMetrics", "DefaultValue" : "--mem-util --disk-space-util --disk-path=/" }}` >> /var/log/cwpump.log 2>&1' > /etc/cron.d/cwpump
  02-changeperm:
    command: chmod 644 /etc/cron.d/cwpump
  03-changeperm:
    command: chmod u+x /opt/cloudwatch/aws-scripts-mon/mon-put-instance-data.pl
option_settings:
  "aws:autoscaling:launchconfiguration" :
    IamInstanceProfile : "aws-elasticbeanstalk-ec2-role"
  "aws:elasticbeanstalk:customoption" :
    CloudWatchMetrics : "--mem-util --mem-used --mem
```

## AWS S3 CORS
NOTE: If you do not know which header to allow access to, set `<AllowedHeader>*</AllowedHeader>`.
```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>*</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>Authorization</AllowedHeader>
    <AllowedHeader>X-Amz-*</AllowedHeader>
    <AllowedHeader>Content-Type</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

## SWap

In `.ebextensions/swap.config`:
```
commands:
  remove_old_swap:
     command: "rm -f /tmp/setup_swap.sh"
  01setup_swap:
    test: test ! -e /var/swapfile
    command: |
      /bin/dd if=/dev/zero of=/var/swapfile bs=1M count=2048
      /bin/chmod 600 /var/swapfile
      /sbin/mkswap /var/swapfile
      /sbin/swapon /var/swapfile
```


## Metabase 

Disable Rocket Loader on Cloudflare, and firewall (?)


# JSON Environment Value

Does not work as `{` is not supported.

https://stackoverflow.com/questions/26553553/json-stored-in-aws-eb-environment-variables-is-retrieved-without-quotes

See Environment property limits:
https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/environments-cfg-softwaresettings.html

## Checking IP from curl

```bash
$ curl ifconfig.me/ip
```

## Setting Linux ulimit

```bash
// Check all
$ ulimit -a 

// Check particular
$ ulimit -c // If this is zero, set to unlimited (see next line)

$ ulimit -c unlimited
```

## Amazon Linux Platform 2

### Exporting env vars in build.sh

Env are not exported by default. There are two way:

```bash
$ export $(cat /opt/elasticbeanstalk/deployment/env | xargs)
```

Alternative:
```bash
#!/bin/bash -xe
# See http://tldp.org/LDP/abs/html/options.html
# -x -> Print each command to stdout before executing it, expand commands
# -e -> Abort script at first error, when a command exits with non-zero status
#   (except in until or while loops, if-tests, list constructs

# Getting the environment variables
values=$(/opt/elasticbeanstalk/bin/get-config environment)

## Parsing the json and exporting them as environment variables
for env in $(echo $values | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" ); do
    export $env
done

# Current pwd is /var/app/staging
# When building the binary for go, the output must be in $pwd/application or $pwd/bin/application
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o ./bin/application ./cmd/server/main.go
```

### Setting permissions


Required to make the file executable:
```
$ chmod +x build.sh
```

Adding webapp users:
```bash
$ cd /etc/sudoers

# You can only edit the sudoers file with visudo 
$ sudo visudo

# Add this line at the end
# User rules for webapp user
webapp ALL=(ALL) NOPASSWD:ALL
```

### Buildfile and Procfile

Use `Buildfile` if you need to perform custom builds, or fetching additional data or running migrations etc.

```
# Buildfile
make: ./build.sh
```

Use `Procfile` if you need to run multiple processes aside from server (e.g. background job). If not specified, it will be automatically created with

```
# Procfile
web: bin/application
```

## Useful .ebextensions


`.ebextensions/00-options.config`:

```yaml
option_settings:
  - namespace: aws:elasticbeanstalk:application:environment # Default port is not set to 5000, so you have to pass in an environment variable or hardcode it.
    option_name: PORT
    value: 5000
# Enable webapp users (you don't need this unless $systemctl status make.service or $journalctl -xe says there are missing permissions.
users:
  ec2-user:
    groups:
      - webapp
```

`.ebextensions/01-commands.config`:

```yaml
commands:
  set_time_zone:
    command: "sudo ln -f -s /usr/share/zoneinfo/Singapore /etc/localtime"
  # You don't actually need this, since it is exported by default.
  set_environment:
    command: "export $(cat /opt/elasticbeanstalk/deployment/env | xargs)"
```


### Print env from one Elasticbeanstalk Instance and set in another

```bash
$ eb printenv | grep -v Environment | sed 's/ //g' | xargs > envvars.txt

grep -v Environment: Removes the first line
sed 's/ //g': Removes all white line
xargs: remove new lines so that all variables are in one line

$ eb setenv key=value
```

