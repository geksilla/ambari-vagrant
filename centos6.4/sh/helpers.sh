function echo_h {
  color='\033[1;35m'
  nocolor='\033[0m'
  echo -e "\n${color}$1${nocolor}"
}

function copy_repo {
  echo_h "*** Copy ambari.repo file ***"
   if [[ $1 =~  ^http:|https: ]]; then
    wget -O /etc/yum.repos.d/ambari.repo $1
  else
    cp -f /vagrant/$1 /etc/yum.repos.d/ambari.repo
  fi
}