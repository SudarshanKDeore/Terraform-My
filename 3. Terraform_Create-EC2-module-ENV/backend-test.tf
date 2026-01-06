terraform {
  backend "s3" {
    bucket         = "terraform-state-test-123"
    key            = "ec2/test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
