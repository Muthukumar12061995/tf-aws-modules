variable "ssh-key-path" {
  default = "~/.ssh/ec2.pub"
  sensitive = true
}

variable "ec2-info" {
  type = map(object({
    ami = string
    instance_type = string
    ssh-acces = bool
    //security-groups = list(string)
    subnet_id = string
  }))
}