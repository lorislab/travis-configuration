#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

docker login -u="$QUAYIO_DOCKER_USERNAME" -p="$QUAYIO_DOCKER_PASSWORD" quay.io
mvn $MAVEN_CLI_OPTS deploy -Pdocker-push

