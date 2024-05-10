#
# Create security gropus for the current VPC
#
resource "aws_security_group" "security_group" {
  for_each = var.vpc_config.security_groups != null ? {
    for sg in var.vpc_config.security_groups:
      sg.name => (
        var.vpc_config["vpc"]["vpc_id"] != null ? merge(
          tomap(
            {
              vpc_id = var.vpc_config["vpc"]["vpc_id"]
            }
          ),
          sg
        ) : sg
      )
    } : {}

  name        = each.value.name
  description = each.value.description

  vpc_id = try(
    aws_vpc.vpc["vpc"].id,
    each.value.vpc_id
  )

  revoke_rules_on_delete = each.value.revoke_rules_on_delete
  tags = merge(
    tomap(
      {
        "Name" = upper(
          format(
            "sg-%s",
            coalesce(
              try(each.value.name, null),
              try(lookup(var.vpc_config.global.tags, "stack", ""), null),
              "terraform-created"
            )
          )
        )
      }
    ),
    each.value.tags
  )
}

