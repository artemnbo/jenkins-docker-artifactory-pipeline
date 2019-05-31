FROM node:alpine

RUN apk add --update --no-cache git openssh ca-certificates openssl jq gettext xmlstarlet openjdk8 curl zip unzip bash

ARG USER_ID=1000
ARG GROUP_ID=1000
RUN addgroup -g $GROUP_ID jenkins-ci && \
    adduser -u $USER_ID -s /bin/sh -G jenkins-ci jenkins-ci -h /home/jenkins-ci -D
