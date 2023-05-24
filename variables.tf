variable "vpc_config" {
  description = "AWS VPC configurations"
  type = object(
    {
      dhcp_options = optional(
        object(
          {
            domain_name          = optional(string, "ec2.internal")
            domain_name_servers  = optional(set(string), ["AmazonProvidedDNS"])
            ntp_servers          = optional(set(string))
            netbios_name_servers = optional(set(string))
            netbios_node_type    = optional(string)
            tags                 = optional(map(string))
          }
        ),
        {
          domain_name         = "ec2.internal"
          domain_name_servers = ["AmazonProvidedDNS"]
        }
      )
      global = optional(
        object(
          {
            az = optional(
              object(
                {
                  exclude_zone_ids = optional(set(string))
                  state            = optional(string)
                }
              )
            )
            tags = optional(map(string))

          }
        )
      )
      igw = optional(
        object(
          {
            create = optional(bool, true)
            vpc_id = optional(string)
          }
        ),
        {
          create = true
        }
      )
      ipam = optional(
        object(
          {
            ipam_pool_id = optional(string)
          }
        )
      )
      nat_gateway = optional(
        object(
          {
            create         = optional(bool, false)
            az_widerange   = optional(string, 2)
            az_ids         = optional(set(string))
            exclude_az_ids = optional(set(string))
          }
        ),
        {
          create = false
        }
      )
      nat_instance = optional(
        object(
          {
            create         = optional(bool, false)
            az_widerange   = optional(string, 2)
            az_ids         = optional(set(string))
            exclude_az_ids = optional(set(string))
            instance_type  = optional(string, "t3.medium")
          }
        ),
        {
          create = false
        }
      )
      peering_connection = optional(
        list(
          object(
            {
              accepter = optional(
                object(
                  {
                    allow_remote_vpc_dns_resolution = optional(bool, false)
                  }
                )
              )
              auto_accept   = optional(bool, true)
              cidr_blocks   = optional(set(string))
              peer_owner_id = optional(string)
              peer_region   = optional(string)
              peer_vpc_id   = optional(string)
              requester = optional(
                object(
                  {
                    allow_remote_vpc_dns_resolution = optional(bool, false)
                  }
                )
              )
              route_tables_filter       = optional(any)
              tags                      = optional(map(string))
              vpc_id                    = optional(string)
              vpc_peering_connection_id = optional(string)
            }
          )
        )
      )
      security_groups = optional(
        list(
          object(
            {
              description = optional(string)
              egress = optional(
                list(
                  object(
                    {
                      description      = optional(string)
                      from_port        = optional(string)
                      to_port          = optional(string)
                      protocol         = optional(string)
                      cidr_blocks      = optional(set(string))
                      ipv6_cidr_blocks = optional(set(string))
                      prefix_list_ids  = optional(set(string))
                      security_groups  = optional(set(string))
                    }
                  )
                )
              )
              ingress = optional(
                list(
                  object(
                    {
                      description      = optional(string)
                      from_port        = optional(string)
                      to_port          = optional(string)
                      protocol         = optional(string)
                      cidr_blocks      = optional(set(string))
                      ipv6_cidr_blocks = optional(set(string))
                      prefix_list_ids  = optional(set(string))
                      security_groups  = optional(set(string))
                    }
                  )
                )
              )
              name_prefix            = optional(string)
              name                   = optional(string)
              revoke_rules_on_delete = optional(string)
              vpc_id                 = optional(string)
              tags                   = optional(map(string))
            }
          )
        )
      )
      subnet_layers = optional(
        list(
          object(
            {
              az_widerange                                 = optional(string, 3)
              az_ids                                       = optional(set(string))
              cidr_block                                   = optional(list(string))
              create                                       = optional(bool, true)
              enable_resource_name_dns_a_record_on_launch  = optional(bool, false)
              has_outbound_internet_access_via_natgw       = optional(bool, false)
              has_outbound_internet_access_via_natinstance = optional(bool, false)
              map_public_ip_on_launch                      = optional(bool, false)
              name                                         = optional(string)
              nat_gw_scope                                 = optional(string)
              nat_instance_scope                           = optional(string)
              netprefix                                    = optional(string)
              netlength                                    = optional(string, 0)
              netnum                                       = optional(string, 0)
              network_acl_quarentine                       = optional(bool, false) # bloqueia acesso nas NACLs, mas deixa os servicos ligados
              network_acl_quarentine_az_ids                = optional(set(string))
              network_acl_rules = optional(
                list(
                  object(
                    {
                      action          = optional(string)
                      egress          = optional(bool, false)
                      cidr_block      = optional(string)
                      from_port       = optional(string)
                      icmp_code       = optional(string)
                      icmp_type       = optional(string)
                      ipv6_cidr_block = optional(string)
                      protocol        = optional(string)
                      rule_no         = optional(string)
                      to_port         = optional(string)
                    }
                  )
                )
              )
              private_dns_hostname_type_on_launch = optional(string)
              routes = optional(
                list(
                  object(
                    {
                      az_ids                 = optional(set(string))
                      destination_cidr_block = optional(list(string))
                      target                 = optional(string)
                    }
                  )
                )
              )
              scope  = optional(string, "private")
              vpc_id = optional(string)
              tags   = optional(map(string))
            }
          )
        )
      )
      vpc = optional(
        object(
          {
            create                               = optional(bool, true)
            cidr_block                           = optional(string)
            enable_dns_hostnames                 = optional(bool, true)
            enable_dns_support                   = optional(bool, true)
            enable_network_address_usage_metrics = optional(bool, false)
            instance_tenancy                     = optional(string, "default")
            ipv4_ipam_pool_id                    = optional(string)
            ipv4_netmask_length                  = optional(string, 20)
            tags                                 = optional(map(string))
            vpc_id                               = optional(string)
          }
        )
      )
      vpc_endpoints = optional(
        map(
          object(
            {
              az_ids                               = optional(set(string))
              exclude_az_ids                       = optional(set(string))
              service_type                         = optional(string)
              auto_accept                          = optional(bool, false)
              policy                               = optional(string)
              private_dns_enabled                  = optional(string, true)
              endpoint_service_private_dns_enabled = optional(string, false)
              dns_options = optional(
                object(
                  {
                    dns_record_ip_type = optional(string)
                  }
                ),
                {
                  dns_record_ip_type = "ipv4"
                }
              )
              ip_address_type = optional(string, "ipv4")
              route_tables_filter = optional(
                object(
                  {
                    name   = optional(string)
                    values = optional(set(string))
                  }
                )
              )
              listener_ports = optional(
                object(
                  {
                    from_port       = optional(string)
                    to_port         = optional(string)
                    protocol        = optional(string)
                    security_groups = optional(set(string))
                  }
                ),
                {
                  from_port = "443"
                  to_port   = "443"
                  protocol  = "tcp"
                }
              )
              subnet_filter = optional(
                object(
                  {
                    name   = optional(string)
                    values = optional(set(string))
                  }
                ),
                {
                  name   = "tag:subnet_layer",
                  values = ["awssvc"]
                }
              )
              tags = optional(map(string))
            }
          )
        )
      )
    }
  )
} 