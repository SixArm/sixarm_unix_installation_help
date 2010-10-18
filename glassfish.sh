#!/bin/sh
#
# How to download and install Glassfish version 3,
# with typical user "glassfish", group "admin",
# files in "/opt/glassfishv3", and init.d script
# that we can download from sixarm.com
#
# From http://skytteren.blogspot.com/2009/05/installing-glassfish-v3-on-ubuntu.html
# Customized a bit with the downloadable init.d by joelparkerhenderson@gmail.com
##

wget http://download.java.net/glassfish/v3/promoted/latest-glassfish.zip
unzip latest-glassfish.zip
mv glassfishv3 /opt/
useradd --system glassfish -d /opt/glassfishv3
chown -R glassfish /opt/glassfishv3
chgrp -R admin /opt/glassfishv3
cd /opt/glassfishv3
chmod -R +x bin/
chmod -R +x glassfish/bin/ 
sudo -u glassfish bin/asadmin start-domain domain1 
wget http://sixarm.com/etc/init.d/glassfish -O /etc/init.d/glassfish
chmod a+x /etc/init.d/glassfish 
update-rc.d glassfish defaults
