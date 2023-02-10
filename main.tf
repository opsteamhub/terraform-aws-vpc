locals {
  common_tags = try(
    merge(
      var.vpc_config["global"]["tags"],
      var.vpc_config["vpc"]["tags"]
    ),
    null
  )
}

data "aws_caller_identity" "session" {}

data "aws_region" "session" {}