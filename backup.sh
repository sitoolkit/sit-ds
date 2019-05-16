#!/bin/bash

# This script is to backup docker volumes defined in sit-ds/docker-compose.yml.
# Backup files are stored in the directory specified by the first argument
# and hold 7 generations.

 source ./common.sh 

BACKUP_ROOT="${1:-$(cd $(dirname $0);pwd)/backup}"

do_backup() {
    readonly VOLUME_PREFIX=${COMMON_VOLUME_PREFIX}
    readonly BACKUP_VOLUMES=${COMMON_VOLUMES[@]}
    readonly TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
    readonly LOCAL_BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"

    for backup_volume in ${BACKUP_VOLUMES[@]}; do
        volume_name=${VOLUME_PREFIX}${backup_volume}
        log "Start backup ${volume_name} to ${LOCAL_BACKUP_DIR}"

        docker run --rm \
            -v ${volume_name}:/target \
            -v ${LOCAL_BACKUP_DIR}:/backup \
            ubuntu \
            tar cf /backup/${volume_name}.tar -C /target .
    done

    log "End all backup in ${LOCAL_BACKUP_DIR} $(ls -hkl ${LOCAL_BACKUP_DIR})"
}



delete_old_backup() {
    readonly BACKUP_DIR_NAMES=("$(ls -r ${BACKUP_ROOT})")
    readonly BACKUP_DIR_LIMIT=7
    dir_count=1

    log "Check backup history in ${BACKUP_ROOT} $(ls -hkl ${BACKUP_ROOT})"

    for backup_dir_name in ${BACKUP_DIR_NAMES}; do

        if [[ ${dir_count} > ${BACKUP_DIR_LIMIT} ]]; then
            backup_dir_path=${BACKUP_ROOT}/${backup_dir_name}
            log "Deleting old backup directory : ${backup_dir_path}"

            rm -rf ${backup_dir_path}
        fi

        let dir_count++

    done
}


if [[ ! -e ${BACKUP_ROOT} ]]; then
    mkdir -p ${BACKUP_ROOT}
fi

docker-compose stop
do_backup
delete_old_backup
docker-compose start
