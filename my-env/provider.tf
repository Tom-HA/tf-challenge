terraform {
  required_providers {
    aws = {
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region                   = var.region
  shared_credentials_files = var.aws_cred_paths
  profile                  = var.aws_profile
  allowed_account_ids      = var.aws_account_ids

  default_tags {
    tags = {
      Environment   = var.environment_name
      Department    = "DevOps"
      Owner         = "Tom H."
      ProvisionedBy = "Terraform"
      Temp          = "True"
    }
  }
}
