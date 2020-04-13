# Hosting WordPress on AWS - Exercise 1

Version 2020.4.1 :satellite:

## Overview

Highly available, elastic, scalable WordPress environment (AWS Free Tier resources only).

This reference architecture provides a template for deploying WordPress on AWS using a set of resources.

![architecture-Overview](images/aws-architecture.png)


## Boostrap
```bash
#!/bin/bash
yum update -y aws-cfn-bootstrap
yum update -y
yum install httpd24 php70 php70-mysqlnd -y
cd /var/www/html
aws s3 cp --recursive s3://YOUR-BUCKET-CODE-NAME . 
chmod -R 755 wp-content
chown -R apache:apache wp-content
chown -R apache /var/www
chgrp -R apache /var/www
sed -i 's/localhost/'DATABASE-ENDPOINT'/g' wp-config.php
sed -i 's/database_name_here/DATABASE-NAME/g' wp-config.php
sed -i 's/username_here/DATABASE-USERNAME/g' wp-config.php
sed -i 's/password_here/DATABASE-PASSWORD/g' wp-config.php
sed -i -e "20 i\define('WP_HOME','https://www.YOURSITE.com');" wp-config.php
sed -i -e "21 i\define('WP_SITEURL','https://www.YOURSITE.com');" wp-config.php
cd /etc
sed -i -e '$  a\*/1 * * * * root aws s3 cp --recursive /var/www/html/wp-content/uploads s3://YOUR-BUCKET-NAME/wp-content/uploads' crontab
chkconfig httpd on
service httpd start
```

## Steps to run

To launch the entire stack and deploy a WordPress site on AWS, click on one of the Launch Stack links below or download the Master template and launch it locally.

You can launch this CloudFormation stack, using your account, in the following AWS Regions:

| AWS Region Code | Name | Launch |
| --- | --- | ---
| us-east-1 |US East (N. Virginia)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |
| us-east-2 |US East (Ohio)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |
| us-west-2 |US West (Oregon)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |
| eu-west-1 |EU (Ireland)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-west-1#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |
| eu-central-1 |EU (Frankfurt)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=eu-central-1#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |
| ap-southeast-2 |AP (Sydney)| [![cloudformation-launch-stack](images/launch-stack.png)](https://console.aws.amazon.com/cloudformation/home?region=ap-southeast-2#/stacks/new?stackName=WordPress&templateURL=https://luizfel-templates.s3.amazonaws.com/Wordpress/02-WP-SG-RDS-EFS-S3-ELB-CF-ASG.yaml) |

## Reference

Acloud lessons list
acloud architecture image
aws best practices

#### :warning: Requirements :warning:

- Key Pair
- Hosted Zone on Route53
- Vpc

## Next Updates

* Bastion
* DB Encryption
* Custom VPC
