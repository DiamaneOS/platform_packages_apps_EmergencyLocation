# Source provenance

Imported from [DiamaneOS/hardware_diamaneos_ims](https://github.com/DiamaneOS/hardware_diamaneos_ims/tree/15f7a6f8947486b76b2d348d6e02204b1d2bc62c)
at `15f7a6f8947486b76b2d348d6e02204b1d2bc62c`. Original development history and
attribution remain available at that immutable revision; existing copyright and
SPDX notices are preserved.

| Previous location | New location |
| --- | --- |
| `aml/src`, `aml/res`, `aml/permissions`, `aml/sepolicy` | `src`, `res`, `permissions`, `sepolicy` |
| `aml/Android.bp`, `aml/AndroidManifest.xml`, `aml/product.mk` | repository root |
| `aml/tests` | `tests/java` |
| `lab` except its IMS prerequisite checker | `lab` |
| AML profile documentation and framework patch/provenance | `docs` and `integration` |

The move changes build/script paths and gives the app an independent SELinux
signing-key tag. The AML runtime Java implementation is unchanged. IMS DCM,
EIMS data connections, the IMS broker, emergency APN tooling and its device
prerequisite checker remain in the IMS repository.

The framework patch is preserved apart from the package rename to
`de.diamaneos`; `patch_sha256` in its provenance record is that of the renamed
patch, and the host tests check it. Its original downstream commit may still
exist on historical or integration branches; inspect the selected framework
revision before applying it. Do not apply it twice or mistake its presence for
an enabled AML app.
