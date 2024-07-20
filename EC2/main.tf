resource "aws_key_pair" "ssh-key" {
  key_name = "ec2-ssh-key"
  public_key = file(var.ssh-key-path)
}

locals {
  valid_ec2_info = {
    for k,v in var.ec2-info : k=>v
    if v.ami != "" && v.instance_type != ""
  }
}

resource "aws_instance" "ec2" {
   for_each = local.valid_ec2_info
   ami = each.value.ami
   instance_type = each.value.instance_type
   subnet_id = var.subnet-id
   key_name = each.value.ssh_acces ? aws_key_pair.ssh-key.key_name : ""
   security_groups = each.value.security_groups
   user_data = each.value.user_data

   root_block_device {
     volume_size = each.value.volume_size
   }
}
