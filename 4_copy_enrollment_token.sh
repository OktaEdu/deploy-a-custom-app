#!/bin/bash
cd 3_asa_project
token=`terraform output | grep '".*",' | awk -F '"' '{print $2}'`
echo "Enrollment Token: $token"
cd ..
cd 5_app_server
cp -p terraform.tfvars terraform.tfvars.bak
cat terraform.tfvars.bak | sed -e "s/^enrollment_token.*=.*$/enrollment_token = \"${token}\"/" > terraform.tfvars
echo "Updated 5_app_server/terraform.tfvars"
cd ..
