#!/bin/bash
 
sudo apt update
sudo apt install php-xml php-fpm libapache2-mod-php php-mysql php-gd php-imap php-mysql php-curl php-mbstring -y
sudo a2enmod proxy_fcgi setenvif
sudo systemctl restart apache2
sudo a2enconf php7.4-fpm
sudo systemctl reload apache2
sudo systemctl restart apache2.service
sudo service php7.4-fpm restart
sudo systemctl restart mysql
  
cd /tmp
git clone https://github.com/webpwnized/mutillidae
if [ $? -ne '0' ]; then
    exit 1
fi
  
if [ -d "/var/www/html/mutillidae.backup" ]; then
    sudo rm -rf /var/www/html/mutillidae.backup
fi
  
if [ -d "/var/www/html/mutillidae" ]; then
    sudo mv /var/www/html/mutillidae /var/www/html/mutillidae.backup
fi
  
sudo mkdir /var/www/html/mutillidae
sudo mv mutillidae*/* /var/www/html/mutillidae/
sudo sed -i "s/'DB_PASSWORD', 'mutillidae'/'DB_PASSWORD', ''/" /var/www/html/mutillidae/includes/database-config.inc
   
sudo chown -R www-data:www-data /var/www/html/mutillidae/
   
sudo rm -rf mutillidae*
   
cd
