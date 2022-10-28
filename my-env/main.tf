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

  user_data_file_path    = var.user_data_file_path
  web_servers_subnet_ids = module.vpc.private_subnet_ids
  web_servers_sg_ids     = [module.sg.sg_id_web_servers]
  tg_arns                = [module.alb.tg_arn_web_servers]
}
