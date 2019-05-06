ARG VERSION
FROM jwilder/dockerize:${VERSION}

RUN apk update && apk add bash tree postgresql-client openldap-clients && rm -rf /var/cache/apk/*

ENV PATH $PATH:/tmp

WORKDIR /tmp

CMD dockerize -template /mnt:/tmp \
  chmod u+x /tmp/init.sh ;\
  chmod u+x /tmp/ldapmod ;\
  chmod u+x /tmp/adminpassmod ;\
  /tmp/init.sh ;\
  tail -f /dev/null
