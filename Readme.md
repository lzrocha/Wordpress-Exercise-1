# Hosting WordPress on AWS
Stack to deploy a highly available, elastic, scalable WordPress environment (AWS Free Tier resources only).

Version 1.0 :satellite:

## Overview

This reference architecture provides a YAML template for deploying WordPress on AWS using a set of resources.

![architecture-Overview](images/aws-architecture.png)


## List of Resources
```YAML
#CloudFormation
  AWS::CloudFormation::Interface:

#Compute
  AWS::AutoScaling::AutoScalingGroup
  AWS::AutoScaling::LaunchConfiguration
  AWS::EC2::SecurityGroup
  AWS::EC2::SecurityGroupIngress
  AWS::ElasticLoadBalancingV2::Listener
  AWS::ElasticLoadBalancingV2::LoadBalancer
  AWS::ElasticLoadBalancingV2::TargetGroup

#Storage
  AWS::EFS::FileSystem
  AWS::EFS::MountTarget
  AWS::S3::Bucket

#Security, Identity, & Compliance
  AWS::IAM::InstanceProfile
  AWS::IAM::Policy

#Database
  AWS::RDS::DBSubnetGroup
  AWS::RDS::DBInstance

#Networking & Content Delivery
  AWS::CloudFront::Distribution
  AWS::CloudFront::CloudFrontOriginAccessIdentity
  AWS::Route53::RecordSetGroup
```

## Parameters

Name | Description | Required
------------ | ------| -------------
**VpcId** | The VPC ID of an existing VPC | *Yes*
**Subnet** | The existing subnets | *Yes*
**Number Of Subnets** | The number of subnets| *Yes*
**EC2 instance type** | WebServer EC2 instance type | No
**Key Pair Name** | Name of an existing EC2 KeyPair to enable SSH access to the instances | *Yes*
**SSHLocation** | The IP address range that can be used to SSH to the EC2 instances | No
**Number of Instances** | The initial number of WebServer instances | No
**ALB Certificate ARN** | The AWS Certification Manager certificate ARN for the ALB certificate | No
**Wordpress DNS** | The main domain name of the WordPress site | *Yes*
**Database Instance Type** | Database instance class | *Yes*
**Database Name**| The Amazon RDS master database name. | *Yes*
**Database User** | The Amazon RDS master username | *Yes*
**Database Password** | The Amazon RDS master password | *Yes*
**Performance Mode**| The performance mode of the file system | No

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

#### :warning: Requirements :warning:

- User with allowed permissions to CloudFormation
- Key Pair
- Hosted Zone on Route53
- Vpc

## Next Updates

* Bastion
* DB Encryption
* Custom VPC
