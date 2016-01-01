#
# Cookbook Name:: platform-rds-release
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user=node['ecomm-tomcat']['user']
group=node['ecomm-tomcat']['group']

deploy_dir = node['platform_rds_release']['deploy_dir']

directory "#{deploy_dir}"  do
  owner user
  group group
  mode '0755'
  action :create
end

directory "#{deploy_dir}/configs"  do
  owner user
  group group
  mode '0755'
  action :create
end

directory "#{deploy_dir}/apps"  do
  owner user
  group group
  mode '0755'
  action :create
end

