# Reverse Engineering & NSA Library

## What this skill holds

The local reverse-engineering arsenal for the user Krouchi Abderrazak, completed 2026-11-22: the working REA toolchain plus a 50-repo reference library (`~/workspace/github_library/`, manifest `سجل_التثبيت.md` there). Use it whenever a shipped program must be studied from evidence, or NSA/Ghidra-ecosystem material is needed.

## Working toolchain (in ~/tools/bin, verified healthy 2026-11-18)

- `rea` (rea-agents 6.8.0) wrapping Ghidra 12.1.4 (`~/tools/ghidra_12.1.4_PUBLIC`), JADX headless MCP jar, Hopper launcher, JDK 21. `rea doctor` → healthy. IDA unconfigured (licence).
- Helpers: `pyinstxtractor` (PyInstaller ≤ 6.19), `asar` (Electron), `capa` 10.0.0, `diec` (Detect It Easy 3.10), `ilspycmd` 8.2 (.NET; DOTNET_ROOT=~/tools/dotnet, roll-forward Major).
- Gotchas (also in ~/TOOLS.md): set TMPDIR=~/tools/tmp for big work (/tmp is a 512 MB tmpfs); GitHub REST API is rate-limited from this VM — prefer web pages or the search API sparingly; .deb payloads are zstd — decompress via python zstandard + tar --no-same-owner.

## Library — RE section (~/workspace/github_library/)

- `ghidra` (438M, NSA official source), `x64dbg`, `ImHex`, `ghidra-mcp` (200+ Ghidra tools for AI agents — the bridge between this library and agent-driven analysis), `Ghidrathon` (Mandiant FLARE Python 3 in Ghidra), lists: `awesome-re-morluto` (by REA's author), `awesome-re-alphaSeclab`, `reverse-engineering-wtsx`.

## Library — NSA section (17 of the org's 87 repos)

`SIMP` (system hardening/automation), `lemongraph`, `datawave` (secure ingest/query over Accumulo), `skills-service` + `skills-client` (SkillTree micro-learning), `enigma-simulator`, `timely`, `DCP`, `emissary` (P2P workflows), `lemongrenade`, `ghidra-data` (Ghidra support archives), `fractalrabbit`, `MADCert` (certificate authorities), `kmyth`, `XORSATFilter`, `qgis-latlontools-plugin`, `qgis-shapetools-plugin`. Also remember: Apache NiFi and Apache Accumulo were born at NSA and donated to Apache — they live under Apache, not the NSA org.

## Operating lessons (hard-won, 2026-11-22)

- **Verify a clone by its process's successful exit, never by a directory glimpsed mid-flight**: a `timeout`-killed git clone deletes its own target directory on exit — a repo can check "present" during the download and vanish at the deadline (this bit skills-service twice; it needed a 1500 s window). Long clones get generous timeouts, and completeness claims wait for the batch's own OK lines.
- Count the library by name against the manifest list, not by directory totals alone.

## Rules

- Evidence first: ask the binary to describe itself, read what is saved before experimenting, rebuild only where new evidence proves a difference.
- Original code only in rebuilds — study for behaviour and specs, never copy shipped code into the user's products.
