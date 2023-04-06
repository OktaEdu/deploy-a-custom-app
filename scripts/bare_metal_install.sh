#!/bin/bash
#
#Parameters
issuer="$1/oauth2/default"
clientid="$2"
if [ -z "$3" ] ; then
   github="git clone https://github.com/okta/samples-js-vue"
else
   github="git clone $3"
fi

#
#get the local IP address (for if app is only accessed from local VPC)
#ipaddr=`ifconfig eth0 | grep "inet addr" | awk '{print $2}' | awk 'BEGIN{FS=":"};{print $2}'`
#get the public IP address (for configuring public access to app)
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
ipaddr=`curl -H "X-aws-ec2-metadata-token: $TOKEN" -v http://169.254.169.254/latest/meta-data/public-ipv4`
#
#Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#
#Install Node.js
nvm install 14.4.0
#
#Install unzip
apt update
apt install -y unzip
#
#start Apache2 install and configuration
apt install -y apache2
a2enmod ssl
a2enmod rewrite
a2ensite default-ssl
cat > /var/www/html/.htaccess <<++
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^/index\.html$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.html [L]
</IfModule>
++
cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.bak
awk 'NR==166{gsub("AllowOverride None","AllowOverride All")}; {print $0}' /etc/apache2/apache2.conf.bak > /etc/apache2/apache2.conf
service apache2 restart
#
#start sample code install and configuration
`$github`
cd samples-js-vue
cd */samples-js-vue
echo "ISSUER=$issuer" > testenv
echo "CLIENT_ID=$clientid" >> testenv
cd okta-hosted-login
npm install
cp src/config.js src/config.js.bak
awk 'NR==7{gsub("http://localhost:8080","https://IPADDR")}; {print $0}' src/config.js.bak | sed -e "s/IPADDR/$ipaddr/" > src/config.js
npm run-script build
cd dist
cp -rp * /var/www/html

#done
