FROM redmine:passenger

ENV DOCKERIZE_VERSION=v0.6.1 \
    REDMINE_DIR=/usr/src/redmine

RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

COPY config.ru ${REDMINE_DIR}
COPY tmpl.configuration.yml ${REDMINE_DIR}/config
COPY 20190227000000_insert_settings.rb.tmpl ${REDMINE_DIR}/db/migrate

ENTRYPOINT dockerize -template ${REDMINE_DIR}/db/migrate/20190227000000_insert_settings.rb.tmpl:${REDMINE_DIR}/db/migrate/20190227000000_insert_settings.rb -template ${REDMINE_DIR}/config/tmpl.configuration.yml:${REDMINE_DIR}/config/configuration.yml -wait tcp://dbms:${DB_PORT} /docker-entrypoint.sh passenger start
