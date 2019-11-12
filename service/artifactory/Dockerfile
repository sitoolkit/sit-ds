ARG VERSION
FROM docker.bintray.io/jfrog/artifactory-oss:${VERSION}

ENV DOCKERIZE_VERSION=v0.6.1

USER root

RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/bin \
    && rm dockerize.tar.gz

COPY tmpl.ldap-setting.xml /tmp
COPY update-setting.sh /
RUN chmod a+x /update-setting.sh

USER artifactory
ENTRYPOINT dockerize \
  -template /tmp/tmpl.ldap-setting.xml:/tmp/ldap-setting.xml \
  /update-setting.sh & \
  /entrypoint-artifactory.sh
