# tf-aws-proxies
Terraform scripts to generate multiple proxies. Uses tinyproxy for http and dante for socks proxy. 

## Open Ports
tcp/22 - ssh
tcp/1080 - socks proxy
tcp/8888 - http proxy

## Requirements
Requires terraform and AWS CLI. Also, I prefer to run "aws configure" and keep my creds that way, but you can use environment variables per the terraform docs. 

## Variables
Make sure you set your region and namespace in the variables.tf before starting. It will prompt you for ip_address at runtime, or add --var "ip_address=yourhostinternetip" on the command line. This IP sets the allowed IP to use the proxies and sets the security groups in AWS to allow ssh and the proxy ports. 

Number of hosts desired is set in variables.tf. The default is 2. 

## Install
- Install terraform and AWS CLI
- Configure your AWS credentials via "aws configure"
- Clone the repo
- set variables as appropriate
- terraform init
- terraform plan --var "ip_address=<your internet ip>
- terraform apply
- To remove infra - terraform destroy --var "ip_address=<your internet ip>

## Output
- terraform output -json  public_ip_list | jq -r '.[]' > ip.txt

## TODO
- Set more variables at command line.


## Greetz/references
- https://github.com/bugbiteme/demo-tform-aws-vpc
- https://www.ptimofeev.com/proxy-server-with-terraform-on-amazon-aws/
- https://www.squadcast.com/blog/how-to-deploy-multiple-ec2-instances-in-one-go-using-terraform
- https://www.andreagrandi.it/2017/08/25/getting-latest-ubuntu-ami-with-terraform/
