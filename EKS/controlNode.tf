
# Cluster IAM role
resource "aws_iam_role" "cluster_role" {
  name = "${var.env}-cluster-role"
  assume_role_policy = jsonencode(
    {
      Version : "2012-10-17"
      Statement: [
        {
          Action : "std:AssumeRole"
          Effect : "Allow"
          Pricipal : {
            Service : "ec2.amazonaws.com"
          }
        }
      ]
    }
  )
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  role = aws_iam_role.cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
#   role = aws_iam_role.cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

resource "aws_eks_cluster" "controlNode" {
  name = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  version = var.cluster_version

  vpc_config {
     subnet_ids = var.cluster_subnet_ids
  }

  depends_on = [ aws_iam_role.cluster_role ]
}

