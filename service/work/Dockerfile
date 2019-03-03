FROM jwilder/dockerize

RUN apk update && apk add bash tree postgresql-client openldap-clients && rm -rf /var/cache/apk/*

CMD chmod u+x /mnt/init.sh ; dockerize -template /mnt:/tmp tail -f /dev/null
