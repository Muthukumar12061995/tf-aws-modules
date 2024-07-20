variable "tag-name" {
  type = string
}

variable "vpc-id" {
  type = string
}

variable "sg-rules" {
  type = map(object({
    port = string
    protocol = string
    cidr_blocks = list(string)
  }))

  default = {
    "default-sg-rule" = {
      port = ""
      protocol = ""
      cidr_blocks = [""]
    }
  }
}