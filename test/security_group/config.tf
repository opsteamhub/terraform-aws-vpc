terraform {
  backend "s3" {
    bucket = "opsteam-terraform-modules-tfstate-dev"
    key    = "terraform/OpsTeamModules/vpc.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}