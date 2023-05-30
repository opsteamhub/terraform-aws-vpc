module "vpc" {
  source = "../.."
  # source = "git@github.com:opsteamhub/terraform-aws-vpc.git"

  vpc_config = {
    vpc = {
      cidr_block = "172.24.0.0/16"
    }
    global = {
      az = {
        exclude_zone_ids = ["use1-az5"]
      }
      tags = {
        stack              = "dev-opsteam"
        env                = "development"
        "opsteam:id"       = "0001"
        "opsteam:clientid" = "0001"
        "opsteam:env"      = "development"
      }
    }
    subnet_layers = [
      {
        name         = "batatinha123"
        netlength    = 8
        az_widerange = 2
      }
    ]
    security_groups = [
      {
        name        = "test_abc"
        description = "Security group allowing HTTP, HTTPS, SSH, and ICMP traffic from the internet"
        ingress = [
          {
            description = "Allow incoming HTTPS traffic"
            from_port   = 443
            to_port     = 443
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          },
          {
            description = "Allow incoming HTTP traffic"
            from_port   = 80
            to_port     = 80
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          },
          {
            description = "Allow incoming SSH traffic"
            from_port   = 22
            to_port     = 22
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
          },
          {
            description = "Allow incoming ICMP traffic (ping)"
            from_port   = -1
            to_port     = -1
            protocol    = "icmp"
            cidr_blocks = ["0.0.0.0/0"]
          }
        ]

        egress = [{
          description      = "Allow all outbound traffic for WebDMZ instances"
          from_port        = 0
          to_port          = 0
          protocol         = "-1"
          cidr_blocks      = ["0.0.0.0/0"]
          ipv6_cidr_blocks = ["::/0"]
          }
        ]

        tags = {
          Name = "WebDMZ"
        }
      }

    ]

  }
}

output "vpc_ids" {
  description = "The IDs of the VPCs created by the module"
  value       = module.vpc.vpc_ids
}
# Output sample
# vpc_ids = {
#   "vpc" = "vpc-0e77dcde8e9256947"
# }

output "sg_ids" {
  description = "The IDs of the SG created by the module"
  value       = module.vpc.sg_ids
}
# Output sample
# sg_ids = {
#   "test_abc" = "sg-0366c296aa6b72863"
# }

