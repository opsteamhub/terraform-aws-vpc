#
# Create security gropus for the current VPC
#
resource "aws_security_group" "security_group" {
  for_each = var.vpc_config.security_groups != null ? { for sg in var.vpc_config.security_groups : sg.name => sg } : {}

  name        = each.value.name
  description = each.value.description

  vpc_id = try(
    aws_vpc.vpc["vpc"].id,
    each.value.vpc_id
  )

  dynamic "ingress" {
    for_each = each.value.ingress != null ? each.value.ingress : []
    content {
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = ingress.value.ipv6_cidr_blocks
      prefix_list_ids  = ingress.value.prefix_list_ids
      security_groups  = ingress.value.security_groups
      description      = ingress.value.description
    }
  }

  dynamic "egress" {
    for_each = each.value.egress != null ? each.value.egress : []
    content {
      from_port        = egress.value.from_port
      to_port          = egress.value.to_port
      protocol         = egress.value.protocol
      cidr_blocks      = egress.value.cidr_blocks
      ipv6_cidr_blocks = egress.value.ipv6_cidr_blocks
      prefix_list_ids  = egress.value.prefix_list_ids
      security_groups  = egress.value.security_groups
      description      = egress.value.description
    }
  }
  revoke_rules_on_delete = each.value.revoke_rules_on_delete
  tags = merge(
    tomap(
      {
        "Name" = upper(
          format(
            "sg-%s",
            coalesce(
              try(each.value.name, null),
              lookup(var.vpc_config.global.tags, "stack", ""),
              "terraform-created"
            )
          )
        )
      }
    ),
    each.value.tags
  )
}

