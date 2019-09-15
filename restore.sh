#!/bin/bash

# This script is to restore docker volumes defined in sit-ds/docker-compose.yml.

if [ $# = 0 ]; then
  echo 'Retry add the full path of the backup directory to the argument.'
  exit
else
  readonly BACKUP_DIR=$1
fi

do_restore() {
  readonly VOLUME_PREFIX='sit-ds_'

  for restore_file in $(ls ${BACKUP_DIR}); do
    if [ $(echo $restore_file | grep -e "${VOLUME_PREFIX}") ] && [ $(echo $restore_file | grep -e ".tar.gz") ]; then
      volume_name=${restore_file%%.*}
      echo "Start restore ${volume_name}."

      docker run --rm \
        -v ${volume_name}:/target \
        -v ${BACKUP_DIR}:/backup \
        ubuntu bash -c 'tar xfz /backup/'${restore_file}' -C /target'
    fi
  done

  echo "End all restore in ${BACKUP_DIR} $(docker volume ls)"
}

do_restore
