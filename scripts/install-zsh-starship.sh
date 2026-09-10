#!/usr/bin/env bash
#
# install-zsh-starship.sh
#
# Fetches and runs the canonical zsh + Starship installer from itdojo/qol.
# That script installs zsh, the Starship prompt, MesloLGS Nerd Font (+ Symbols
# Only), and the plugins zsh-autosuggestions, zsh-syntax-highlighting and
# zsh-completions, then writes ~/.config/starship.toml and a managed ~/.zshrc
# block.
#
# This repo deliberately does not carry its own copy. One installer, one place
# to fix it: https://github.com/itdojo/qol/blob/main/install_zsh_starship.sh
#
# Targets:  macOS, Debian/Ubuntu/Pi OS, Fedora/RHEL, Arch, Alpine, openSUSE
#
# Usage:  ./install-zsh-starship.sh
# Do not run as root.
#
# The upstream script is idempotent: rerunning it does not duplicate config.
# ‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒‒

set -eo pipefail

INSTALLER_URL="https://raw.githubusercontent.com/itdojo/qol/main/install_zsh_starship.sh"

# This whole script runs before the theme block it would otherwise source, so
# the STOP prefix is hand-written here to match every other error in the fleet.
die() {
    printf '\n▌ STOP   %s\n\n' "$1" >&2
    exit 1
}

# Guards are `if` blocks, not `test && die` — under `set -e` a false one-liner
# test is itself a failing command, which would exit before doing any work.
if [[ $EUID -eq 0 ]]; then
    die "Do not run as root. You'll be prompted for sudo if needed."
fi
if ! command -v curl >/dev/null 2>&1; then
    die "curl is required. Install it, then rerun."
fi

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

printf '\n▌ STEP   Fetching the installer from itdojo/qol...\n'
curl -fsSL "$INSTALLER_URL" -o "$tmp/install_zsh_starship.sh" \
    || die "Could not download the installer. Check your network, then rerun."

# A proxy or captive portal returns an HTML error page with a 200; running that
# through bash is how you get a screenful of syntax errors instead of a reason.
head -n 1 "$tmp/install_zsh_starship.sh" | grep -q '^#!' \
    || die "Downloaded file is not a shell script. Check your network, then rerun."

printf '▌ PASS   Installer downloaded.\n'
# Not `exec` — that would replace this shell and the EXIT trap would never run,
# leaving the temp dir behind.
bash "$tmp/install_zsh_starship.sh"
