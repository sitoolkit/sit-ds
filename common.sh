#!/bin/bash

# This script is to restore docker volumes defined in sit-ds/docker-compose.yml.
 
log() {
    echo "$1"
    logger -i -t 'sit-ds-backup' "$1"
}

readonly COMMON_VOLUME_PREFIX='sit-ds_'
readonly COMMON_VOLUMES=(
    "ci_data" "dbms_data" "its_data" "ldap_conf"
    "ldap_data" "sca_data" "scm_data")
