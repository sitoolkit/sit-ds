ARG VERSION
FROM sonatype/nexus:${VERSION}

ENV DOCKERIZE_VERSION=v0.6.1

USER root

RUN set -eux \
    && : "Install dockerize" \
    && curl -sSL -o dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

COPY start.sh /opt/sonatype/nexus

USER nexus
COPY tmpl.ldap.xml /tmp
ENTRYPOINT dockerize -template /tmp/tmpl.ldap.xml:/tmp/ldap.xml cd /opt/sonatype/nexus && /bin/sh start.sh
