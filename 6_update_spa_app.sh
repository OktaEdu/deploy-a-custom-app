#!/bin/bash
prefix='["https://'
suffix='/"]'
cd 5_app_server
hostip=`terraform output | awk -F ' ' '{print $3}' | tr -d \"`
echo "Host IP: $hostip"
cd ..
cd 1_org_spa_app
cp -p app.tf app.tf.bak
cat app.tf.bak | sed -r "s/(.*https...).*(.login.callback..$)/\1${hostip}\2/" | sed -r "s/(.*post_logout_redirect_uris.*=)(.*https...).*(..$)/\1\2${hostip}\3/" > app.tf
grep $hostip app.tf
echo "Updated 1_org_spa_app/app.tf"
cd ..
