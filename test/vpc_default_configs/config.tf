terraform {

  backend "s3" {
    bucket = "opsteam-terraform-modules-tfstate-dev"
    key    = "terraform/OpsTeamModules/vpc.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
  # Common tags to be used in all new resources
  default_tags {
    tags = {
      environment = "Dev"
      owner       = "TFProviders"
      project     = "VPC"
    }
  }
}
