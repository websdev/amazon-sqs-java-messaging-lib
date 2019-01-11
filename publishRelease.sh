#!/bin/bash

RELEASE_VERSION="$(grep -F "<version>" pom.xml | head -n 1 | sed 's/<[^>]*>//g' | sed 's/ //g')"
REPOSITORY_VERSION_URL="http://nexus.digital.vistaprint.io/repository/public/com/webs/amazon-sqs-java-messaging-lib/$RELEASE_VERSION/amazon-sqs-java-messaging-lib-$RELEASE_VERSION.pom"
curl -s --head "$REPOSITORY_VERSION_URL" | grep -F "404 Not Found"
if [ "$?" -eq 0 ]; then
    mvn deploy -DskipTests -e --global-settings ./settings.xml
    exit $?
else
    echo 'Version not published because it was already published'
    exit 0
fi