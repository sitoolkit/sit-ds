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
    if [ $(echo $restore_file | grep -e "${VOLUME_PREFIX}") ]; then
        volume_name=${restore_file%.*}
        log "Start restore ${volume_name}."

        docker run --rm \
            -v ${volume_name}:/target \
            -v ${BACKUP_DIR}:/backup \
            ubuntu bash -c 'tar xvf /backup/'${file}' -C /target'
    fi
  done

    log "End all restore in ${BACKUP_DIR} $(ls -hkl ${BACKUP_DIR})"
}

docker-compose stop
do_restore
docker-compose start
