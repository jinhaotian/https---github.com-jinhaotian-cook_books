default['ecomm-tomcat']['user'] = 'tom8080'
default['ecomm-tomcat']['group'] = 'software'
default['ecomm-tomcat']['basedir'] = '/var/tom8080'
default['ecomm-tomcat']['port'] = '8080'

default['ecomm-tomcat']['version'] = '7'

default['ecomm-tomcat']['6']['catalina_home'] = '/var/tomcat6'
default['ecomm-tomcat']['6']['tomcat_release_file'] = 'apache-tomcat-6.0.44.tar.gz'
default['ecomm-tomcat']['6']['tomcat_local_deploy'] = 'apache-tomcat-6.0.44'
default['ecomm-tomcat']['6']['tomcat_release_dir'] = 'http://10.151.58.230/software/'
default['ecomm-tomcat']['6']['tomcat_release_url'] = default['ecomm-tomcat']['6']['tomcat_release_dir']+ default['ecomm-tomcat']['6']['tomcat_release_file']

default['ecomm-tomcat']['7']['catalina_home'] = '/var/tomcat7'
default['ecomm-tomcat']['7']['tomcat_release_file'] = 'apache-tomcat-7.0.14.tar.gz'
default['ecomm-tomcat']['7']['tomcat_local_deploy'] = 'apache-tomcat-7.0.14'
default['ecomm-tomcat']['7']['tomcat_release_dir'] = 'http://10.151.58.230/software/'
default['ecomm-tomcat']['7']['tomcat_release_url'] = default['ecomm-tomcat']['7']['tomcat_release_dir']+ default['ecomm-tomcat']['7']['tomcat_release_file']
