terraform {
  backend "s3" {}
}

module "eks" {
  source       = "../../modules/eks"
  cluster_name = "staging-eks"
  desired_size = 3
  min_size     = 2
  max_size     = 3
}
