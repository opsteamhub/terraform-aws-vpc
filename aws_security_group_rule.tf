#
# Add inbound rules on Security Group
#
resource "aws_security_group_rule" "ingress_rules" {
  for_each = {
    for item in flatten(
      var.vpc_config.security_groups != null ? [
        for sg in var.vpc_config.security_groups :
        sg.ingress != null ? [
          for rule in sg.ingress : {
            sg_name     = sg.name
            from_port   = rule.from_port
            to_port     = rule.to_port
            protocol    = rule.protocol
            cidr_blocks = rule.cidr_blocks
          }
        ] : []
      ] : []
    ) : "${item.sg_name}-${item.from_port}-${item.to_port}" => item
  }

  type        = "ingress"
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.security_group[each.value.sg_name].id
}

#
# Add outbound rules on Security Group
#
resource "aws_security_group_rule" "egress_rules" {
  for_each = {
    for item in flatten(
      var.vpc_config.security_groups != null ? [
        for sg in var.vpc_config.security_groups :
        sg.egress != null ? [
          for rule in sg.egress : {
            sg_name     = sg.name
            from_port   = rule.from_port
            to_port     = rule.to_port
            protocol    = rule.protocol
            cidr_blocks = rule.cidr_blocks
          }
        ] : []
      ] : []
    ) : "${item.sg_name}-${item.from_port}-${item.to_port}" => item
  }

  type        = "egress"
  from_port   = each.value.from_port
  to_port     = each.value.to_port
  protocol    = each.value.protocol
  cidr_blocks = each.value.cidr_blocks

  security_group_id = aws_security_group.security_group[each.value.sg_name].id
}

