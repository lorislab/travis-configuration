#!/bin/bash
set -ev

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"

# develop
if [[ ( $TRAVIS_BRANCH = develop ) && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn $MAVEN_CLI_OPTS com.gavinmogan:codacy-maven-plugin:coverage -DcoverageReportFile=target/site/jacoco/jacoco.xml -DapiToken=$CODACY_TOKEN
fi