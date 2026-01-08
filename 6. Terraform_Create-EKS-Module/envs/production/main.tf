terraform {
  backend "s3" {}
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = "prod-eks"
  desired_size = 4
  min_size     = 3
  max_size     = 5
}
