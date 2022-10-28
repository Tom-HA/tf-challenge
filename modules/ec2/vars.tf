variable "instance_type" {
  type        = string
  default     = "t3.micro"
  description = "Instance type for the web server instances"
}
variable "volume_size" {
  type        = number
  default     = 20
  description = "Volume size for the web server instances"
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Desired number of web server instances"
}
variable "max_size" {
  type        = number
  default     = 1
  description = "Maximum number of web server instances"
}
variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of web server instances"
}

variable "is_custom_user_data" {
  type        = bool
  default     = true
  description = "Enable or disable user data for the web server instances"
}

variable "user_data_file_path" {
  type        = string
  description = "File path of the user data script for the web server instances"
}

variable "web_servers_sg_ids" {
  type        = list(string)
  description = "List of Security Group IDs for the web servers"
}

variable "web_servers_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs for the web servers"
}

variable "tg_arns" {
  type        = list(string)
  description = "List of Target Group ARNs to attach the instances"
}

variable "is_ssm_enabled" {
  type        = bool
  default     = true
  description = "If enabled, resources will be deployed to enable SSM functionality"
}