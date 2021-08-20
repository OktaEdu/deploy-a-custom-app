# Deploy a custom app with Terraform: ASA Project Configuration
This Terraform configuration provides an example of creating an ASA project to enroll a server
## What this configuration does
- Creates a new project
- Assigns a provisioned group to the project
- Creates an enrollment token
## Using this configuration
To use this configuration, edit the `../scripts/set_asa_tf_vars.sh` file and enter the information for your ASA team
- Team name
- Service Account Key
- Service Account Secret

The service account for the API key needs to have the team admin role (i.e. add to the Owners group)

After editing `set_asa_tf_vars.sh`, source the file
```bash
. ../scripts/set_asa_tf_vars.sh
```
## Optional: Using terraform.tfvars for this configuration
If you would rather use a `terraform.tfvars` file instead of environment variables, do the following
1. Create a `vars.tf file` as follows:
```
variable "oktaasa_key" {}
variable "oktaasa_secret" {}
variable "oktaasa_team" {}
```
2. Replace the `provider.tf` file with:
```
terraform {
  required_providers {
    oktaasa = {
      source = "oktadeveloper/oktaasa"
      version = "~> 1.0"
    }
  }
}

provider "oktaasa" {
  oktaasa_key    = var.oktaasa_key
  oktaasa_secret = var.oktaasa_secret
  oktaasa_team   = var.oktaasa_team
}
```
3. Create a `terraform.tfvars` file
```
oktaasa_key        = "yourasaserviceaccountkey"
oktaasa_secret = "yourasaserviceaccountsecret"
oktaasa_team       = "yourasateam"
```
