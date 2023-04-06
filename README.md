# Deploy a custom SPA app with Terraform

## Description
Create and deploy your custom app in less time with fewer errors using sample code and Terraform automation provided by Okta. In 90 minutes or less, you’ll learn how to do user mappings and assignments, and deploy your app into production. Easily tweak what you learn for your other apps. Developers, DevOps, and DevSecOps will benefit from this lab that showcases a typical CIAM use case.
## Terraform Configs
This repo includes the following Terraform configurations.
1. Use the Okta Terraform Provider to configure your SPA app in your Okta Org.
2. Create a new ASA project, assign server access, and create an enrollment token with the Okta ASA Terraform Provider.
3. Leverage an AWS ASA Starter Kit terraform config to create an Ubuntu application server and deploy your application.

The repo also includes several scripts to copy output data between the configurations.
# Prerequisites and Lab Environment Setup
This section covers configuring the environment that is required to complete this [Okta Developer Day](https://www.okta.com/developerday/) lab.

Please allow up to an hour to complete the setup tasks.
## Setup Video
In addition to the following, you can view this [environment setup video](https://www.youtube.com/watch?v=zhVWF4cKgW0).
## Prerequisites
- [Developer](https://developer.okta.com/signup/) or Sandbox org
- [ASA Team](https://app.scaleft.com/p/signupV2) with provisioning enabled
- [ASA Client](https://help.okta.com/asa/en-us/Content/Topics/Adv_Server_Access/docs/sft.htm)
- [Terraform](https://www.terraform.io/downloads.html)
- [Git command-line client](https://git-scm.com/downloads)
- Bash (Linux, MacOS or Git Bash)
- [AWS account](https://aws.amazon.com/free) (non-production)
- [Node.js](https://nodejs.org/en/download/) (optional)


## Setup Tasks
After you have all the prerequisites, you must complete the setup to start this Lab.

Follow the setup tasks in the [0_setup directory](https://github.com/OktaEdu/deploy-a-custom-app/tree/main/0_setup#readme) of this repo.

### Lab Guide Overview

There are 3 ways to complete the labs.
1. Follow along in this [video](https://www.youtube.com/watch?v=U9Q0LzAdTN4).
2. Download the [slides](https://github.com/OktaEdu/deploy-a-custom-app/blob/main/Developer%20Day%20-%20Terraform%20Lab.pdf) from this repo.
3. Follow the steps listed here in this README.

### Lab Guide Steps
1. **Clone** this repo to a machine where you have Terraform installed.

   `git clone https://github.com/OktaEdu/deploy-a-custom-app.git`

2. Edit the **terraform.tfvars** for the [Okta Org config](https://github.com/OktaEdu/deploy-a-custom-app/tree/main/1_org_spa_app).

   `terraform init`
   
   `terraform apply`

3. You now have the following in your org:
  * *My SPA App Test Users* group
  * *spa.user1* user
  * My Vue SPA OAuth app
  * The user is assigned to the group, which is assigned to the app

4. Run the `2_copy_clientid.sh` script to update the app server config with the OAuth client id and secret from your Org.
5. Follow the [instructions](https://github.com/OktaEdu/deploy-a-custom-app/tree/main/3_asa_project#readme) to run the ASA Terraform config.
6. You now have a new ASA project, `My_Spa_App` , with an enrollment token.
7. Run the `4_copy_enrollment_token.sh` script to copy the ASA enrollment token to the app server config.
8. Update the following lines in the `terraform.tfvars` file in the **5_app_server** directory.
  * access_key = "yourAWSaccesskey"
  * secret_key = "yourAWSsecretkey"
  * org_url = "https://yoursandboxorg.oktapreview.com"
9. Run the **5_app_server** terraform config.
10. Note the public IP address that your app server is assigned by AWS.
10. After your app server is deployed it will take a few minutes to configure the web server and the Vue application.
11. Before you login to the app, run the `6_update_spa_app.sh` script to update the app redirect URL in your Okta Org.
12. Access the app at https://*public_ip_address*/ and login
