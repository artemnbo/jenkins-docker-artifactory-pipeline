FROM node:alpine

RUN apk add --update --no-cache git openssh ca-certificates openssl jq gettext xmlstarlet openjdk8 curl zip unzip bash

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN addgroup -g $GROUP_ID jenkins-ci && \
    adduser -u $USER_ID -s /bin/sh -G jenkins-ci jenkins-ci -h /home/jenkins-ci -D

RUN cd && \
     curl --insecure -o ./sonarscanner.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip && \
     unzip -q sonarscanner.zip && \
     mv sonar-scanner-3.2.0.1227-linux /opt/sonar-scanner && \
     rm sonarscanner.zip

ENV SONAR_RUNNER_HOME=/opt/sonar-scanner
ENV PATH $PATH:/opt/sonar-scanner/bin
RUN sed -i 's/use_embedded_jre=true/use_embedded_jre=false/g' /opt/sonar-scanner/bin/sonar-scanner