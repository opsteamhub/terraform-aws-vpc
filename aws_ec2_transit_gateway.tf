#
# Create transit gateway for the current VPC
#
resource "aws_ec2_transit_gateway" "transit_gateway" {
  for_each = var.vpc_config.transit_gateway != null ? { for tg in [var.vpc_config.transit_gateway] : tg.description => tg } : {}

  amazon_side_asn                 = try(each.value.amazon_side_asn, null)
  auto_accept_shared_attachments  = try(each.value.auto_accept_shared_attachments, "disable")
  default_route_table_association = try(each.value.default_route_table_association, "enable")
  default_route_table_propagation = try(each.value.default_route_table_propagation, "enable")
  description                     = each.value.description
  dns_support                     = try(each.value.dns_support, "enable")
  multicast_support               = try(each.value.multicast_support, "disable")
  vpn_ecmp_support                = try(each.value.vpn_ecmp_support, "enable")
  transit_gateway_cidr_blocks     = try(each.value.transit_gateway_cidr_blocks, null)

  tags = merge(
    tomap(
      {
        "Name" = upper(
          format(
            "tgw-%s",
            coalesce(
              lookup(each.value.tags, "Name", ""),             # First, try to get the "Name" tag value
              lookup(var.vpc_config.global.tags, "stack", ""), # If the "Name" tag doesn't exist, try to get the "stack" tag value
              "terraform-created"                              # If neither of them exists, provide a default value
            )
          )
        )
      }
    ),
    each.value.tags # Merge with the original tags
  )
}
