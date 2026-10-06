# DiamaneOS Emergency Location

**Not part of DiamaneOS.** An independent Advanced Mobile Location (AML)
implementation with lab tools.

- Not in the build or the product manifest; not a shipping or qualified
  emergency-location service. Production receiver profiles are empty.
- It does not implement VoLTE, VoWiFi, emergency-call routing or the modem's
  carrier-location mechanisms. Those stay separate from this optional AML path.

Android source location: `packages/apps/EmergencyLocation`.

- `src/`: trusted-event receiver, bounded GNSS collection, country profiles,
  message encoding and SMS/HTTPS delivery.
- `permissions/` and `sepolicy/`: independently scoped app permissions, domain
  and signing-key mapping; no dependency on the IMS broker's policy.
- `integration/`: preserved framework event-bridge patch and exact provenance.
- `lab/`: configurable host scenarios, loopback TLS tests and a separate
  zero-permission Android simulator.

See [source provenance](PROVENANCE.md) and [architecture](docs/architecture.md).

## Preserved verification

```sh
./tests/run-host-tests.sh
./lab/run matrix --countries all --output results.json
./lab/tls-smoke
```

- Needs Python 3 and JDK 17+; the TLS check also needs OpenSSL and a loopback
  socket. Nothing is installed or sent to a real recipient.
- [Lab instructions](lab/README.md) cover custom scenarios and building the
  standalone APK.
- Earlier source/API checks, synthetic tests and local TLS tests do not
  establish native telephony behavior or emergency-centre delivery. Open
  points: [integration](docs/integration.md) and
  [verification](docs/verification.md).
