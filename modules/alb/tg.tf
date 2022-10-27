resource "aws_lb_target_group" "web_servers" {
  name     = "web-servers"
  port     = var.tg_web_servers_port
  protocol = var.tg_web_servers_protocol
  vpc_id   = var.vpc_id

  health_check {
    port     = var.tg_web_servers_port
    protocol = var.tg_web_servers_protocol
  }

  tags = {
    Name        = "web-servers"
    Description = "Target Group of the web servers"
  }
}
