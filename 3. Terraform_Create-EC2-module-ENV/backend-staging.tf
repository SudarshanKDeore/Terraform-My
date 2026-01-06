terraform {
  backend "s3" {
    bucket         = "terraform-state-staging-123"
    key            = "ec2/staging/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
