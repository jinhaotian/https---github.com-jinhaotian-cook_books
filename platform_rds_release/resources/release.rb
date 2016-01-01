property :target,String,name_property:true
property :config_name,String
property :app_name,String
property :service_name,String
property :version,String

config_repo = node['platform_rds_release']['config_repo']
app_repo = node['platform_rds_release']['app_repo']
deploy_dir =node['platform_rds_release']['deploy_dir']

user = node['ecomm-tomcat']['user']
group = node['ecomm-tomcat']['group']
working_dir = "#{node['ecomm-tomcat']['basedir']}"
env = node['platform_rds_release']['env'] 


action :release do
  remote_file "#{deploy_dir}/configs/#{config_name}-#{version}.tar" do
    source "#{config_repo}#{version}/configs-#{version}-#{config_name}-#{env}.tar"
    owner user
    group group
    mode '0755'
    action :create
  end
 
  execute 'cd #{deploy_dir}/configs/;tar xvf #{config_name}-#{version}.tar -C #{version}; chown #{user}:#{group} #{version}/*' do
    user user
    group group
    cwd "#{deploy_dir}/configs/"
    command "cd #{deploy_dir}/configs/;mkdir -p #{version};tar xvf #{config_name}-#{version}.tar -C #{version}; chown #{user}:#{group} #{version}/*"
    #not_if 'bundle check' # This is not run inside /myapp
  end

  execute 'move new config to destination' do
    user user
    group group
    cwd "#{deploy_dir}/configs/"
    command "cd #{deploy_dir}/configs/;cp #{version}/* #{working_dir}/conf/;chown #{user}:#{group} #{working_dir}/conf/*"
    #not_if 'bundle check' # This is not run inside /myapp
  end
  
  remote_file "#{deploy_dir}/apps/#{app_name}-#{version}.war" do
    source "#{app_repo}/#{app_name}/#{version}/#{app_name}-#{version}.war"
    owner user
    group group
    mode '0755'
    action :create
  end

  bash 'deploy_app' do
    cwd ::File.dirname("#{deploy_dir}/apps/")
    code <<-EOH
      cd #{deploy_dir}/apps/
      cp #{app_name}-#{version}.war  #{working_dir}/webapps/#{service_name}.war
      chown #{user}:#{group} #{working_dir}/webapps/*
      EOH
  end
  
  platform_tomcat_service '8080' do
    action :restart
  end

end

  #bash 'deploy_config' do
  #cwd ::File.dirname("#{deploy_dir}/configs/")
  #code <<-EOH
  #  cd #{deploy_dir}/configs/
  #  tar xvf #{app_name}-#{version}.tar -C #{version}
  #  chown #{user}:#{group} #{version}/*
  #  cp #{version}/* #{config_ln_dir}/conf/
  #  chown #{user}:#{group} #{config_ln_dir}/conf/*
  #  EOH
  #not_if { ::File.exists?("#{version}")}
  #end







