ARG VERSION
FROM nginx:${VERSION}

COPY html/index.html /usr/share/nginx/html/index.html
COPY html/50x.html /usr/share/nginx/html/50x.html
COPY tmpl.server.conf /tmp/tmpl.server.conf

ENV DOCKERIZE_VERSION=v0.6.1
RUN set -eux \
    && : "Install dockerize" \
    && wget -O dockerize.tar.gz "https://github.com/jwilder/dockerize/releases/download/${DOCKERIZE_VERSION}/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz" \
    && tar -xzvf dockerize.tar.gz -C /usr/local/bin \
    && rm dockerize.tar.gz

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf_bk

ENTRYPOINT dockerize -template /tmp/tmpl.server.conf:/etc/nginx/conf.d/server.conf \
  nginx-debug -g 'daemon off;'
