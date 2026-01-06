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
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "ec2_count" {
  type = number
}

variable "ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into EC2"
  type        = list(string)
}
