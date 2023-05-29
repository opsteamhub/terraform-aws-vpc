# # Retrieve Subnet IDs to transit gateway vpc attachment
# #
# data "aws_subnets" "subnets-vpc-transit-gateway-attachment" {
#   for_each = zipmap(
#     flatten(
#       [
#         for x, y in coalesce(var.vpc_config["transit_gateway"], {}) :
#         format("%s--%s", try(
#           local.common_tags["name"],
#           local.common_tags["stack"],
#           "null"
#           ),
#           x
#         )
#       ]
#     )
#   )

#   filter {
#     name = "vpc-id"
#     values = [
#       try(
#         aws_vpc.vpc["vpc"].id,
#         var.vpc_config["vpc"]["vpc_id"]
#       )
#     ]
#   }

#   filter {
#     name   = each.value["subnet_filter"]["name"]
#     values = each.value["subnet_filter"]["values"]
#   }

#   dynamic "filter" {
#     for_each = each.value["az_ids"] != null ? [each.value["az_ids"]] : []
#     content {
#       name   = "availabilityZoneId"
#       values = filter.value
#     }
#   }

#   dynamic "filter" {
#     for_each = each.value["exclude_az_ids"] != null ? [each.value["exclude_az_ids"]] : []
#     content {
#       name = "availabilityZoneId"
#       values = setsubtract(
#         data.aws_availability_zones.region_azs.zone_ids,
#         filter.value
#       )
#     }
#   }

# }




# resource "aws_ec2_transit_gateway_vpc_attachment" "example" {
#   subnet_ids         = [aws_subnet.example.id]
#   transit_gateway_id = aws_ec2_transit_gateway.example.id
#   vpc_id             = aws_vpc.example.id
# }