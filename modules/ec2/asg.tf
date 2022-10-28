resource "aws_autoscaling_group" "web_servers" {
  name                = "web_servers"
  desired_capacity    = var.desired_capacity
  max_size            = var.max_size
  min_size            = var.min_size
  vpc_zone_identifier = var.web_servers_subnet_ids
  target_group_arns   = var.tg_arns
  health_check_type   = "ELB"

  launch_template {
    id      = aws_launch_template.web_servers.id
    version = "$Default"
  }

  # tags is deprecated
  tag {
    key                 = "Name"
    value               = "web_servers"
    propagate_at_launch = false
  }
  tag {
    key                 = "Description"
    value               = "Autoscaling group for the web servers"
    propagate_at_launch = false
  }
}