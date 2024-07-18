# resource "aws_iam_role" "nodes_role" {
#   name = "${var.env}-nodes-role"
#   assume_role_policy = jsonencode(
#     {
#       Version : "2012-10-17"
#       Statement : [{
#         Action : "stsAssumeRole"
#         Effect : "Allow"
#         Pricipal : {
#           Service : "ec2.amazonaws.com"
#         }
#       }]
#     }
#   )
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
#   role = aws_iam_role.nodes_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
#   role = aws_iam_role.nodes_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
#   role = aws_iam_role.nodes_role.name
#   policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
# }

# resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly_node" {
#   role = aws_iam_role.nodes_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazinEC2ContainerRegistryReadOnly"
# }

# locals {
#   valid_worker_node_info = {
#     for k,v in var.var.worker-node-info : k=>v 
#     if v.node_group_name != "" && v.desired_size != 0 && v.subnet_ids != [""]
#   }
# }

# resource "aws_eks_node_group" "workerNode" {
#   for_each = local.valid_worker_node_info
#   cluster_name = aws_eks_cluster.controlNode.name
#   node_group_name = each.value.node_group_name
#   node_role_arn = aws_iam_role.nodes_role.arn
#   subnet_ids = each.value.subnet_ids 
#   instance_types = each.value.instance_types

#   scaling_config {
#     desired_size = each.value.default
#     min_size = 1
#     max_size = 1
#   }

#   depends_on = [ 
#     aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
#     aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
#     aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly_node
#    ]
# }