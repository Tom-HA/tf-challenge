# tf-challenge

Terrafrom challenge

## Challenge
Provision an environment in AWS containing a _"Hello World"_ web application running on EC2 that is reachable via ALB.  
The Terraform resources should be implemented with modules, and each resource should contain tags (see the [example below](#example-tags)).  
When the provisioning is complete, you should be able to access the web application.

### Required Terraform modules

- VPC (Including network resources)
- EC2 (Including the _"Hello World"_ web application)
- Security Groups
- ALB

### Example Tags

```hcl
Name          = "web-server"
Description   = "EC2 instance for hosting the web server"
Environment   = "my-env"
Department    = "DevOps"
Owner         = "Tom H."
ProvisionedBy = "Terraform"
Temp          = "True"
```

## Solution documentation

### Provisioning

You can provision an environment using the `bootstrap.sh` script.  
When executed, you will be asked to enter the following information:

- An environment folder name

- AWS region

- List of AWS credential paths

- AWS profile

- List of allowed AWS account IDs

Default values are displayed between `[]`.  
For example, the default value for AWS profile is `default`.

### Note

Make sure you are providing a list of strings where needed.  
Example for AWS account IDs __list__: ["123456789012"]
