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
