# Deploy a custom app with Terraform: Okta Org Configuration
This Terraform configuration provides a functional example of creating a new application for the Okta [Vue Sample Application](https://github.com/okta/samples-js-vue).
## What this configuration does
- Add two new sample users
- Create a group and add the users to the group
- Add a new OAuth application
- Assign the group to the application
## Using this configuration
To use this configuration, edit the terraform.tfvars file and enter the information for your org
- Org name
- Base url (e.g. oktapreview.com for sandbox orgs or okta.com for developer orgs)
- API token

The API token needs to have at least org and app administrator access to your org.
