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
  if ! plan=$(terraform plan -out terraform.out |tee /dev/tty); then
    echo "Failed to create a terraform plan"
    exit 1
  fi

  if grep -q "No changes. Your infrastructure matches the configuration." <<< ${plan}; then
    no_changes=true
  fi
}

terraform_apply() {
  if $no_changes; then
    return 0
  fi

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
  url="$(terraform output -raw lb_dns_name)"
  if grep -q "No outputs found" <<< ${url}; then
    echo "Could not get Landing page URL"
    exit 1
  fi
  
  counter=0
  until curl -Lsf $url &> /dev/null; do
    if [[ ${counter} -ge 60 ]]; then
      echo "Failed to get landing page URL"
      exit 1
    fi
    sleep 5
    (( counter++ ))
  done
  printf "Landing page URL:\n%s\n" ${url}

}

main