
#
# Deploy VPC
#
resource "aws_vpc" "vpc" {
  for_each = var.vpc_config["vpc"]["create"] ? tomap( { "vpc" = var.vpc_config["vpc"]} ) : {}
  cidr_block                           = each.value["cidr_block"]
  enable_dns_hostnames                 = each.value["enable_dns_hostnames"]
  enable_dns_support                   = each.value["enable_dns_support"]
  enable_network_address_usage_metrics = each.value["enable_network_address_usage_metrics"]
  instance_tenancy                     = each.value["instance_tenancy"]
  ipv4_ipam_pool_id                    = each.value["ipv4_ipam_pool_id"]
  ipv4_netmask_length                  = each.value["ipv4_ipam_pool_id"] != null ? var.vpc_config["vpc"]["ipv4_netmask_length"] : null
  tags                                 = merge(   
    local.common_tags,
    {
      Name = upper(
        try(
          local.common_tags["name"],
          local.common_tags["stack"],
          "null"
        )
      )
    }
  )
}



resource "aws_default_network_acl" "default_nacl_quarentine_subnets" {
  for_each = var.vpc_config["vpc"]["create"] ? tomap( { "vpc" = aws_vpc.vpc["vpc"]} ) : {}
  
  default_network_acl_id = each.value["default_network_acl_id"]
  
  ingress {
    protocol   = -1
    rule_no    = 1
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }

  egress {
    protocol   = -1
    rule_no    = 1
    action     = "deny"
    cidr_block = "0.0.0.0/0"
    from_port  = 0
    to_port    = 0
  }
  
  tags = merge(   
    {
      "Name" = upper(format("nacl-quarentine-%s", each.value["tags"]["stack"]))
      "opsteam:ParentObject"     = each.value["id"]
      "opsteam:ParentObjectArn"  = each.value["arn"]
      "opsteam:ParentObjectType" = "VPC"
    },
    local.common_tags
  )

  lifecycle {
    ignore_changes = [subnet_ids]
  }
}

resource "aws_default_route_table" "default_routetable" {
  for_each = var.vpc_config["vpc"]["create"] ? tomap(
    {
      "vpc" = aws_vpc.vpc["vpc"]
    }
  ) : {}

  default_route_table_id = each.value["default_route_table_id"]
  tags = merge(
    {
      "Name" = upper(format("main-routetable-%s", each.value["tags"]["stack"]))
      "opsteam:ParentObject"     = each.value["id"]
      "opsteam:ParentObjectArn"  = each.value["arn"]
      "opsteam:ParentObjectType" = "VPC"
    },
    local.common_tags
  ) 
}

resource "aws_security_group" "sg_allowlist" {
  for_each = var.vpc_config["vpc"]["create"] ? tomap(
    {
      "vpc" = aws_vpc.vpc["vpc"]
    }
  ) : {}
  
  name        = upper(format("%s-allowlist", each.value["id"]))
  description = format("AllowList SG - %s", each.value["id"])
  vpc_id      = each.value["id"]

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    {
      "Name" = upper(format("allowlist-%s", each.value["tags"]["stack"]))
      "opsteam:ParentObject" = each.value["id"]
      "opsteam:ParentObjectArn" = each.value["arn"]
      "opsteam:ParentObjectType" = "VPC"
    },
    local.common_tags
  ) 

}

resource "aws_default_security_group" "default_sg_denylist" {
  
  for_each = var.vpc_config["vpc"]["create"] ? tomap(
    {
      "vpc" = aws_vpc.vpc["vpc"]
    }
  ) : {}

  vpc_id = each.value["id"]
  
  tags = merge(
    {
      "Name" = upper(format("denylist-%s", each.value["tags"]["stack"]))
      "opsteam:ParentObject" = each.value["id"]
      "opsteam:ParentObjectArn" = each.value["arn"]
      "opsteam:ParentObjectType" = "VPC"
    },
    local.common_tags
  ) 
}



resource "aws_ec2_managed_prefix_list" "managed_prefixlist_internet" {
  
  for_each = var.vpc_config["vpc"]["create"] ? tomap(
    {
      "vpc" = aws_vpc.vpc["vpc"]
    }
  ) : {}
  
  name           = upper(format("prefixlist-internet-%s", each.value["tags"]["stack"]))
  address_family = "IPv4"
  max_entries    = 1

  entry {
    cidr        = "0.0.0.0/0"
    description = "Internet"
  }

  tags = merge(
    {
      "Name" = upper(format("prefixlist-internet-%s", each.value["tags"]["stack"]))
      "opsteam:ParentObject" = each.value["id"]
      "opsteam:ParentObjectArn" = each.value["arn"]
      "opsteam:ParentObjectType" = "VPC"
    },
    local.common_tags
  ) 

}