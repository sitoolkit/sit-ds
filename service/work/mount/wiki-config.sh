#!/bin/bash

BASE_URL="http://wiki:3000/"
auth=""

getConfigData() {
  jq -r '.'$1 wiki-config-data.json
}

finalize() {
  curl -sS -X POST ${BASE_URL}finalize\
  -H "Content-Type: application/json" \
  -d "$(getConfigData finalize)"
}

graphqlQuery() {
  curl -sS -X POST ${BASE_URL}graphql\
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${auth}" \
  -d "$1"
}

finalize
until [[ $(curl -I -s "${BASE_URL}/"|head -n 1|cut -d$' ' -f2) == 200 ]]; do sleep 5; done
auth=$(graphqlQuery "$(getConfigData auth)" | jq -r 'recurse | select(.jwt?).jwt')

graphqlQuery "$(getConfigData group)"
graphqlQuery "$(getConfigData groupPermission)"
graphqlQuery "$(getConfigData ldap)"
graphqlQuery "$(getConfigData searchEngine)"

echo "* wiki.js configuration has been completed."