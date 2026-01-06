#############################
# SSH Key Pair (Generated)
#############################
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = "${var.key_name}-${var.environment}"
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
  name        = "ec2-sg-${var.environment}"
  description = "EC2 Security Group for ${var.environment}"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH Access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "ec2-sg-${var.environment}"
    Environment = var.environment
  }
}

#############################
# IAM Role + S3 Access
#############################
resource "aws_iam_role" "ec2_role" {
  name = "ec2-s3-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Environment = var.environment
  }
}

resource "aws_iam_policy" "s3_policy" {
  name        = "ec2-s3-policy-${var.environment}"
  description = "Allow EC2 access to S3 bucket ${var.s3_bucket}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ]
      Resource = [
        "arn:aws:s3:::${var.s3_bucket}",
        "arn:aws:s3:::${var.s3_bucket}/*"
      ]
    }]
  })
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

resource "aws_iam_instance_profile" "this" {
  name = "ec2-instance-profile-${var.environment}"
  role = aws_iam_role.ec2_role.name
}

#############################
# EC2 Instance
#############################
resource "aws_instance" "this" {
  count = var.ec2_count

  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  iam_instance_profile   = aws_iam_instance_profile.this.name
  vpc_security_group_ids = [aws_security_group.this.id]

  tags = {
    Name        = "Terraform-EC2-${var.environment}-${count.index + 1}"
    Environment = var.environment
  }
}
