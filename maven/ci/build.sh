#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# build
mvn $MAVEN_CLI_OPTS -Ptest-unit,release,docker clean package

