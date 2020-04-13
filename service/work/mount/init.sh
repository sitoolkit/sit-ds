#!/bin/bash

set -eux

readonly INIT_FILE='/tmp/.init'

dockerize -wait tcp://ldap:389 -wait tcp://its:3000 -timeout 60s

if [[ -e ${INIT_FILE} ]]; then

  exit 0

fi

psql -h dbms -d redmine -U redmine -f /tmp/redmine-additional-config.sql

touch ${INIT_FILE}
