#!/bin/bash

# master
if [[ $TRAVIS_BRANCH = master && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn -s .scripts/maven/settings.xml clean install
    mvn -s .scripts/maven/settings.xml deploy
fi

# develop
if [[ $TRAVIS_BRANCH = develop && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn -s .scripts/maven/settings.xml clean install
    mvn -s .scripts/maven/settings.xml deploy
fi

# other
if [[ $TRAVIS_BRANCH != master && $TRAVIS_BRANCH != develop && $TRAVIS_PULL_REQUEST = false ]]; then
    mvn -s .scripts/maven/settings.xml clean install
fi
