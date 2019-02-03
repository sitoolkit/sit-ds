FROM jenkins:alpine

ENV JAVA_OPTS=-Djenkins.install.runSetupWizard=false \
    JENKINS_OPTS=--prefix=/jenkins

USER root

RUN set -eux \
    && apk update \
    && apk upgrade \
    && rm -rf /var/cache/apk/* \
    && : "Update jenkins.war" \
    && rm usr/share/jenkins/jenkins.war \
    && curl -fsSL http://mirrors.jenkins.io/war-stable/latest/jenkins.war -o /usr/share/jenkins/jenkins.war

USER jenkins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
COPY config-ldap.groovy /usr/share/jenkins/ref/init.groovy.d

RUN set -eux \
  && dos2unix /usr/share/jenkins/ref/plugins.txt \
  && usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
