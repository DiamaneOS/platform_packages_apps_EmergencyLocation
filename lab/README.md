> AML is not part of the build. These tools exercise the AML code; no production
> receiver profile is enabled.

# Emergency connectivity lab

These tools run locally. They place no calls, send no real SMS, contact no
emergency recipients and do not establish worldwide service coverage.

- Production AML is disabled: no verified regional profiles are supplied and
  native integration is not qualified.
- Country configuration and lab simulation are separate from
  carrier/emergency-centre acceptance.

## Host scenarios

Needs Python 3 and JDK 17 or newer (`JAVA_HOME` may select the JDK):

```sh
./lab/run run lab/scenarios/domestic.properties
./lab/run matrix --countries de,fr,gb,us --output results.json
./lab/run matrix --countries all --output all-countries.json
python3 -m unittest discover -s lab/tests -v
./tests/run-host-tests.sh
```

- `all` uses the JDK's ISO country list. Each country runs the same synthetic
  scenarios: this checks country-independent routing behavior, not a database
  of real national emergency services.
- Reports distinguish PASS (an explicit expected outcome matched), FAIL and
  OBSERVED (no expectation supplied).
- Output files are created exclusively; choose a new path rather than
  overwriting earlier evidence.

To add a case, copy a `.properties` scenario. Supported fields:

| Field | Meaning / default |
| --- | --- |
| `name` | Report label |
| `country`, `profile_country` | Visited and configured country; `de`, same country |
| `number`, `profile_numbers` | Synthetic activation number and accepted comma-separated numbers; `112`, same number |
| `source`, `profile_sources` | CALL or SMS; CALL, CALL/SMS |
| `has_sim`, `home_country` | Simulated subscription state; true, visited country |
| `sender_uid`, `event_age_ms` | Synthetic sender and event age; 1000, 0 |
| `profile_expired`, `delivery_expired` | Expiry failures; false |
| `fix` | good, none, stale, mock, future or inaccurate |
| `https` | 200, 204, 400, 503, redirect, tls_error, offline or late_connect |
| `allow_roaming_sms`, `allow_no_sim_https`, `allow_missing_metadata` | Explicit profile flags; false |
| `https_imsi`, `sms_packing` | full/partial, gsm7-lsb/gsm7-msb-legacy |
| `expected_decision`, `expected_sms`, `expected_https`, `expected_fix` | Assertions against reported outcomes |

- `other` is accepted for profile/home country as a deliberate mismatch.
- A negative event age tests a future timestamp.
- All phone identifiers, coordinates and destinations are fixed synthetic
  fixtures; input cannot select a real SMS or HTTPS recipient. Actual receiver
  acceptance is always unverified.
- The harness runs the production catalogue, identity policy, freshness logic,
  location session, message encoders, SMS packing and HTTPS sender, with
  in-memory transport and metadata. It does not run Android's telephony/radio,
  GNSS driver, system-server event dispatch or production app scheduling.

## Standalone Android APK

Build on a workstation with Android SDK platform 36/build-tools 36.0.0 and a
JDK:

```sh
export ANDROID_SDK_ROOT=/path/to/android-sdk
./lab/build-apk
```

- Output: `lab/out/apk/diamaneos-aml-lab.apk` and `artifact.json` with its
  hash. Needs Android 15/API 35 or newer.
- A separate package with a disposable lab signing key, never the platform or
  production release key.
- Requests **zero permissions**, has no services/receivers or instrumentation
  target, and cannot activate production AML. Production build files include
  no lab code.
- The script creates a local test keystore under ignored `lab/out/`. Keep that
  key to update an installed lab APK; it is not suitable for production.
- The script builds and checks the APK but never installs or launches it.

Install it yourself, selecting the device explicitly:

```sh
adb -s "$ANDROID_SERIAL" install -r lab/out/apk/diamaneos-aml-lab.apk
```

Open **DiamaneOS AML Lab**, choose a two-letter country code or `all`, and run
the bundled cases. **Open scenario file** loads more `.properties` files through
Android's document picker, without a rebuild. The report appears on screen. The
app never reads the phone's location, SIM identity or real carrier state.

## Real TLS, entirely on loopback

```sh
./lab/tls-smoke
```

- Needs OpenSSL and permission to bind a local loopback socket.
- Uses the actual HTTPS sender with a temporary TLS receiver and a private test
  truststore. Checks certificate rejection, successful trusted delivery,
  refusal to follow redirects and handling of HTTP errors.
- Only `127.0.0.1` is permitted. Certificates and keys are temporary; no global
  trust store or TLS verifier is changed.
- It does not test a real emergency recipient or Android's networking stack.

## Regional profiles and native integration

```sh
./lab/run validate-profiles /path/to/aml_profiles.xml
```

- Uses the same bounded catalogue and field parser as production: up to 1,024
  profiles, indexed by country, rejecting ambiguity and recursion. XML
  DTD/entities/external access are disabled.
- Success means schema validity, not receiver authenticity or
  interoperability. Expired profiles fail. Zero profiles means no configured
  recipients.
- Populate the existing `res/xml/aml_profiles.xml` from verified receiver
  documentation; formats and routing policies already supported need no Java
  change.
- IMS device prerequisites are checked separately in
  [hardware_diamaneos_ims](https://github.com/DiamaneOS/hardware_diamaneos_ims).
  They are not a dependency of this app's host or lab tests.

A separate enforcing integration build must retain evidence for:

- the framework's native event tests, receiver spoof rejection, permissions,
  package/domain separation, before-unlock behavior and process recovery;
- DCM/modem interoperability, both SIMs, VoLTE/VoWiFi registration, normal peer
  calls/SMS, audio, handovers and radio/network loss;
- country/carrier receiver configuration, emergency fallback/callback/RTT and
  call/location correlation through an arranged lab/operator test path;
- GNSS performance and a separately reviewed network/fused provider if
  required; DNS stalls, delivery cancellation, wakelock cleanup and SMS
  submission results.

No generic test phone number or live AML destination is embedded. New receiver
formats, authentication mechanisms or unsupported modem interfaces may still
need implementation work; changing a country code cannot guarantee arbitrary
worldwide interoperability.
