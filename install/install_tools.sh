#!/usr/bin/env bash
# Krouchi_REA lab bootstrap — installs the reverse-engineering toolchain under ~/tools
# and the launchers under ~/tools/bin.
#
# Proven on Ubuntu 24.04 (the lab this repository documents). Other Linux
# distributions and WSL should work with the same steps; macOS users can follow
# the same layout with Homebrew equivalents.
#
# Notes from hard experience (see TOOLS_NOTES.md):
#  - /tmp can be a small tmpfs: big downloads overflow it. We set TMPDIR=~/tools/tmp.
#  - The GitHub REST API may be rate-limited from some IPs: this script reads
#    release pages, never the API.
#  - Ubuntu 24.04 .deb payloads are zstd-compressed; Detect It Easy is unpacked,
#    not apt-installed (its .deb depends on the removed qt5-default package).
set -euo pipefail

TOOLS="$HOME/tools"
BIN="$TOOLS/bin"
mkdir -p "$TOOLS/tmp" "$TOOLS/downloads" "$BIN"
export TMPDIR="$TOOLS/tmp"

echo "==> System packages"
sudo apt-get update
sudo apt-get install -y curl wget unzip git python3 python3-pip nodejs npm \
  libqt5core5t64 libqt5script5 || true
pip install --user --break-system-packages zstandard || true

echo "==> JDK 21 (for Ghidra / jadx)"
if [ ! -d "$TOOLS/jdk21" ]; then
  echo "Download a JDK 21 tarball (Temurin) and unpack it as $TOOLS/jdk21"
  echo "  https://adoptium.net/temurin/releases/?version=21"
fi
export JAVA_HOME="$TOOLS/jdk21"

echo "==> Ghidra 12.1.4"
if [ ! -d "$TOOLS/ghidra_12.1.4_PUBLIC" ]; then
  echo "Download ghidra_12.1.4_PUBLIC from the NSA Ghidra releases page and"
  echo "unpack it as $TOOLS/ghidra_12.1.4_PUBLIC"
  echo "  https://github.com/NationalSecurityAgency/ghidra/releases"
fi

echo "==> REA agents (npm package rea-agents)"
mkdir -p "$TOOLS/rea-app"
( cd "$TOOLS/rea-app" && npm init -y >/dev/null 2>&1 && npm install rea-agents@6.8.0 )

echo "==> jadx headless MCP jar"
echo "Place jadx-headless-mcp-0.7.1-all.jar in $TOOLS/downloads (from its release page)."

echo "==> capa 10.0.0 (Mandiant)"
mkdir -p "$TOOLS/capa"
echo "Download the capa Linux release binary into $TOOLS/capa/capa and chmod +x it."
echo "  https://github.com/mandiant/capa/releases"

echo "==> Detect It Easy 3.10 (console)"
mkdir -p "$TOOLS/die"
echo "Download the die .deb, decompress its zstd payload, unpack under $TOOLS/die,"
echo "and symlink the database beside the binary: usr/bin/db -> ../lib/die/db"

echo "==> .NET SDK 8 + ILSpy 8.2"
echo "Install the .NET 8 SDK as $TOOLS/dotnet and ilspycmd 8.2.0.7535 as $TOOLS/ilspy."
echo "Pin 8.2: newer ilspycmd builds need a newer SDK."

echo "==> pyinstxtractor + asar"
git clone --depth 1 https://github.com/extremecoders-re/pyinstxtractor "$TOOLS/pyinstxtractor" || true
mkdir -p "$TOOLS/asar-app"
( cd "$TOOLS/asar-app" && npm init -y >/dev/null 2>&1 && npm install @electron/asar@4.3.2 )

echo "==> Launchers"
cp "$(dirname "$0")/../tools/bin/"* "$BIN/"
chmod +x "$BIN/"*
grep -q 'tools/bin' "$HOME/.bashrc" || echo 'export PATH="$HOME/tools/bin:$PATH"' >> "$HOME/.bashrc"

echo "Done. Verify with:  rea doctor"
