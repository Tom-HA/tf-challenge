resource "aws_lb" "application" {
  name               = "application"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg_ids
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  tags = {
    Name        = "application"
    Description = "Application Load Balancer for the web server"
  }
}