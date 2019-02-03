FROM sonarqube

ENV DOCKERIZE_VERSION=v0.6.1

USER root

RUN set -eux \
    && : "Install dockerize" \
    && curl -sSL -o dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

USER sonarqube

WORKDIR $SONARQUBE_HOME

COPY tmpl.sonar.properties /opt/sonarqube/conf

ENTRYPOINT dockerize -template /opt/sonarqube/conf/tmpl.sonar.properties:/opt/sonarqube/conf/sonar.properties -wait tcp://dbms:${DB_PORT} ./bin/run.sh -Dsonar.web.context=/sonarqube
