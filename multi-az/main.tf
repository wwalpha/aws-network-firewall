# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {}

terraform {
  cloud {
    organization = "wwalpha"

    workspaces {
      name = "aws-network-firewall-demo"
    }
  }
}

module "networking" {
  source = "./networking"
}

module "app" {
  source = "./app"

  vpc_id          = module.networking.vpc_id
  public_subnets  = module.networking.public_subnets
  private_subnets = module.networking.private_subnets
}
