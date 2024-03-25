ARG VERSION
FROM jwilder/dockerize:${VERSION}

RUN apk update --no-cache && \
    apk add --no-cache bash tree postgresql-client openldap-clients curl jq

ENV PATH $PATH:/tmp

WORKDIR /tmp

CMD dockerize -template /mnt:./ \
  chmod u+x init.sh ldapmod nexus-config.sh && \
  ./init.sh && \
  tail -f /dev/null
