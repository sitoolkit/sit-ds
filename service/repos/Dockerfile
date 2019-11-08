ARG VERSION
FROM docker.bintray.io/jfrog/artifactory-oss:${VERSION}

ENV DOCKERIZE_VERSION=v0.6.1

USER root

RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/bin \
    && rm dockerize.tar.gz

COPY tmpl.artifactory.config.import.xml /tmp

USER artifactory
ENTRYPOINT mkdir -p /var/opt/jfrog/artifactory/etc && \
  dockerize \
  -template /tmp/tmpl.artifactory.config.import.xml:/var/opt/jfrog/artifactory/etc/artifactory.config.import.xml \
  /entrypoint-artifactory.sh
