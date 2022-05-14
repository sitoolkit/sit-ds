ARG VERSION
FROM jenkins/jenkins:${VERSION}

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false \
  -Dhudson.model.DirectoryBrowserSupport.CSP=\"default-src 'none'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self';\"" \
  JENKINS_OPTS=--prefix=/jenkins

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY *.groovy /usr/share/jenkins/ref/init.groovy.d/

RUN set -eux \
  && usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

USER root

RUN curl -sL https://deb.nodesource.com/setup_14.x
RUN apt-get update
RUN apt-get -y install nodejs
RUN apt-get -y install npm
RUN npm install -g newman