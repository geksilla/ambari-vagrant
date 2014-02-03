#!/usr/bin/env bash

path_to_key=/vagrant/insecure_private_key
machines=$(head -n 1 /vagrant/.machines)
let machines-=1

for i in $(seq 1 $machines)
do
  scp -i  $path_to_key -o StrictHostKeyChecking=no -rp $AMBARI_DIR/ambari-agent/target/rpm/ambari-agent/RPMS/* root@c640$(($i+1)):/root/
  ssh -n -i $path_to_key root@c640$(($i+1)) 'cd ~ && yum install /root/x86_64/*.rpm -y && ambari-agent start'
done