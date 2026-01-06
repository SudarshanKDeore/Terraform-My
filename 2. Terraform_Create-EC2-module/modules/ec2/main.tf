#############################
# Generate SSH Key Pair
#############################
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "private_key" {
  content         = tls_private_key.ec2_key.private_key_pem
  filename        = "${path.root}/${var.key_name}.pem"
  file_permission = "0400"
}

resource "local_file" "public_key" {
  content  = tls_private_key.ec2_key.public_key_openssh
  filename = "${path.root}/${var.key_name}.pub"
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

#############################
# Default VPC
#############################
data "aws_vpc" "default" {
  default = true
}

#############################
# Security Group
#############################
resource "aws_security_group" "this" {
  name        = "ec2_security_group"
  description = "Allow SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#############################
# EC2 Instance
#############################
resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name

  vpc_security_group_ids = [
    aws_security_group.this.id
  ]

  tags = {
    Name = "Terraform-EC2"
  }
}
