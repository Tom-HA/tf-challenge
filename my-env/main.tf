module "vpc" {
  source = "../modules/vpc"

  environment_name = var.environment_name
  region           = var.region
}

module "sg" {
  source = "../modules/sg"
}

module "alb" {
  source = "../modules/alb"
}

module "ec2" {
  source = "../modules/ec2"
}
