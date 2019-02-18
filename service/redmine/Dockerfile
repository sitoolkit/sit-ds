FROM redmine:passenger

COPY config.ru /usr/src/redmine/config.ru

ENV DOCKERIZE_VERSION=v0.6.1 \
    CONF_DIR=/usr/src/redmine/config

RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

ADD tmpl.configuration.yml /usr/src/redmine/config/

ENTRYPOINT dockerize -template ${CONF_DIR}/tmpl.configuration.yml:${CONF_DIR}/configuration.yml -wait tcp://dbms:${DB_PORT} /docker-entrypoint.sh passenger start
