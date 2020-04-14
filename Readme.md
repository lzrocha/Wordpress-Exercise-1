# Hosting WordPress on AWS - Exercise 1

Version 2020.4.1 :satellite:

## Overview

This reference architecture provides a set of resources to create an highly available, elastic,and scalable WordPress environment on AWS.

<p align="center">
  <img src="images/aws-architecture.png?style=centerme" alt="Architecure Overview">
</p>



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

## Reference

[Acloud Guru - AWS Certified Solutions Architect 2020](https://acloud.guru/learn/aws-certified-solutions-architect-associate)


[Chapter 8.7 HA WordPress site](https://acloud.guru/course/aws-certified-solutions-architect-associate/learn/ha-architecture/wp-site/watch?_ga=2.214962583.1416554729.1586473598-61654316.1571827724)<br>
[Chapter 8.8 Setting up EC2](https://acloud.guru/course/aws-certified-solutions-architect-associate/learn/ha-architecture/ec2-setup/watch?_ga=2.214962583.1416554729.1586473598-61654316.1571827724)<br>
[Chapter 8.9 Adding Resiliance and Autoscaling](https://acloud.guru/course/aws-certified-solutions-architect-associate/learn/ha-architecture/resilience-as/watch?_ga=2.214962583.1416554729.1586473598-61654316.1571827724)
<p align="center">
  <img src="images/acloud-guru-ha-wordpress-site.png?style=centerme" alt="Acloud diagram">
</p>|

## Next Updates :warning:

* NAT Gateway
* Custom VPC
