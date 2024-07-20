variable "ssh-key-path" {
  default = "~/.ssh/ec2.pub"
  sensitive = true
}

variable "ec2-info" {
  type = map(object({
    ami = string
    instance_type = string
    ssh_acces = bool
    security_groups = list(string)
    user_data = string
    volume_size = number
  }))

  default = {
    "default-ec2" = {
      ami = ""
      instance_type = ""
      ssh_acces = false
      security_groups = [""]
      user_data = ""
      volume_size = 0
    }
  }
}

variable "subnet-id" {
  type = string

  default = ""
}
