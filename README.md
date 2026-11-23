# REA_DZ — Reverse-Engineering Workbench

**An original, evidence-first reverse-engineering lab**: the methodology, the
tool bootstrap, and the study reports behind a family of clean-room rebuilds
of Algerian school-administration software.

Built and maintained by **Krouchi Abderrazak** — director of Lycée Belkacem
Mohamed, Tlemcen, Algeria.

---

## What is in here

| Part | What it holds |
|---|---|
| [`studies/`](studies/INDEX.md) | Study reports written from the binaries themselves — what each program does, how that was verified, and what remains unproven |
| [`skills/rea/`](skills/rea/SKILL.md) | The REA working method: ask the binary to describe itself first, follow the evidence, rebuild only where new evidence proves a difference |
| [`skills/re-nsa-library/`](skills/re-nsa-library/SKILL.md) | The reverse-engineering & NSA-tooling library notes (Ghidra practice, verification lessons) |
| [`install/`](install/install_tools.sh) | One bootstrap script that rebuilds the whole lab on a fresh machine, plus the hard-won [toolchain notes](install/TOOLS_NOTES.md) |
| [`tools/bin/`](tools/bin/) | The launchers the lab runs on (`rea`, `capa`, `diec`, `ilspycmd`, `pyinstxtractor`, `asar`) |

## The toolchain

Ghidra 12.1.4 · REA agents 6.8.0 · Hopper · jadx (headless MCP) · ILSpy 8.2 ·
mandiant/capa 10.0 · Detect It Easy 3.10 · pyinstxtractor · @electron/asar —
all wired under `~/tools` so the lab survives machine replacements.

```bash
bash install/install_tools.sh   # Ubuntu 24.04 / WSL
rea doctor                      # → healthy: true
```

## Principles

1. **Evidence first.** A claim about a program is worth exactly the artifact
   that proves it — a string, a resource, a trace, a screenshot.
2. **Ask the binary to describe itself** before experimenting on it.
3. **Clean-room rebuilds.** Studies describe behaviour; the software built
   from them is original code. Nothing here reproduces another program's code.
4. **Say what was not tested.** Every report separates the verified from the
   assumed.

## Studies

Start with the [index](studies/INDEX.md) — the full sweep
([REA_ALL_PROGRAMS.md](studies/REA_ALL_PROGRAMS.md)) compares every studied
program: timetabling (asctime DZ, AliSchool, Moustachar), exam-centre
management, certificates, grants, and the RGF.

## Credits

The tools are other people's excellent work — Ghidra (NSA), capa (Mandiant),
Detect It Easy (horsicq), ILSpy, jadx, pyinstxtractor, @electron/asar, and
the rea-agents engine. They are *installed* by the bootstrap script, never
redistributed here. See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

The methodology, scripts, launchers and study reports in this repository are
original work, released under the [MIT License](LICENSE).

---

[النسخة العربية](README.ar.md)
