terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.25.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "aws" {
  region = var.aws_region
}

module "ec2" {
  source = "./modules/ec2"

  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  environment   = var.environment
  s3_bucket     = var.s3_bucket
  ec2_count     = var.ec2_count
  ssh_cidr_blocks   = var.ssh_cidr_blocks
}

