# tf-aws-proxies
Terraform scripts to generate multiple proxies

## Requirements
Requires terraform and AWS CLI. Also, I prefer to run "aws configure" and keep my creds that way, but you can use environment variables per the terraform docs. 

## Variables
Make sure you set your region and namespace in the variables.tf before starting. It will prompt you for ip_address at runtime, or add --var "ip_address=<your host internet ip>" on the command line.

Number of hosts is set in ec2/main.tf 

## TODO
- Set more variables at command line.


## Greetz/references
- https://github.com/bugbiteme/demo-tform-aws-vpc
- https://www.ptimofeev.com/proxy-server-with-terraform-on-amazon-aws/
- https://www.squadcast.com/blog/how-to-deploy-multiple-ec2-instances-in-one-go-using-terraform
