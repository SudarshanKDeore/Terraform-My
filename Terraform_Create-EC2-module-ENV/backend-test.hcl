    bucket         = "terraform-state-test-1234"
    key            = "ec2/test/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true