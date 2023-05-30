output "vpc_ids" {
  description = "The IDs of the VPCs"
  value       = { for k, v in aws_vpc.vpc : k => try(v.id, null) }
}


output "sg_ids" {
  value = { for k in aws_security_group.security_group : k.name => k.id }
}
