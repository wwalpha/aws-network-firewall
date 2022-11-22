# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}

module "networking" {
  depends_on = [random_id.this]
  source     = "./networking"
  suffix     = local.suffix
}

module "security" {
  source = "./security"
  suffix = local.suffix
}

module "app" {
  depends_on           = [module.networking]
  source               = "./app"
  vpc_id               = module.networking.vpc_id
  public_subnets       = module.networking.public_subnets[*].id
  private_subnets      = module.networking.private_subnets[*].id
  ec2_ssm_role_profile = module.security.ec2_ssm_role_profile.name
}
