# DiamaneOS Emergency Location

**Development deferred.** This repository preserves the independent Advanced
Mobile Location (AML) implementation and lab tools for later work. It is not a
shipping or qualified emergency-location service. Production receiver profiles
are empty, and the component should remain outside the active product manifest.

Android source location: `packages/apps/EmergencyLocation`.

- `src/`: trusted-event receiver, bounded GNSS collection, country profiles,
  message encoding and SMS/HTTPS delivery.
- `permissions/` and `sepolicy/`: independently scoped app permissions, domain
  and signing-key mapping; no dependency on the IMS broker's policy.
- `integration/`: preserved framework event-bridge patch and exact provenance.
- `lab/`: configurable host scenarios, loopback TLS tests and a separate
  zero-permission Android simulator.

The app does not implement VoLTE, VoWiFi, emergency-call routing or the modem's
carrier-location mechanisms. Those remain separate from this optional AML path.
See [source provenance](PROVENANCE.md) and [architecture](docs/architecture.md).

## Preserved verification

```sh
./tests/run-host-tests.sh
./lab/run matrix --countries all --output results.json
./lab/tls-smoke
```

Requires Python 3 and JDK 17+. The TLS check additionally uses OpenSSL and a
loopback socket. [Lab instructions](lab/README.md) cover custom scenarios and
building the standalone APK. Nothing is installed or sent to a real recipient.

Prior source/API checks, synthetic tests and local TLS tests do not establish
native telephony behavior or emergency-centre delivery. The remaining work is
listed in [integration](docs/integration.md) and [verification](docs/verification.md).
