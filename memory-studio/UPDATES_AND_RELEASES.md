# Memory Studio — Windows updates and license-aware releases

Status: release protocol prepared; desktop updater NOT yet installed or tested. No public installer is published by this repository.

## Architecture
- Website (GitHub Pages): public release metadata and documentation only; no Stripe secrets or license database.
- Windows desktop app: on launch and every 24 hours while running, fetch `https://clearmyrecord.github.io/matthew-tunstall-website/memory-studio/releases/stable.json` over HTTPS with a short timeout. Manual **Check for updates** option. Never send photos, videos, projects, device identifiers, or license tokens to the static website.
- Manifest `available=false` means no update is offered. When available, require a valid semantic version newer than the installed version, Windows platform compatibility, HTTPS artifact URL from an explicitly allowlisted release host, SHA-256 match and verified Authenticode signature from the pinned publisher. Never execute a manifest-provided command.
- Download to a temporary file, check sufficient disk space, verify checksum and publisher signature, prompt before installing, close active renders gracefully, and install using the desktop framework's supported signed update mechanism. Retain previous installer for recovery. Do not install unsigned binaries.
- Store user projects/media in user-selected locations or application data, NEVER inside replaceable installation directories. Back up settings before migrations; keep migrations backward-compatible and test downgrade/restore.
- Rollout: internal QA -> beta -> stable; support rollback by issuing a new higher version containing the previous working build (do not downgrade database blindly). Update manifest only after binaries are signed and independently verified.
- One common signed binary with locally enforced My Life, Family Legacy and Creator Studio entitlements; never put Stripe secrets in the app. Paid entitlement issued by trusted backend after verified Stripe webhook; account-free license activation and offline grace need secure implementation. Purchases and entitlement issuance are NOT live.
- Never tie maintenance/security updates to a new payment. Do not change purchased edition during updates.
- GitHub Pages is not a secure license-activation backend. Stripe Checkout, webhooks, license issuance/revocation and support require a separately deployed server and explicit merchant connection.

## Release gate
1. Obtain working Windows v37 source, runtime/framework, packaging scripts, and actual test installer.
2. Identify Electron / Python / .NET / other framework and choose supported updater.
3. Add update client, manual update UI, signature validation, install/restart flow, and automated tests.
4. Configure publisher code-signing certificate and CI secrets outside repository.
5. Publish signed internal test build; verify fresh install, upgrade, interrupted download, offline mode, wrong signature, rollback/recovery, and preservation of projects.
6. Publish signed stable release artifact and SHA-256, then update stable.json.
7. Only then describe automatic updates as available on the marketing website.

Do not upload private media, paid license keys, production Stripe secrets or unsigned executables to public GitHub.
