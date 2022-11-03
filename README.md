# tf-challenge

Terrafrom challenge

## Provisioning

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
