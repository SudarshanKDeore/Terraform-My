aws_region    = "us-east-1"
ami_id        = "ami-0ecb62995f68bb549"
instance_type = "t3.medium"
key_name      = "prod-key"
environment   = "prod"
s3_bucket     = "my-prod-app-bucket"
ec2_count     = 3
ssh_cidr_blocks = ["0.0.0.0/0"]
