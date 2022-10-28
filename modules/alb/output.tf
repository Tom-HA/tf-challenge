output "tg_arn_web_servers" {
  description = "Target Group ARN of the web servers"
  value       = aws_lb_target_group.web_servers.arn
}
output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.application.dns_name
}