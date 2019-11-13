ARG VERSION_ARM
ARG VERSION_UBUNTU
FROM docker.bintray.io/jfrog/artifactory-oss:${VERSION_ARM} AS base
FROM ubuntu:${VERSION_UBUNTU}

ENV ARTIFACTORY_USER_NAME=artifactory \
    ARTIFACTORY_USER_ID=1030 \
    ARTIFACTORY_HOME=/opt/jfrog/artifactory \
    ARTIFACTORY_DATA=/var/opt/jfrog/artifactory \
    ARTIFACTORY_EXTRA_CONF=/artifactory_extra_conf \
    RECOMMENDED_MAX_OPEN_FILES=32000 \
    MIN_MAX_OPEN_FILES=10000 \
    JAVA_HOME=/java/jdk-11.0.2+9 \
    RECOMMENDED_MAX_OPEN_PROCESSES=1024

COPY --from=base /opt/jfrog /opt/jfrog
COPY --from=base /var/opt/jfrog/artifactory /var/opt/jfrog/artifactory
COPY --from=base /entrypoint-artifactory.sh /entrypoint-artifactory.sh
COPY --from=base /java /java

RUN useradd -M -s /usr/sbin/nologin --uid ${ARTIFACTORY_USER_ID} --user-group ${ARTIFACTORY_USER_NAME} && \
    chown -R ${ARTIFACTORY_USER_NAME}:${ARTIFACTORY_USER_NAME} ${ARTIFACTORY_HOME} ${ARTIFACTORY_DATA}

RUN set -eux \
  && : "Install wget" \
  && apt-get update -y && apt-get install -y wget \
  && rm -rf /var/lib/apt/lists/*

ENV DOCKERIZE_VERSION=v0.6.1
RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

COPY tmpl.ldap-setting.xml /tmp
COPY update-setting.sh /
RUN chmod a+x /update-setting.sh

USER ${ARTIFACTORY_USER_NAME}
VOLUME ${ARTIFACTORY_DATA}
VOLUME ${ARTIFACTORY_EXTRA_CONF}

ENTRYPOINT dockerize \
  -template /tmp/tmpl.ldap-setting.xml:/tmp/ldap-setting.xml \
  /update-setting.sh & \
  /entrypoint-artifactory.sh
