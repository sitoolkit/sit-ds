FROM jwilder/dockerize

RUN apk update && apk add bash tree postgresql-client openldap-clients && rm -rf /var/cache/apk/*

CMD dockerize -template /mnt:/tmp tail -f /dev/null
