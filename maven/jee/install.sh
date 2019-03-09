#!/bin/bash
set -e

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

mvn $MAVEN_CLI_OPTS -DskipTests=true -Dmaven.javadoc.skip=true -B
