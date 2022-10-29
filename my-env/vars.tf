variable "environment_name" {
  type    = string
  default = "my-env"

  description = "Environment name"
}

variable "region" {
  type    = string
  default = "eu-west-1"

  description = "AWS region"
}

variable "aws_cred_paths" {
  type    = list(string)
  default = ["~/.aws/credentials"]

  description = "List of paths to the shared credentials file"
}

variable "aws_profile" {
  type    = string
  default = "default"

  description = "AWS profile name"
}

variable "aws_account_ids" {
  type = list(string)

  description = "List of allowed AWS account IDs "
}

variable "user_data_file_path" {
  type        = string
  default     = "../scripts/bootstrap.sh"
  description = "File path of the user data script for the web server instances"
}

variable "is_ssm_enabled" {
  type        = bool
  default     = false
  description = "If enabled, IAM resources will be deployed to enable SSM functionality"
}