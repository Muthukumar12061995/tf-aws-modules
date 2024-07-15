
locals {
  valid_sg_rules_info = { for k,v in var.var.sg-rules : k=>v 
  if v.port != "" && v.cidr_block != ""  }
}

resource "aws_security_group" "sg" {
  vpc_id = var.vpc-id

  dynamic "ingress" {
    for_each = local.valid_sg_rules_info
    content {
      from_port = each.value.port
      to_port = each.value.port
      protocol = each.value.protocol
      cidr_blocks = each.value.cidr_block
    }
  }

  dynamic "egress" {
    for_each = local.valid_sg_rules_info
    content {
      from_port = each.value.port
      to_port = each.value.port
      protocol = each.value.protocol
      cidr_blocks = each.value.cidr_block
    }
  }

  tags = {
    Name = "${var.tag_name}-sg"
  }
}