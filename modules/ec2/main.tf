

// Create aws_ami filter to pick up the ami available in your region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

// Filter to find ubuntu instances

data "aws_ami" "ubuntu-2204" {
  most_recent = true
  owners = ["099720109477"]
  
  filter {
  	name = "name"
  	values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
     
  filter {
	name   = "virtualization-type"
	values = ["hvm"]
  }
   
}
  	
  	
  	
// Configure the EC2 instance in a public subnet
resource "aws_instance" "ec2_public" {
  // Number of instances
  count = 4
  // Other details
  ami                         = data.aws_ami.ubuntu-2204.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  key_name                    = var.key_name
  subnet_id                   = var.vpc.public_subnets[0]
  vpc_security_group_ids      = [var.sg_pub_id]

  user_data = <<-EOF
  			  #!/bin/bash
  			  sudo apt update
  			  sudo apt-get install tinyproxy -y
  			  sudo echo "Allow ${var.ip_address}" >> /etc/tinyproxy/tinyproxy.conf
  			  sudo systemctl restart tinyproxy
  			  EOF 
  			  				

  tags = {
    "Name" = "${var.namespace}-${count.index}-EC2-PUBLIC"
  }

  # Copies the ssh key file to home dir
  provisioner "file" {
    source      = "./${var.key_name}.pem"
//    destination = "/home/ec2-user/${var.key_name}.pem"
    destination = "/home/ubuntu/${var.key_name}.pem"

    connection {
      type        = "ssh"
//      user        = "ec2-user"
	  user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }
  }
  
  //chmod key 400 on EC2 instance
  provisioner "remote-exec" {
    inline = ["chmod 400 ~/${var.key_name}.pem"]

    connection {
      type        = "ssh"
//      user        = "ec2-user"
      user        = "ubuntu"
      private_key = file("${var.key_name}.pem")
      host        = self.public_ip
    }

  }

}
