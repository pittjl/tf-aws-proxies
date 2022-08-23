
data "aws_availability_zones" "available" {}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name                             = "${var.namespace}-vpc"
  cidr                             = "10.254.0.0/16"
  azs                              = data.aws_availability_zones.available.names
  public_subnets                   = ["10.254.100.0/24"]
  create_database_subnet_group     = true
}


// TODO: Allows SSH from anywhere, really should change this to a VAR
resource "aws_security_group" "allow_ssh_pub" {
  name        = "${var.namespace}-allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.ip_address}/32"]
  }
  
  ingress {
	from_port   = 8888
	to_port     = 8888
	protocol    = "tcp"
	cidr_blocks = ["${var.ip_address}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.namespace}-allow_ssh_pub"
  }
}
