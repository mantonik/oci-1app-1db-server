#!/bin/bash

if [ "$EUID" -ne 0 ]
  then
    echo ""
    echo "Please run as root"
    echo ""
    exit
fi

#Enter Domain Name 
echo "Enter domain name: "
read DOMAINNAME

ROOTDIRPATH="/data/www/domain/${DOMAINNAME}/htdocs"


echo "Configure ngixn for domain: "${DOMAINNAME}
echo "ROOT directory : "${ROOTDIRPATH}

#Update nginx configuration 
sed "s/DOMAIN-NAME/${DOMAINNAME}/g" < /etc/nginx/conf.d/0.template.wp.conf.txt > /etc/nginx/conf.d/${DOMAINNAME}.conf
sed "s/ROOTDIRPATH/${ROOTDIRPATH}/g" -i /etc/nginx/conf.d/${DOMAINNAME}.conf

echo "Setup a nginx configuration for domain"
#prepare file system for new domain 

mkdir -p ${ROOTDIRPATH}

#Create folder structure for certbot

mkdir -p ${ROOTDIRPATH}/htdocs/.well-known
echo $HOSTNAME > ${ROOTDIRPATH}/htdocs/.well-known/index.html

# Create nginx configuration for domain
chown -R nginx:nginx /data/www/
service nginx restart

#setup wordpress
echo " Download latest WP "
cd /root/install
wget https://wordpress.org/latest.tar.gz
tar xvf latest.tar.gz
cd /root/install/wordpress

echo "Copy to domain folder"
cp -r * ${ROOTDIRPATH}/htdocs
ls -l ${ROOTDIRPATH}/htdocs
echo "${DOMAINNAME} is up" > ${ROOTDIRPATH}/htdocs/test.html

chown -R nginx:nginx /data/www/
find /data/www -type d -exec chmod 750 {} \;
find /data/www -type f -exec chmod 640 {} \;

exit 

#dmcloudarchitect.com
#support
# Ujh7834%2#wdx)9plkjHns$


