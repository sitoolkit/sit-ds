#!/bin/bash

ADMIN="admin:${LDAP_MANAGER_PASSWORD}"
BASE_URL="http://arm:8081/service/rest/v1/security/"
CONT_TEXT="text/plain"
CONT_JSON="application/json"

getConfig() {
  curl -sS -u "${ADMIN}" "${BASE_URL}$1"
}

updateConfig() {
  curl -sS -X "$1" -u "${ADMIN}" "${BASE_URL}$2" \
  -H "Content-Type: $3" \
  -d "$4"
}

updateConfig "PUT" "users/admin/change-password" "${CONT_TEXT}" "${LDAP_MANAGER_PASSWORD}"
updateConfig "PUT" "anonymous" "${CONT_JSON}" "$(getConfig "anonymous" | jq '.enabled=false')"
updateConfig "POST" "ldap" "${CONT_JSON}" "@nexus-ldap.json"
updateConfig "POST" "roles" "${CONT_JSON}" "@nexus-role-dev.json"
updateConfig "POST" "roles" "${CONT_JSON}" "@nexus-role-ldap.json"
updateConfig "PUT" "realms/active" "${CONT_JSON}" "$(getConfig "realms/active" | jq '.+["NpmToken"]')"

echo "* Nexus configuration has been completed."