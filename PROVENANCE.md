# Source provenance

Imported from [DiamaneOS/hardware_diamaneos_ims](https://github.com/DiamaneOS/hardware_diamaneos_ims/tree/406ddbb17c0d998e495c99b9c4dda32f38768d2c)
at `406ddbb17c0d998e495c99b9c4dda32f38768d2c`. Original development history and
attribution remain available at that immutable revision. Existing copyright and
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
`de.diamaneos`. `patch_sha256` in its provenance record is that of the renamed
patch, and the host tests check it. Its original downstream commit may exist on
other framework branches, so inspect the selected framework revision before
applying it. Do not apply it twice or mistake its presence for
an enabled AML app.
