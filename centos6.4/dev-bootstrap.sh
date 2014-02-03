  #!/usr/bin/env bash

source /vagrant/ambari_conf.sh
source /vagrant/sh/helpers.sh

# install tools necessary to build Ambari
echo_h "*** INSTALL: java jdk 1.6 ***"
yum install java-1.6.0-openjdk-devel -y
echo_h "*** INSTALL: Node.js ***"
wget http://nodejs.org/dist/v0.10.15/node-v0.10.15-linux-x64.tar.gz
tar zxvf node-v0.10.15-linux-x64.tar.gz
mv node-v0.10.15-linux-x64 /usr/share/node
ln -s /usr/share/node/bin/node /usr/sbin/node
ln -s /usr/share/node/bin/npm /usr/sbin/npm
rm -f node-v0.10.15-linux-x64.tar.gz
echo_h "*** INSTALL: Python 2.6 ***"
wget --no-check-certificate http://pypi.python.org/packages/2.6/s/setuptools/setuptools-0.6c11-py2.6.egg
sh setuptools-0.6c11-py2.6.egg
echo_h "*** INSTALL: brunch ***"
npm install -g brunch
rm -f setuptools-0.6c11-py2.6.egg
echo_h "*** INSTALL: Maven 3.0.5 ***"
wget http://apache.cp.if.ua/maven/maven-3/3.0.5/binaries/apache-maven-3.0.5-bin.tar.gz
tar zxvf apache-maven-3.0.5-bin.tar.gz
mv apache-maven-3.0.5 /usr/share/maven
ln -nfs /usr/share/maven/bin/mvn /usr/sbin/mvn
rm -f apache-maven-3.0.5-bin.tar.gz


# # make maven and node available in PATH
# echo 'pathmunge /usr/share/node/bin' > /etc/profile.d/node.sh
# chmod +x /etc/profile.d/node.sh
# echo 'pathmunge /usr/share/maven/bin' > /etc/profile.d/maven.sh
# chmod +x /etc/profile.d/maven.sh

# rm -rf $HOME
# cp /vagrant/README ~

# install last Ruby to increase performance for ruby scripts execution
# echo_h "*** INSTALL: Ruby ***"
# \curl -sSL https://get.rvm.io | bash -s
# source /etc/profile.d/rvm.sh
# rvm get head
# rvm requirements
# rvm install 2.1.0

echo_h "*** Add AMBARI_DIR to .bashrc ***"
echo "export AMBARI_DIR=/root/ambari" >> ~/.bashrc
echo_h 'Ambari Development VM has been set up! Enjoy!'
