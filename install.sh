#!/bin/bash
sudo apt-get install ssh -y
sudo apt-get install proftpd-* -y
mdpc1=$(per1 -e 'print crypt("kallimac", "salt")')
mdpc2=$(per1 -e 'print crypt("secondbreakfast", "salt")')

sudo useradd -m -p $mdpc1 Merry
sudo useradd -m -p $mdpc2 Pippin
cd /etc/proftpd
cp proftpd.conf proftpd.conf.save
echo "<Anonymous ~ftp>
User ftp
Group nogroup
UserAllias anonymous ftp
DirFakeUser on ftp
DirFakeGroup on ftp
RequiereValidShell off
Maxclients 10
DisplayLogin welcome.msg
DisplayChdir .message

<Directory *>
<Limit WRITE>
AllawAll
</Limit>
</Directory>

<Directory incoming>
<Limit READ WRITE>
AllowAll
</Limit>
</Directory>
</Anonymous>

">> proftpd.conf
sudo systemctl restart proftpd
sudo systemctl status proftpd

