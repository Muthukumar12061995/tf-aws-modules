variable "tag_name" {type = string}
variable "cidr_block" {type = string}
variable "azs" {type = string}
variable "public_subnets" {type = list(string)}
variable "private_subnets" {
  type = list(string)
  default = []
}
variable "nat_gateways" {
  type=bool
  default = false
}
