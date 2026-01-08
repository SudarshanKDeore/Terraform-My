terraform {
  backend "s3" {}
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = "test-eks"
  desired_size = 2
  min_size     = 1
  max_size     = 2
}
