#!/usr/bin/env bash

main() {
  handle_variables
  cd_to_env_folder
  terraform_init
  terraform_plan
  terraform_apply
  print_output
}

check_terraform() {
  if ! command -v terraform; then
    echo "Could not detect terraform. Please make sure terraform is installed"
    exit 1
  fi
}

handle_variables() {
  read -p "Please enter environment folder name [my-env]: " environment_name
  if [[ -z ${environment_name} ]]; then environment_name=my-env; fi

  read -p "Please enter a list of AWS credential paths [~/.aws/credentials]: " aws_cred_paths
  if [[ -n ${aws_cred_paths} ]]; then export TF_VAR_aws_cred_paths=${aws_cred_paths}; fi

  read -p "Please enter AWS profile [default]: " aws_profile
  if [[ -n ${aws_profile} ]]; then export TF_VAR_aws_profile=${aws_profile}; fi

  until [[ -n ${aws_account_ids} ]]; do read -p "Please enter a list of allowed AWS account IDs: " aws_account_ids; done
  if [[ -n ${aws_account_ids} ]]; then export TF_VAR_aws_account_ids=${aws_account_ids}; fi
  
}

cd_to_env_folder() {
  if ! cd ${environment_name}; then
    echo "Could not change directory to: ${environment_name}"
    exit 1
  fi
}

terraform_init() {
  if ! terraform init; then
    echo "Failed to initialize terraform"
    exit 1
  fi
}

terraform_plan() {
  if ! terraform plan -out terraform.out; then
    echo "Failed to create a terraform plan"
    exit 1
  fi
}

terraform_apply() {
  read -p "Would you like to apply the changes [y|n]: " answer
  until [[ ${answer} =~ ^[y|Y]$ ]] || [[ ${answer} =~ ^[n|N]$ ]]; do
    read -p "Would you like to apply the changes [y|n]: " answer
  done

  if [[ ${answer} =~ ^[n|N]$ ]]; then
    echo "Aborting"
    exit 0
  fi

  if ! terraform apply "terraform.out"; then
    echo "Failed to apply terraform plan"
    exit 1
  fi
}

print_output() {
  echo "Landing page URL:"
  terraform output lb_dns_name
}

main