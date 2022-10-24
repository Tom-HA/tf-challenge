module "alb" {
  source = "../modules/alb"
}

module "ec2" {
  source = "../modules/ec2"
}

module "sg" {
  source = "../modules/sg"
}

module "vpc" {
  source = "../modules/vpc"
}
