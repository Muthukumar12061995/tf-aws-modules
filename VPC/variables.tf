variable "tag_name" {type = string}
variable "vpc_cidr_block" {type = string}
variable "public_subnets" {
  type = map(object({
    cidr_block = string
    azs = string 
    map_public_ip_on_launch = bool
  }))

  default = {
    "default-subnet" = {
      cidr_block = ""
      azs = ""
      map_public_ip_on_launch = false
    }
  }
}

variable "private_subnets" {
  type = map(object({
    cidr_block = string
    azs = string
  }))

  default = {
    default-subnet = {
      cidr_block = ""
      azs = ""
    }
  }
}
variable "nat_gateways" {
  type=bool
  default = false
}
