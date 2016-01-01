#
# Cookbook Name:: platform-rds-authserver
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user=node['ecomm-tomcat']['user']
group=node['ecomm-tomcat']['group']
env=node['platform_rds_release']['env']
version = node['platform-authserver']['version']

cookbook_file 'setenv.sh' do
  path "/var/#{user}/bin/setenv.sh"
  source case env
    when 'test'
	'test/setenv.sh'
    when 'int'
        'int/setenv.sh'
     else
        'test/setenv.sh'
    end
  owner user
  group group
  mode '0755'
end

cookbook_file 'postDeploy.sh' do
  path "/var/#{user}/bin/postDeploy.sh"
  source  "#{env}/postDeploy.sh"
  owner user
  group group
  mode '0755'
end


cookbook_file 'tomcat-juli.jar' do
  path "/var/#{user}/bin/tomcat-juli.jar"
  source  "#{env}/tomcat-juli.jar"
  owner user
  group group
  mode '0755'
end

platform_rds_release_release 'authserver' do
  config_name  'authserver'
  app_name  'authserver-service'
  service_name 'authserver'
  version version
  action :release
end

#platform_tomcat_service '8080' do
#   action :restart
#end

