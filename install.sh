#!/bin/bash
#before install check DB setting in 
#	judge.conf 
#	hustoj-read-only/web/include/db_info.inc.php
#	and down here
#and run this with root

 
WEBBASE=/var/www/
APACHEUSER=www-data
DBUSER=root
DBPASS=root

#try install tools
sudo apt-get install flex g++ libmysql++-dev php5 apache2 mysql-server php5-mysql php5-gd php5-cli mono-gmcs subversion
sudo /etc/init.d/mysql start

#create user and homedir
sudo  /usr/sbin/useradd -m -u 1536 judge


#compile and install the core
cd core/
sudo sh make.sh
cd ..
#install web and db
sudo cp -R web $WEBBASE/scutoj
sudo chmod -R 771 $WEBBASE/scutoj
sudo chown -R $APACHEUSER $WEBBASE/scutoj
sudo mysql -h localhost -u$DBUSER -p$DBPASS < install/db.sql

#create work dir set default conf
sudo    mkdir /home/judge
sudo    mkdir /home/judge/etc
sudo    mkdir /home/judge/data
sudo    mkdir /home/judge/log
sudo    mkdir /home/judge/run0
sudo    mkdir /home/judge/run1
sudo    mkdir /home/judge/run2
sudo    mkdir /home/judge/run3
cd install/
sudo cp java0.policy  judge.conf /home/judge/etc
sudo chown -R judge /home/judge
sudo chgrp -R $APACHEUSER /home/judge/data
sudo chgrp -R root /home/judge/etc /home/judge/run?
sudo chmod 775 /home/judge /home/judge/data /home/judge/etc /home/judge/run?

#boot up judged
sudo cp judged /etc/init.d/judged
sudo chmod +x  /etc/init.d/judged
sudo ln -s /etc/init.d/judged /etc/rc3.d/S93judged
sudo ln -s /etc/init.d/judged /etc/rc2.d/S93judged
sudo /etc/init.d/judged start
sudo /etc/init.d/apache2 restart

