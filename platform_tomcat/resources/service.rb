property :port,Integer,name_property:true

action :restart do
  execute 'restart tomcat6' do
    command "/etc/init.d/tomcat #{port} restart"
  end
end


action :stop do
  execute 'restart tomcat6' do
    command "/etc/init.d/tomcat  #{port}  stop"
  end
end


action :start do
  execute 'restart tomcat6' do
    command "/etc/init.d/tomcat  #{port}  start"
  end
end

