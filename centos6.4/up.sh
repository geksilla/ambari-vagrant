#!/bin/bash
source ambari_conf.sh

if [ -z "$2" ]; then
  options="--repo $default_repo_url"
elif [[ ($2 == "--repo") && ( -z $3)]]; then
  options="$2 $default_repo_url"
else
  options="$2 $3"
fi
for i in `seq -f '%02g' 1 $1`;
do
  INSTALL_OPTIONS="$options" vagrant up --parallel c64$i
done
echo "$1" > .machines
