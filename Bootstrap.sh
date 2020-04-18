#!/bin/bash
yum update -y aws-cfn-bootstrap
yum update -y
yum install httpd24 php70 php70-mysqlnd -y
cd /var/www/html
aws s3 cp --recursive s3://YOUR-BUCKET-CODE-NAME . 
chmod -R 755 wp-content
chown -R apache:apache wp-content
chown -R apache /var/www
chgrp -R apache /var/www
sed -i 's/localhost/'DATABASE-ENDPOINT'/g' wp-config.php
sed -i 's/database_name_here/DATABASE-NAME/g' wp-config.php
sed -i 's/username_here/DATABASE-USERNAME/g' wp-config.php
sed -i 's/password_here/DATABASE-PASSWORD/g' wp-config.php
sed -i -e "20 i\define('WP_HOME','https://www.YOURSITE.com');" wp-config.php
sed -i -e "21 i\define('WP_SITEURL','https://www.YOURSITE.com');" wp-config.php
cd /etc
sed -i -e '$  a\*/1 * * * * root aws s3 cp --recursive /var/www/html/wp-content/uploads s3://YOUR-BUCKET-NAME/wp-content/uploads' crontab
sed -i -e '$  a\0 3 * * * root rm /var/www/html/wp-content/uploads/* -rf' crontab
chkconfig httpd on
service httpd start