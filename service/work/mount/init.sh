#!/bin/bash

set -eux

dockerize -wait tcp://ldap:${LDAP_PORT} -wait tcp://its:${ITS_PORT} 

ldapadd -h ldap -x -D "cn=admin,dc=example,dc=org" -w admin -f /tmp/add-users.ldif

psql -h dbms -d redmine -U redmine -f /tmp/redmine-additional-config.sql
