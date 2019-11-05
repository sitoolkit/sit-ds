#!/bin/sh

CONTEXT_PATH="/nexus"
MAX_HEAP="768m"
MIN_HEAP="256m"
JAVA_OPTS="-server -Djava.net.preferIPv4Stack=true"
LAUNCHER_CONF="./conf/jetty.xml ./conf/jetty-requestlog.xml"

mkdir -p ${SONATYPE_WORK}/conf
cp /tmp/ldap.xml ${SONATYPE_WORK}/conf

java \
  -Dnexus-work=${SONATYPE_WORK} -Dnexus-webapp-context-path=${CONTEXT_PATH} \
  -Xms${MIN_HEAP} -Xmx${MAX_HEAP} \
  -cp 'conf/:lib/*' \
  ${JAVA_OPTS} \
  org.sonatype.nexus.bootstrap.Launcher ${LAUNCHER_CONF}
