#!/bin/bash

set -eux

readonly INIT_FILE='/tmp/.init'

dockerize -wait tcp://ldap:${LDAP_PORT} -wait tcp://its:${ITS_PORT} 

if [[ -e ${INIT_FILE} ]]; then

  exit 0

fi

psql -h dbms -d redmine -U redmine -f /tmp/redmine-additional-config.sql

touch ${INIT_FILE}
