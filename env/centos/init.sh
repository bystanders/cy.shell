#!/bin/bash

echo "run as root!"
basepath=$(cd `dirname $0`; pwd)
echo $basepath

echo 'hostname:'
 hostname
echo
echo 'Please edit /etc/sysconfig/network to change hostname, wait 5s...'
 sleep 5s
 cp -p /etc/sysconfig/network /etc/sysconfig/network.bak
 vi /etc/sysconfig/network
echo
echo 'Please edit /etc/hosts for DNS, wait 5s...'
# sleep 5s
# cp -p /etc/hosts /etc/hosts.bak
 cat /etc/hosts

# If connecting remotely we must first temporarily set the default policy on the INPUT chain to ACCEPT otherwise once we flush the current rules we will be locked out of our server.
#
 iptables -P INPUT ACCEPT
#
# Allow smtp/http/https/soht connections on tcp port 25/80/443/8085
#
echo
echo 'Allow Mail(SMTP) connections on tcp port 25'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 25 -j ACCEPT
echo 'Allow WWW(HTTP) connections on tcp port 80'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
echo 'Allow Secure WWW(HTTPS) connections on tcp port 443'
 iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport 443 -j ACCEPT
echo
#
# Save settings
#
 /sbin/service iptables save
#
# List rules
#
echo
echo 'List rules:'
 iptables -L -v
echo 'restart iptables in 10s...'
# sleep 10s
 /sbin/service iptables restart 
#
# system
#
echo
 yum install git
echo "update/install git ok"
echo
 yum install svn
echo "update/install svn ok"
echo
 yum install gcc
echo "update/install gcc ok"
#
# web
#
echo
 yum install httpd
echo "update/install httpd ok"
echo
 yum install php
echo "update/install php ok"
echo
 yum install unixODBC
echo "install unixODBC ok"
echo
 yum install php-odbc
echo "install php-odbc ok"
echo
 yum install php-gd
echo "install php-gd ok"
echo
 yum install python
echo "update/install python ok"

echo "change mode of reboot.sh into executable as root"
 chmod 665 $basepath/reboot.sh
echo "add line '$basepath/reboot.sh' into /etc/rc.local for reboot start automatically, wait 10s..."
 sleep 10s
 cp -p /etc/rc.local /etc/rc.local.bak
 vi /etc/rc.local

echo "reboot in 10s..."
 sleep 10s
 reboot
echo "reboot now"
