module "vpc" {
  source = "../modules/vpc"

  environment_name = var.environment_name
  region           = var.region
}

module "sg" {
  source = "../modules/sg"

  vpc_id = module.vpc.vpc_id
}

module "alb" {
  source = "../modules/alb"
}

module "ec2" {
  source = "../modules/ec2"
}
