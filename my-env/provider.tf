provider "aws" {
  region                   = var.region
  shared_credentials_files = var.aws_cred_paths
  profile                  = var.aws_profile
  allowed_account_ids      = var.aws_account_ids
}
