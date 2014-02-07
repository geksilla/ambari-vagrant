#!/usr/bin/env bash

source /vagrant/sh/helpers.sh
source /vagrant/ambari_conf.sh

machines=$(head -n 1 /vagrant/.machines)
let machines-=1

if [[ ($1 == "--local") || ($1 == "--git")]]; then
  cd ~
  rm -rf ambari
  if [ $1 == "--git" ]; then
    echo_h "*** Clone ambari repo ***"
    git clone $default_git_url ambari # clone from git
  elif [ $1 == "--local" ]; then
    echo_h "*** Copy from /host directory ***"
    mkdir -p ambari && cp -rf /host/* ~/ambari # local copy
  fi
  echo "*** Build rpm ***"
  cd $AMBARI_DIR
  if [[ -z $build_version ]]; then
    mvn clean package rpm:rpm -DskipTests=true
  else
    mvn clean package rpm:rpm -DskipTests=true -DambariVersion=$build_version
  fi
  echo_h "*** Install ambari-server ***"
  yum install $AMBARI_DIR/ambari-server/target/rpm/ambari-server/RPMS/noarch/*.rpm -y
  echo_h "*** Install ambari-agent ***"
  yum install $AMBARI_DIR/ambari-agent/target/rpm/ambari-agent/RPMS/x86_64/*.rpm -y
  echo_h "*** Setup ambari-server ***"
  ambari-server setup -s
  echo_h "*** Execute 'on_finish' function ***"
  on_finish
  copy_repo $default_repo_url
  ambari-server start
  ambari-agent start
fi

if [ $1 == "--repo" ]; then
  echo_h "*** Clone ambari.repo ***"
  copy_repo $2
  yum clean all
  echo_h "*** INSTALL: ambari-server"
  yum install ambari-server -y
  echo_h "*** INSTALL: ambari-agent"
  yum install ambari-agent -y
  echo_h "*** Execute 'on_finish' function ***"
  on_finish
  ambari-server setup -s
  ambari-server start
  ambari-agent start
fi
