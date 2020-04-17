#!/bin/bash

set -eux

readonly INIT_FILE='/tmp/.init'

dockerize -wait tcp://${LDAP_HOST}:${LDAP_PORT} -wait tcp://its:3000 -timeout 60s

if [[ -e ${INIT_FILE} ]]; then

  exit 0

fi

psql -h dbms -p ${DB_PORT} -d redmine -U redmine -f /tmp/redmine-additional-config.sql

touch ${INIT_FILE}
