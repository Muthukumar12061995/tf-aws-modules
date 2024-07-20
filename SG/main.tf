
locals {
  valid_sg_rules_info = { for k,v in var.sg-rules : k=>v 
  if v.port != "" && v.cidr_blocks != [""]  }
}

resource "aws_security_group" "sg" {
  vpc_id = var.vpc-id

  dynamic "ingress" {
    for_each = local.valid_sg_rules_info
    content {
      from_port = ingress.value.port
      to_port = ingress.value.port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = local.valid_sg_rules_info
    content {
      from_port = egress.value.port
      to_port = egress.value.port
      protocol = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.tag-name}-sg"
  }
}