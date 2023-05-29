module "vpc" {
  source = "../.."
  # source = "git@github.com:opsteamhub/terraform-aws-vpc.git"

  vpc_config = {
    vpc = {
      cidr_block = "172.24.0.0/16" # CIDR block for the VPC
    }
    global = {
      az = {
        exclude_zone_ids = ["use1-az5"] # Exclude specific availability zones
      }
      tags = {
        stack              = "dev-opsteam" # Stack tag
        env                = "development" # Environment tag
        "opsteam:id"       = "0001"        # OpsTeam ID tag
        "opsteam:clientid" = "0001"        # OpsTeam Client ID tag
        "opsteam:env"      = "development" # OpsTeam Environment tag
      }
    }
    subnet_layers = [
      {
        name         = "batatinha123" # Name of the subnet layer
        netlength    = 8              # Netlength of the subnet layer
        az_widerange = 2              # Availability zone wide range
      }
    ]

    transit_gateway = {
      "TG01" = {
        description                     = "Transit gateway  1" # Description of the transit gateway
        amazon_side_asn                 = "64512"              # ASN for Amazon side of BGP session
        auto_accept_shared_attachments  = "disable"            # Do not auto-accept shared attachments
        default_route_table_association = "enable"             # Automatically associate with default route table
        default_route_table_propagation = "enable"             # Automatically propagate routes to default route table
        dns_support                     = "enable"             # Enable DNS support
        multicast_support               = "disable"            # Disable multicast support
        vpn_ecmp_support                = "enable"             # Enable VPN ECMP support
        transit_gateway_cidr_blocks     = ["172.24.0.0/16"]    # CIDR blocks for the transit gateway
        tags = {
          Name = "My TG" # Name of transit gateway
          tag1 = "abc"   # tag for the transit gateway
          tag2 = "def"   # tag for the transit gateway
        }
      },
      "TG2" = {
        description = "Transit gateway 2" # Description of the transit gateway
        tags = {
          tag1 = "abc" # tag for the transit gateway
        }
      },
    }
  }
}
