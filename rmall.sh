#!/bin/sh
sudo userdel judge
sudo rm -r /var/www/scutoj/
sudo rm -r /home/judge/
sudo rm /etc/init.d/judged /etc/init.d/judge_client /etc/rc3.d/S93judged
sudo rm /etc/rc2.d/S93judged
sudo rm /usr/bin/sim_c /usr/bin/sim_cc /usr/bin/sim_rb /usr/bin/sim_sh
