# Continuum release qualification consumer

An isolated, disposable consumer repository used to qualify the opt-in
Continuum application-release control plane end to end. It contains no product
code: the build targets package a small text fixture.

The repository starts with **no** release configuration, so the installed
caller is a verified green no-op. A later change adds `release.hooks` and cuts a
real release.
