variable "env" {type = string}
variable "cluster_name" {type = string}
variable "cluster_version" {type = string}
variable "cluster_subnet_ids" {
  type = list(string)
  default = [""]
}

variable "worker-node-info" {
    type = map(object({
      node_group_name = string
      instance_types = list(string)
      subnet_ids = list(string)
      desired_size = number
      min_size = number
      max_size = number
    }))

    default = {
      "default-worker-node" = {
        node_group_name = ""
        instance_types = ""
        subnet_ids = ""
        desired_size = 0
        min_size = 0
        max_size = 0
      }
    }
  
}