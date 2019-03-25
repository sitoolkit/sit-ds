ARG VERSION
FROM php:${VERSION}

ENV SSP_VERSION=1.3 \
    DOCKERIZE_VERSION=v0.6.1 \
    INST_DIR=/var/www/html

RUN set -eux \
    && : "Install dockerize" \
    && curl -sSL -o dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz \
    && : "Install ldap client" \
    && apt-get update && apt-get install libldap2-dev \
    && rm -r /var/lib/apt/lists/* \
    && docker-php-ext-install -j$(nproc) ldap \
    && : "Install ssp" \
    && curl -sSL -o ssp.tar.gz http://ltb-project.org/archives/ltb-project-self-service-password-${SSP_VERSION}.tar.gz \
    && mkdir -p ${INST_DIR} \
    && tar -zxf ssp.tar.gz -C ${INST_DIR} --strip 1 \
    && rm ssp.tar.gz

ADD tmpl.config.inc.local.php ${INST_DIR}/conf

CMD dockerize -template ${INST_DIR}/conf/tmpl.config.inc.local.php:${INST_DIR}/conf/config.inc.local.php apache2-foreground
