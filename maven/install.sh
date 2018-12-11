#!/bin/bash
set -ev
mvn -s .scripts/maven/settings.xml -DskipTests=true -Dmaven.javadoc.skip=true -B verify
