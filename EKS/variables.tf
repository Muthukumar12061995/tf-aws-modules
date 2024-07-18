variable "env" {type = string}
variable "cluster_name" {type = string}
variable "cluster_version" {type = string}
variable "vpc_ids" {
  type = string
}
variable "cluster_subnet_ids" {
  type = list(string)
  default = [""]
}

# variable "eks_managed_node_groups " {
#     type = map(object({
#       node_group_name = string
#       instance_types = list(string)
#       subnet_ids = list(string)
#       desired_size = number
#     }))

#     default = {
#       "default-worker-node" = {
#         node_group_name = ""
#         instance_types = ""
#         subnet_ids = ""
#         desired_size = 0
#         min_size = 1
#         max_size = 1
#       }
#     }
  
# }