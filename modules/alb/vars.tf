variable "vpc_id" {
  type        = string
  description = "AWS VPC ID"
}

variable "alb_sg_ids" {
  type        = list(string)
  description = "Security Group IDs list for the ALB"
}
variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs list for the ALB"
}

variable "tg_web_servers_port" {
  type    = number
  default = 80

  description = "The port the web servers receive traffic"
}
variable "tg_web_servers_protocol" {
  type    = string
  default = "HTTP"

  description = "The Protocol to use for routing traffic to the web servers"
}

variable "web_servers_listeners" {
  type = list(object({
    port     = number,
    protocol = string
  }))

  default = [
    {
      port     = 80,
      protocol = "HTTP"
    }
  ]

  description = "List of objects to set multiple listeners for the web servers"

}

variable "enable_deletion_protection" {
  type    = bool
  default = false

  description = "Enable of disable deletion protection for the load balancer"
}