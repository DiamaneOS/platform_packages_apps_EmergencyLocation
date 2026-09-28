#!/bin/sh
# SPDX-License-Identifier: Apache-2.0
# No phone, SMS or external network. Real TLS is a separate loopback-only command.
set -eu
cd "$(dirname "$0")/.."
JAVAC=${JAVA_HOME:+$JAVA_HOME/bin/}javac
JAVA=${JAVA_HOME:+$JAVA_HOME/bin/}java
mkdir -p tests/out/core
"$JAVAC" -Xlint:all -Werror -d tests/out/core \
    src/de/diamaneos/emergencylocation/AmlMessage.java \
    src/de/diamaneos/emergencylocation/AmlSession.java \
    src/de/diamaneos/emergencylocation/AmlProfile.java \
    src/de/diamaneos/emergencylocation/AmlProfiles.java \
    src/de/diamaneos/emergencylocation/HttpsSender.java \
    src/de/diamaneos/emergencylocation/TrustedEvent.java \
    src/de/diamaneos/emergencylocation/SmsPayload.java \
    tests/java/de/diamaneos/emergencylocation/*.java
"$JAVA" -cp tests/out/core de.diamaneos.emergencylocation.SimulationTest
"$JAVA" -cp tests/out/core de.diamaneos.emergencylocation.TransportTest
"$JAVA" -cp tests/out/core de.diamaneos.emergencylocation.CatalogTest
python3 -m unittest discover -s lab/tests -v
