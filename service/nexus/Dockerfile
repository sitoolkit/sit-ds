ARG VERSION_ARM
FROM sonatype/nexus3:${VERSION_ARM}

USER root
RUN microdnf update && microdnf install gettext jq

COPY conf/ /tmp
RUN chmod a+x /tmp/init-config.sh

USER nexus
ENTRYPOINT /tmp/init-config.sh & /opt/sonatype/nexus/bin/nexus run