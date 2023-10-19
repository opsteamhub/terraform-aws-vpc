locals {
  common_tags = try(var.vpc_config["global"]["tags"], null) != null ? var.vpc_config["global"]["tags"] : {}
}

data "aws_caller_identity" "session" {}

data "aws_region" "session" {}
