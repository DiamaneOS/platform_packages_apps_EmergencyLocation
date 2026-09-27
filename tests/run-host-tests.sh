#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# No phone, SMS or external network. Real TLS is a separate loopback-only command.
set -eu
cd "$(dirname "$0")/.."
JAVAC=${JAVA_HOME:+$JAVA_HOME/bin/}javac
JAVA=${JAVA_HOME:+$JAVA_HOME/bin/}java
mkdir -p tests/out/core
"$JAVAC" -Xlint:all -Werror -d tests/out/core \
    src/org/diamaneos/emergencylocation/AmlMessage.java \
    src/org/diamaneos/emergencylocation/AmlSession.java \
    src/org/diamaneos/emergencylocation/AmlProfile.java \
    src/org/diamaneos/emergencylocation/AmlProfiles.java \
    src/org/diamaneos/emergencylocation/HttpsSender.java \
    src/org/diamaneos/emergencylocation/TrustedEvent.java \
    src/org/diamaneos/emergencylocation/SmsPayload.java \
    tests/java/org/diamaneos/emergencylocation/*.java
"$JAVA" -cp tests/out/core org.diamaneos.emergencylocation.SimulationTest
"$JAVA" -cp tests/out/core org.diamaneos.emergencylocation.TransportTest
"$JAVA" -cp tests/out/core org.diamaneos.emergencylocation.CatalogTest
python3 -m unittest discover -s lab/tests -v
