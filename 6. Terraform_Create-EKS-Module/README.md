# Terraform_Create-EKS-Module

## Remote Backend per Environment
#####################################################
```
▶️ How Terraform Uses backend.hcl

cd envs/test
terraform init -backend-config=backend.hcl

Terraform:
Reads backend block
Injects values from backend.hcl
Stores state in correct S3 key

🧠 Execution Flow 
terraform init  → backend.hcl read → S3 state selected
terraform plan  → reads remote state
terraform apply → updates remote state
```
######################################################
# 📁 Final Folder Structure (Rewritten)
```
terraform-eks/
│
├── modules/
│   └── eks/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── envs/
│   ├── test/
│   │   ├── main.tf
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   │
│   ├── staging/
│   │   ├── main.tf
│   │   ├── backend.hcl
│   │   └── terraform.tfvars
│   │
│   └── production/
│       ├── main.tf
│       ├── backend.hcl
│       └── terraform.tfvars
│
└── provider.tf
```
