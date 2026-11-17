# Changelog

## [0.1.6] - 2026-11-17

- Final qualification release on the audited engine snapshot: one exact commit,
  two deterministic targets, sign/verify, complete digest-checked draft,
  publication, and one downstream publisher record.
- Duplicate tag and dispatch events are green already-published no-ops with no
  second tag, release, asset, or publisher call.
- A refused plan now prints the failing stage and its reason in the job log.

## [0.1.5] - 2026-11-17

- Final qualification release on the receipt-reconciliation engine: published
  from one exact commit with two deterministic targets, sign/verify, a complete
  digest-checked draft, publication and one downstream publisher record.
- Duplicate tag and dispatch events reconcile the published receipt with the
  rebuild, report an already-published no-op, and add no second tag, release or
  publisher call.

## [0.1.4] - 2026-11-17

- Qualification release on the final engine: one exact source commit, two
  declared targets, deterministic archives, sign/verify, complete digest-checked
  draft, publication, and one downstream publisher record.
- A duplicate event re-runs the plan and build, reconciles the rebuilt receipts
  with the published receipt by release content, and reports an
  already-published no-op without a second tag, release, or publisher call.

## [0.1.3] - 2026-11-17

- First fully published qualification release: both declared targets built from
  one exact commit, signed and verified, uploaded to a draft, digest-verified,
  then published with a downstream publisher record.
- A duplicate event exposed a reconciliation bug: the stored receipt named the
  release asset path while the rebuild named its workspace path, so identical
  bytes were refused as different. The engine now compares release content.


## [0.1.2] - 2026-11-17

- Aborted qualification attempt. Both targets built and the draft was created,
  but a fresh run rebuilt the Windows archive with different bytes, so the
  engine refused to attach a second version of the same asset. The draft was
  deleted and the Windows packaging made byte-reproducible before 0.1.3.

## [0.1.1] - 2026-11-17

- Earlier qualification attempt used to exercise the opt-in caller, the exact
  source pin, and the release-PR path before the release engine was qualified.
