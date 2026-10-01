# Verification and open points

The host suite tests the shared catalogue/parser, identity policy, location
session, event predicates, message encoders, SMS packing and HTTPS behavior. The
lab adds configurable synthetic country cases and real host TLS on loopback.
The standalone APK is built without permissions and is not the privileged app.

The repository split preserves the runtime implementation and existing evidence.
Host/API compilation and simulations are not native acceptance. Still open:

- Verified regional destinations, transport formats, identity/correlation and
  roaming/no-SIM requirements. The production profile file remains empty.
- Location beyond GNSS, receiver-specific interoperability and field requirements.
- Full Android/framework/SELinux builds and actual permission/caller isolation.
- Before-unlock, process death, deadline, DNS-stall and wakelock tests on Android.
- End-to-end emergency recipient receipt and correlation with the actual call.

AML is not part of the build. VoLTE, VoWiFi, ordinary emergency calls and existing
carrier emergency-location work continue in their own components. Their test
results must not be reported as AML results, or vice versa.
