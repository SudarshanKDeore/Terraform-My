    bucket         = "terraform-state-prod-123"
    key            = "ec2/prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true