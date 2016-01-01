export JAVA_HOME=/usr/lib/jvm/java
export CATALINA_HOME=/var/tomcat7
export CATALINA_BASE=/var/tom8080
export CATALINA_TMPDIR=/var/java-cache/tom8080

# standard GC logging options
CATALINA_OPTS_GC_LOG="-XX:+PrintHeapAtGC -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCApplicationStoppedTime -XX:+PrintTenuringDistribution -Xloggc:${CATALINA_BASE}/logs/gclog.txt"

# standard JMX options
CATALINA_OPTS_JMX="-Dcom.sun.management.jmxremote.ssl=false -Dcom.sun.management.jmxremote.port=8089 -Dcom.sun.management.jmxremote.authenticate=true -Dcom.sun.management.jmxremote.password.file=${CATALINA_BASE}/conf/jmxremote.password -Dcom.sun.management.jmxremote.access.file=${CATALINA_BASE}/conf/jmxremote.access"

# standard Concurrent Mark and Sweep GC options
CATALINA_OPTS_GC_CMS="-XX:+UseConcMarkSweepGC -XX:CMSInitiatingOccupancyFraction=80 -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:CMSFullGCsBeforeCompaction=0 -XX:+CMSClassUnloadingEnabled"

# other GC behavior options
CATALINA_OPTS_GC="-XX:+DisableExplicitGC -XX:+UseParNewGC -Xms1000m -Xmx1500m -XX:TargetSurvivorRatio=90 -XX:MaxPermSize=128m -XX:SurvivorRatio=8 -XX:NewSize=500m -XX:MaxNewSize=500m -XX:SoftRefLRUPolicyMSPerMB=75 -XX:MaxTenuringThreshold=1"

# remote debugging options
CATALINA_OPTS_JPDA="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=n,address=8086"

# YourKit
# CATALINA_OPTS_YJP="-agentpath:/home/tom8080/yjp-9.5.6/bin/linux-x86-64/libyjpagent.so=disablestacktelemetry,disableexceptiontelemetry,builtinprobes=none,delay=10000"

# misc
CATALINA_OPTS_MISC="-d64 -Duser.timezone=America/Los_Angeles"

CATALINA_OPTS="${CATALINA_OPTS_MISC} ${CATALINA_OPTS_GC} ${CATALINA_OPTS_GC_CMS} ${CATALINA_OPTS_GC_LOG} ${CATALINA_OPTS_JMX} ${CATALINA_OPTS_JPDA} ${CATALINA_OPTS_YJP}"
