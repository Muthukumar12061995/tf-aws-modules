resource "aws_key_pair" "ssh-key" {
  key_name = "ec2-ssh-key"
  public_key = file(var.ssh-key-path)
}

resource "aws_instance" "ec2" {
   for_each = { for k,v in var.var.ec2-info : k => v if v.ami != "" && v.instance_type !="" && v.subnet_id !="" }

   ami = each.value.ami
   instance_type = each.value.instance_type
   subnet_id = each.value.subnet_id
   key_name = each.value.ssh-acces ? aws_key_pair.ssh-key.key_name : ""
   security_groups = each.value.security_groups
}