#!/usr/bin/env bash

cp /vagrant/hosts /etc/hosts
cp /vagrant/resolv.conf /etc/resolv.conf
cp -rf  /home/vagrant/.ssh /root
yum install ntp -y
service ntpd start
service iptables stop
yum install git -y
yum install rpm-build -y