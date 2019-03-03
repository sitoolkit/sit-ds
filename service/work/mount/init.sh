#!/bin/bash

set -eux

dockerize -wait tcp://ldap:${LDAP_PORT} -wait tcp://its:${ITS_PORT} 

ldapadd -c -h ldap -x -D "{{ .Env.LDAP_MANAGER_DN }}" -w {{ .Env.LDAP_MANAGER_PASSWORD }} -f /tmp/add-users.ldif || true

psql -h dbms -d redmine -U redmine -f /tmp/redmine-additional-config.sql || true
