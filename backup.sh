#!/bin/bash

# This script is to backup docker volumes defined in sit-ds/docker-compose.yml.
# Backup files are stored in the directory specified by the first argument
# and hold 7 generations.

BACKUP_ROOT="${1:-$(cd $(dirname $0);pwd)/backup}"

log() {
    echo "$1"
    logger -i -t 'sit-ds-backup' "$1"
}


do_backup() {
  readonly VOLUME_PREFIX='sit-ds_'
  readonly BACKUP_VOLUMES=(
    "ci_data" "dbms_data" "its_data" "ldap_conf"
    "ldap_data" "sca_data" "scm_data" "arm_data")
  readonly TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
  readonly COMMIT_ID="$(git rev-parse HEAD)"
  readonly LOCAL_BACKUP_DIR="${BACKUP_ROOT}/${TIMESTAMP}"
  readonly COMMIT_ID_FILE="${LOCAL_BACKUP_DIR}/commit-id.txt"

  for backup_volume in ${BACKUP_VOLUMES[@]}; do
    volume_name=${VOLUME_PREFIX}${backup_volume}
    log "Start backup ${volume_name} to ${LOCAL_BACKUP_DIR}"

    docker run --rm \
      -v ${volume_name}:/target \
      -v ${LOCAL_BACKUP_DIR}:/backup \
      ubuntu \
      tar cfz /backup/${volume_name}.tar.gz -C /target .
  done
  
  echo ${COMMIT_ID} > ${COMMIT_ID_FILE}

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
      echo "Deleting old backup directory : ${backup_dir_path}"

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
