# Toolchain notes — what the lab actually runs

All launchers live in `~/tools/bin/` (persistent home; system paths like
`/usr/bin` and `/opt` may be wiped by machine replacements).

- `rea` — wrapper around the `rea-agents` engine (6.8.0). The wrapper exports
  the engine wiring: `GHIDRA_INSTALL_DIR=~/tools/ghidra_12.1.4_PUBLIC`,
  `REA_JADX_MCP_JAR=~/tools/downloads/jadx-headless-mcp-0.7.1-all.jar`,
  `HOPPER_LAUNCHER_PATH=/opt/hopper/bin/Hopper` (rea's own PGP-verified Hopper
  install; if /opt is wiped, re-run `rea setup --yes --install-hopper`),
  `JAVA_HOME=~/tools/jdk21`. `rea doctor` → healthy: true.
  IDA stays unconfigured (licence).
- `pyinstxtractor` — v2.0 script (supports PyInstaller ≤ 6.19).
- `asar` — @electron/asar 4.3.2, node app at `~/tools/asar-app/`.
- `capa` — mandiant/capa 10.0.0 binary at `~/tools/capa/capa`.
- `diec` — Detect It Easy 3.10 console, extracted .deb at `~/tools/die/`; its
  `db` is symlinked beside the binary (`usr/bin/db -> ../lib/die/db`). Needs
  system packages `libqt5core5t64` + `libqt5script5` (the .deb itself cannot be
  apt-installed on Ubuntu 24.04 — it depends on the removed `qt5-default`).
- `ilspycmd` — ILSpy 8.2.0.7535 at `~/tools/ilspy/`; wrapper sets
  `DOTNET_ROOT=~/tools/dotnet` (.NET SDK 8.0.428) and
  `DOTNET_ROLL_FORWARD=Major` (the 8.2 tool targets net6.0). The latest
  ilspycmd needs a newer SDK than 8 — pin 8.2 or upgrade the SDK first.

## Environment gotchas

- `/tmp` may be a small tmpfs — big downloads/extractions overflow it. Set
  `TMPDIR=~/tools/tmp` for large work.
- Ubuntu 24.04 .deb payloads are zstd-compressed and `zstd` is not
  preinstalled; `dpkg-deb -x` can also fail on file-ownership changes in
  sandboxes. Workaround: `pip install --user --break-system-packages zstandard`
  to decompress, then `tar --no-same-owner`.
- The GitHub REST API can be rate-limited (403) from shared IPs — discover
  release assets via the web pages (`releases/expanded_assets/<tag>`) and
  download from `releases/download/...`.
- Verify a clone/install by its process's successful exit, never by a
  directory glimpsed mid-flight; after any machine restart, re-verify each
  tool on disk (`rea doctor`, `capa --version`, `diec --version`).
