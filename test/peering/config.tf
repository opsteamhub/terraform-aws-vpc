terraform {
  backend "s3" {
    bucket = "opsteam-terraform-modules-tfstate-dev"
    key    = "terraform/Module-VPC.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}