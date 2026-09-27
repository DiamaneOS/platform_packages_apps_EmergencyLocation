# Future integration

Development is deferred; these steps preserve a future path, not an instruction
to enable the app in current builds.

1. Check out this repository at `packages/apps/EmergencyLocation` only when AML
   work resumes. Retain ordinary emergency calling and carrier location separately.
2. Inspect the framework source. The patch in `integration/` is bound to its
   provenance JSON and supplies trusted call/SMS events. Rebase and review it if
   necessary; never apply it twice. Build and run its native authorization tests.
3. Include `board.mk` for the app's own system_ext policy and signing-key mapping.
   It does not require the IMS repository's signing tag or policy directories.
4. Supply verified `res/xml/aml_profiles.xml` configuration. Validate with
   `lab/run validate-profiles`; schema validity is not receiver interoperability.
5. Only after qualification, set `DIAMANEOS_AML_QUALIFIED_PROFILE=true` and include
   `product.mk`. This selects the app and its permission/sysconfig modules.
6. Verify actual grants, SELinux enforcement, event authentication, before-unlock
   operation, location bypass scope, cleanup and transport behavior. Native
   integration and receiver/call correlation remain unverified.

The retained standalone lab APK and host checks can run without including this
application or its framework patch in the OS. No manifest or product automatically
selects AML from this repository.
