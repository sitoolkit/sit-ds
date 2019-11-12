#!/bin/sh

AUTH_HEADER="Authorization:Basic `echo -n admin:password | openssl base64`"
BASE_URL="http://localhost:8081/artifactory"
CURRENT_SETTING="/tmp/current-setting.xml"
UPDATE_SETTING="/tmp/update-setting.xml"
NO_LDAP_MSG="<ldapSettings/>"
LDAP_SETTING="/tmp/ldap-setting.xml"

waitArtifactoryRunning() {
  while :
  do
    running=`wget --header="${AUTH_HEADER}" -O - ${BASE_URL}/api/system/ping`
    if [ "${running}" = "OK" ] ; then
      break;
    fi
    sleep 1
  done
}

getSettings() {
  wget --header="${AUTH_HEADER}" \
    -O ${CURRENT_SETTING} \
    ${BASE_URL}/api/system/configuration
}

updateSettings() {
  sed -e "s|^ *${NO_LDAP_MSG}$|`cat ${LDAP_SETTING}`|" ${CURRENT_SETTING} > ${UPDATE_SETTING}
  # TODO Post
  echo "TODO update"
}

waitArtifactoryRunning
getSettings
if [ `grep "${NO_LDAP_MSG}" ${CURRENT_SETTING} | wc -l` -eq 1 ] ; then
  updateSettings
fi
