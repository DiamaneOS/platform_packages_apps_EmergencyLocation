# Architecture and boundaries

The app has its own UID and SELinux domain. It receives protected, explicit
system-server emergency-call/SMS events and validates sender identity, event age,
number and phone context. It cannot place, route or cancel calls and has no QRTR
or IMS daemon interface.

A read-only country catalogue selects the recipient and delivery policy. The
event cannot supply a recipient or URL. Collection uses bounded GNSS requests
with request-scoped location bypass, without changing the global location switch.
The existing implementation is GNSS-only; network/fused positioning is unfinished.

Messages follow the implemented AML SMS/HTTPS formats. HTTPS retains platform
certificate/hostname verification and rejects redirects. Missing metadata,
no-SIM HTTPS and roaming SMS require explicit receiver-profile support. The
catalogue rejects unknown fields, ambiguity and recursive SMS routes.

Queues, collection slots and wakelocks are bounded. Expired queued deliveries are
removed, and HTTPS checks delivery eligibility after connection setup before
writing location bytes. Java resolver cancellation is not a hard thread deadline.
Coordinates, identifiers and message bodies are excluded from routine logs.

The lab builds shared policy/encoding logic into a different zero-permission
package. It has no production activation hook, privileged instrumentation target,
real SMS sender or live recipient configuration. Its results are simulation
results, not proof of emergency-service reception.

The app is not part of the build. No Google-dependent backend has been
selected, and no production region is configured. Keep ordinary emergency calling and carrier
location independent of whether this optional app exists or works.
