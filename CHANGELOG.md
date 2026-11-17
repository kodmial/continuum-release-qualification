# Changelog

## [0.1.3] - 2026-11-17

- Qualified release published end to end by the opt-in Continuum release control
  plane: one exact source commit, two declared targets, deterministic bytes for
  both archives, sign/verify, a complete digest-checked draft, publication, and
  a downstream publisher record under one idempotency key.

## [0.1.2] - 2026-11-17

- Aborted qualification attempt. Both targets built and the draft was created,
  but a fresh run rebuilt the Windows archive with different bytes, so the
  engine refused to attach a second version of the same asset. The draft was
  deleted and the Windows packaging made byte-reproducible before 0.1.3.

## [0.1.1] - 2026-11-17

- Earlier qualification attempt used to exercise the opt-in caller, the exact
  source pin, and the release-PR path before the release engine was qualified.
