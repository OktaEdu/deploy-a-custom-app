#!/bin/bash

set -ex

echo "Add an enrollment token"
sudo mkdir -p /var/lib/sftd
echo "${enrollment_token}" | sudo tee /var/lib/sftd/enrollment.token

echo "Add a basic sftd configuration"
sudo mkdir -p /etc/sft/
sftcfg=$(cat <<EOF
---
# CanonicalName: Specifies the name clients should use/see when connecting to this host.
CanonicalName:            "ubuntu-alone"
EOF
)

echo -e "$sftcfg" | sudo tee /etc/sft/sftd.yaml

export DEBIAN_FRONTEND=noninteractive

echo "Retrieve information about new packages"
sudo apt-get update

sudo apt-get install -y curl

echo "Add the ScaleFT testing apt repo to your /etc/apt/sources.list system config file"
echo "deb http://pkg.scaleft.com/deb/ linux main" | sudo tee -a /etc/apt/sources.list

echo "Trust the repository signing key"
curl -C - https://dist.scaleft.com/pki/scaleft_deb_key.asc | sudo apt-key add -

echo "Retrieve information about new packages"
sudo apt-get update

echo "Install sftd"
sudo apt-get install scaleft-server-tools=${sftd_version}

echo "Configuring Vue SPA Sample App"
sudo wget https://github.com/dsilvest/okta-samples-js-vue-hosted-login/archive/refs/heads/main.zip
apt install -y unzip
sudo unzip main.zip
sudo bash okta-samples-js-vue-hosted-login-main/bare_metal_install.sh ${org_url} ${clientid} ${github_repo}
