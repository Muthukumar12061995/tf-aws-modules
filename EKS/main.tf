locals {

}

resource "aws_eks_cluster" "custom_eks_cluster" {
  name = var.cluster_name
  role_arn = var.cluster_role_arn
  version = var.cluster_version

  vpc_config {
    subnet_ids = [ var.cluster_subnet_ids ]
  }
}