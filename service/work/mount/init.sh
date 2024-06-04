#!/bin/bash

set -eux

readonly INIT_FILE_DIR='/tmp/init'

dockerize -wait tcp://${LDAP_HOST}:${LDAP_PORT} -timeout 60s

initService() {
  if [[ ! -e ${INIT_FILE_DIR}/.$1 ]]; then
    dockerize -wait tcp://$2 -timeout 60s
    eval $3
    touch ${INIT_FILE_DIR}/.$1
  fi
}

initService redmine its:3000 \
  'PGPASSWORD=redmine psql -h dbms -p ${DB_PORT} -d redmine -U redmine -f /tmp/redmine-additional-config.sql'

initService wikijs wiki:3000 ./wiki-config.sh

initService nexus arm:8081 ./nexus-config.sh