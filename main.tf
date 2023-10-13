locals {
  common_tags = var.vpc_config["global"]["tags"]
}

data "aws_caller_identity" "session" {}

data "aws_region" "session" {}