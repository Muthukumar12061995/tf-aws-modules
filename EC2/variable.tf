variable "ssh-key-path" {
  default = "~/.ssh/ec2.pub"
  sensitive = true
}

variable "ec2-info" {
  type = map(object({
    ami = string
    instance_type = string
    ssh_acces = bool
    //security-groups = list(string)
  }))

  default = {
    "default-ec2" = {
      ami = ""
      instance_type = ""
      ssh_acces = false
    }
  }
}

variable "subnet-id" {
  type = string

  default = ""
}