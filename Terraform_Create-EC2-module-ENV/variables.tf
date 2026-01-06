variable "aws_region" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "environment" {
  description = "Environment name (test, staging, prod)"
  type        = string
}

variable "s3_bucket" {
  description = "S3 bucket name for EC2 access"
  type        = string
}

variable "ec2_count" {
  description = "Number of EC2 instances per environment"
  type        = number
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into EC2"
  type        = list(string)
}

