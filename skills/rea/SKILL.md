# Reverse Engineer Anything with REA

## When to use REA

- Use REA when a claim depends on a shipped binary or package, decompilation, requested runtime evidence, or comparison with behavior not established by available source.
- Do not use REA for ordinary analysis of a complete source repository. Use normal repository tools instead.
- Ask the user for the target when they name a feature or behavior without supplying a binary, package, directory, or URL.

## Run REA from the command line

- Run the installed CLI at `~/workspace/custom-skills/rea/node_modules/.bin/rea`.
- Check readiness with `rea doctor` before a native analysis. Static JavaScript analysis needs no native engine.
- Pass absolute paths to every target. Run acquisition commands from a trusted directory outside the target project.
- Prefer `--json` and read the returned Evidence record, including its limitations and unknowns, with the same care as the findings.
- Run commands with `muse.exec` and keep each call bounded to one target and one question.
- List the full command surface with `rea --help` when the route below does not cover the target.
- Do not install Hopper, Ghidra, IDA, Kuna, or any other analysis engine without the user asking. None is installed here, so native decompilation is unavailable until the user provides one.

## Route the target first

- ASAR or extracted JavaScript or Electron tree: `rea analyze-javascript-application /absolute/path/to/app --json`.
- Archive or package member inventory such as ZIP, APK, IPA, MSIX, AppX, DMG, or a PyInstaller executable: `rea inspect-artifact /absolute/path/to/file --json`.
- Android APK code, classes, methods, or incoming references: `rea inspect-android-package /absolute/path/to/app.apk --json`, then the focused Android commands when they fit.
- Managed PE or CLI assembly: `rea inspect-managed-artifact /absolute/path/to/file --json`.
- Firmware image: `rea inspect-firmware-regions /absolute/path/to/image --json`. Extract only into a new absolute output directory the user chose.
- One native function as code: `rea decompile --procedure <address-or-name> /absolute/path/to/binary --json` or `rea function --procedure <address-or-name> /absolute/path/to/binary --json`.
- Two versions of the same target: `rea compare /absolute/path/to/evidence-a.json /absolute/path/to/evidence-b.json --json`.
- A live web page bundle: `rea analyze-web-bundle <url> --json`.
- The upstream references in `references/` describe the same workflows with MCP tool names. In Muse those names map to CLI subcommands with dashes, such as `analyze_javascript_application` to `analyze-javascript-application`.

## Read the Evidence and report honestly

- Quote the Evidence record for every claim, including its evidence id, the subject digest, and the provider.
- Report limitations and unknowns alongside the findings. A missing finding does not establish absence.
- Distinguish static facts from observed runtime behavior. Static inspection does not observe execution.
- When a reconstruction is the goal, build it from the Evidence and test it against the target behavior. Say which parts the Evidence supports and which parts are inferred.
- If a command fails, read its error and the recovery guide in `references/connection-and-recovery.md` before retrying. Do not repeat an unchanged call that timed out.

## Keep the installation current

- Update the package with `npm update rea-agents` inside `~/workspace/custom-skills/rea`.
- After an update, run `rea --help` and `rea doctor` again and refresh `references/` from upstream main at `https://github.com/morluto/rea`.
- A newer release may describe capabilities absent from the installed version. Trust the installed CLI over this skill when they disagree.
