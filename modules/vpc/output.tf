output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for k, v in var.subnets : aws_subnet.this[k].id if v.public]
}
output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for k, v in var.subnets : aws_subnet.this[k].id if !v.public]
}