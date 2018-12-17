#!/bin/bash
set -ev

export MAVEN_CLI_OPTS="-s .scripts/maven/settings.xml --batch-mode --errors --fail-at-end --show-version"
export BUILD_VERSION=$(mvn help:evaluate -N -Dexpression=project.version|grep -v '\[')

# deploy
if [[ ( $TRAVIS_BRANCH = master || $TRAVIS_BRANCH = develop) && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn $MAVEN_CLI_OPTS -Prelease -Dmaven.test.skip=true deploy

    git config --global user.email "lorislab@lorislab.org"
    git config --global user.name "lorislab"
    git tag $BUILD_VERSION -a -m "$BUILD_VERSION"
    git push --quiet https://$GITHUB_TOKEN@github.com/$TRAVIS_REPO_SLUG $BUILD_VERSION > /dev/null 2>&1
fi
