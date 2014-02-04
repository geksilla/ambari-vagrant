#!/bin/bash

os_type="centos6" # OS type
# repo url you can pass link to ambari.repo or local path file related to Vagrantfile folder
default_repo_url="/path/to/ambari.repo"
# git repository url which ambari project will be cloned
default_git_url="/git/url"
# ambari version target for manual build
build_version="1.5.0"

# this function will call after ambari-server and ambari-agent installation
function on_finish {
  # Example:
  # echo_h "*** Remove web folder from ambari server ***"
  # rm -rf /usr/lib/ambari-server/web
  # echo_h "*** Create symlink to local web folder ***"
  # ln -s /host/ambari-web/public /usr/lib/ambari-server/web
}
