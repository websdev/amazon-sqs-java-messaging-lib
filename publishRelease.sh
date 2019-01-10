#!/bin/bash

RELEASE_VERSION="$(./gradlew -q -PpublishReleaseVersion printVersion)"
REPOSITORY_VERSION_URL="http://nexus.digital.vistaprint.io/repository/public/com/webs/amazon-sqs-java-messaging-lib/$RELEASE_VERSION/springboot-service-lib-$RELEASE_VERSION.pom"
curl -s --head "$REPOSITORY_VERSION_URL" | grep -F "404 Not Found"
if [ "$?" -eq 0 ]; then
    ./gradlew -PpublishReleaseVersion -i publish
    exit $?
else
    echo 'Version not published because it was already published'
    exit 0
fi