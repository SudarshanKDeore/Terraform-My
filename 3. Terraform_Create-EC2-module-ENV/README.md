Jenkins-Terraform_Create-EC2-module-ENV

 ---------------------------------------
 🚀 HOW TO RUN (PER ENV)
----------------------------------------
 Test
 
terraform init -backend-config=backend-test.tf
terraform apply -var-file=env/test.tfvars
----------------------------------------
 Staging

terraform init -backend-config=backend-staging.tf
terraform apply -var-file=env/staging.tfvars
-----------------------------------------
 Production

terraform init -backend-config=backend-prod.tf
terraform apply -var-file=env/prod.tfvars
------------------------------------------
 ✅ FINAL RESULT

✔ Remote backend per environment
✔ Environment-specific tags
✔ EC2 IAM role with S3 access
✔ Production-grade Terraform structure
-------------------------------------------







