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

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnet_ids
  alb_sg_ids = [module.sg.sg_id_load_balancers]
}

module "ec2" {
  source = "../modules/ec2"
}
