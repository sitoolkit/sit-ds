ARG VERSION
FROM gitbucket/gitbucket:${VERSION}

ENV GITBUCKET_HOME=/etc/gitbucket \
    DOCKERIZE_VERSION=v0.6.1

RUN set -eux \
    && mkdir -p ${GITBUCKET_HOME}/tmp \
    && : "Install dockerize" \
    && curl -sSL -o dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

# Gitbucket supports to set configuration parameters via JVM arguments or environment variables,
# but when a boolean parameter is passed ClassCastException is thrown.
# So we use gitbucket.conf and dockerize template.

COPY tmpl.gitbucket.conf ${GITBUCKET_HOME}

CMD dockerize -no-overwrite -template ${GITBUCKET_HOME}/tmpl.gitbucket.conf:${GITBUCKET_HOME}/gitbucket.conf -wait tcp://dbms:5432 java -jar /opt/gitbucket.war --prefix gitbucket
