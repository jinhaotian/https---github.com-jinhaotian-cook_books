#
# Cookbook Name:: ecomm-tomcat6
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "ark"

user node['ecomm-tomcat']['user']  do
  comment 'the user who will run tomcat instance'
  home '/home/'+ node['ecomm-tomcat']['user']
  shell '/bin/bash'
  password 'password'
end

group node['ecomm-tomcat']['group']  do
  action :create
  members node['ecomm-tomcat']['user']
  append true
end


#ark 'tomcat' do
#  url node['ecomm-tomcat']['tomcat_release_url'] 
#  version '6.0.44'
#end

tomcat = node['ecomm-tomcat']["#{node['ecomm-tomcat']['version']}"]; 

remote_file "/opt/#{tomcat['tomcat_release_file']}" do
  source "#{tomcat['tomcat_release_url']}"
  notifies :run, "bash[install_tomcat]", :immediately
end

bash "install_tomcat" do
  user "root"
  cwd "/opt/"
  code <<-EOH
    tar -zxf "/opt/#{tomcat['tomcat_release_file']}"
  EOH
  action :nothing
end

link tomcat['catalina_home'] do
  to "/opt/#{tomcat['tomcat_local_deploy']}"
  link_type :symbolic
end


cookbook_file '/etc/init.d/tomcat' do
  source 'tomcat'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/bin" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/conf" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/logs" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/temp" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/webapps" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end

directory "/var/#{node['ecomm-tomcat']['user']}/work" do
  owner node['ecomm-tomcat']['user']
  group node['ecomm-tomcat']['group']
  mode '0755'
  action :create
end


#bash "install_tomcat" do
#  user "root"
#  cwd "/tmp"
#  code <<-EOH
#    tar -zxf apache-tomcat-6.0.44.tar.gz
#    mv apache-tomcat-6.0.44  /opt/
#    
#  EOH
#  action :nothing
#end

