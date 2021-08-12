#!/bin/bash
cd 1_org_spa_app
client_id=`terraform output | grep client_id | awk -F ' ' '{print $3}' | tr -d \"`
echo "Client Id: $client_id"
cd ..
cd 5_app_server
cp -p terraform.tfvars terraform.tfvars.bak
cat terraform.tfvars.bak | sed -e "s/^clientid.*=.*$/clientid = \"${client_id}\"/" > terraform.tfvars
echo "Updated 5_app_server/terraform.tfvars"
cd ..

