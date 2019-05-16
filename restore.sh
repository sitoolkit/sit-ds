#!/bin/bash

# This script is to restore docker volumes defined in sit-ds/docker-compose.yml.
 
 source ./common.sh 

if [ $# = 0 ]; then
  log 'Retry add the full path of the backup directory to the argument.'
  exit
else
  readonly BACKUP_DIR=$1
fi

do_restore() {
  for restore_file in $(ls ${BACKUP_DIR}); do
    if [ $(echo $restore_file | grep -e "${VOLUME_PREFIX}") ] && [ $(echo $restore_file | grep -e ".tar") ]; then
        volume_name=${restore_file%.*}
        log "Start restore ${volume_name}."

        docker run --rm \
            -v ${volume_name}:/target \
            -v ${BACKUP_DIR}:/backup \
            ubuntu bash -c 'tar xvf /backup/'${restore_file}' -C /target'
    fi
  done

    log "End all restore in ${BACKUP_DIR} $(docker volume ls)"
}

docker-compose stop
do_restore
docker-compose start
