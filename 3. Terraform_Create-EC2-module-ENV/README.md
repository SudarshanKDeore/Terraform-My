
 # Jenkins-Terraform_Create-EC2-module-ENV

## Create S3 Bucket & DynamoDB table manualy first
```
S3 Bucket Name - terraform-state-test-1234

aws s3api create-bucket --bucket terraform-state-test-1234 --region us-east-1 --create-bucket-configuration LocationConstraint=region us-east-1


DynamoDB Table Name - terraform-locks

aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --billing-mode PAY_PER_REQUEST --tags Key=Environment,Value=test Key=Name,Value="Terraform State Lock" --region us-east-1

```
 ---------------------------------------
## HOW TO RUN (PER ENV)
----------------------------------------
## Test
```
terraform init -backend-config="backend-test.hcl"
terraform init -reconfigure -backend-config="backend-test.hcl"
terraform plan -var-file="env/test.tfvars"
terraform apply -var-file="env/test.tfvars"
terraform destroy -var-file="env/test.tfvars"
```
## If lock is stuck (NOT recommended unless emergency)
```
terraform destroy -lock=false -var-file="env/test.tfvars"
```
----------------------------------------
## Staging
```
terraform init -backend-config="backend-staging.hcl"
terraform apply -var-file="env/staging.tfvars"
```
-----------------------------------------
## Production
```
terraform init -backend-config="backend-prod.hcl"
terraform apply -var-file="env/prod.tfvars"
```
------------------------------------------
 ## FINAL RESULT
```
✔ Remote backend per environment
✔ Environment-specific tags
✔ EC2 IAM role with S3 access
✔ EC2 scaling per environment
✔ Production-grade Terraform structure
```
-------------------------------------------














