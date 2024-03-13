#!/bin/bash

INIT_FILE="${NEXUS_DATA}/.init"
ADMIN_PW_FILE="${NEXUS_DATA}/admin.password"
ADMIN_USER="admin"
NEXUS_HOST="http://localhost:8081/${NEXUS_CONTEXT}"

cd "$(dirname "$0")"

if [ "${NEXUS_HOST: -1}" != "/"  ]; then
  NEXUS_HOST=${NEXUS_HOST}/
fi

if [ -e "${INIT_FILE}" ]; then
  echo "* Nexus3 has already been initially configured."
  exit 0
fi

echo "* Waiting for the Nexus3 to become available - this can take a few minutes"
until [[ $(curl -I -s "${NEXUS_HOST}"|head -n 1|cut -d$" " -f2) == 200 ]]; do sleep 5; done
echo "* Nexus3 is now available. Start initial configuration."

if [ -f ${ADMIN_PW_FILE} ]; then
  password=$(<${ADMIN_PW_FILE})
else
  echo "[ERR] File ${ADMIN_PW_FILE} doesn't exist. This file contain your current local password."
  exit 1
fi

curl -sS -X "PUT" -u ${ADMIN_USER}:${password} "${NEXUS_HOST}service/rest/v1/security/users/admin/change-password" \
  -H "Content-Type: text/plain" \
  -d "${LDAP_MANAGER_PASSWORD}"


nexusInitRestUtil() {
  curl -sS -X "$1" -u ${ADMIN_USER}:${LDAP_MANAGER_PASSWORD} "${NEXUS_HOST}service/rest/v1/security/$2" \
  -H "Content-Type: application/json" \
  -d "$3"
}

nexusInitRestUtil "PUT" "anonymous" "$(nexusInitRestUtil "GET" "anonymous" | jq '.enabled=false')"
nexusInitRestUtil "POST" "ldap" "$(cat data/tmpl.ldap.json | envsubst)"
nexusInitRestUtil "POST" "roles" "@data/role-nx-dev.json"
nexusInitRestUtil "POST" "roles" "$(cat data/tmpl.role-ldap-dev.json | envsubst)"
nexusInitRestUtil "PUT" "realms/active" "$(nexusInitRestUtil "GET" "realms/active" | jq '.+["NpmToken"]')"

echo "* Initial configuration has been completed."
touch ${INIT_FILE}