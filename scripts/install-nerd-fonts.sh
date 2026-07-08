#!/usr/bin/env bash
#
# Install a selection of Nerd Fonts for the current user.
# Fonts land in ~/.local/share/fonts (the modern XDG location; ~/.fonts is deprecated).
# Check https://github.com/ryanoasis/nerd-fonts/releases for the newest release.

set -euo pipefail

NF_VERSION="v3.4.0"
BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${NF_VERSION}"
FONTS=("Meslo" "NerdFontsSymbolsOnly" "FiraCode" "Hack" "SourceCodePro")
TMP_DIR="$(mktemp -d)"
FONT_DIR="${HOME}/.local/share/fonts"

trap 'rm -rf "$TMP_DIR"' EXIT

if ! command -v fc-cache >/dev/null 2>&1; then
    echo "Installing fontconfig..."
    sudo apt-get update && sudo apt-get install -y fontconfig
fi

if ! command -v unzip >/dev/null 2>&1; then
    echo "Installing unzip..."
    sudo apt-get install -y unzip
fi

mkdir -p "$FONT_DIR"

for FONT in "${FONTS[@]}"; do
    echo "Installing ${FONT}..."
    if ! wget -q "${BASE_URL}/${FONT}.zip" -O "${TMP_DIR}/${FONT}.zip"; then
        echo "ERROR: Failed to download ${FONT}.zip -- skipping." >&2
        continue
    fi
    # Unzip each font family into its own folder to keep FONT_DIR tidy
    unzip -oq "${TMP_DIR}/${FONT}.zip" -d "${FONT_DIR}/${FONT}"
    # Global install (all users) instead:
    # sudo unzip -oq "${TMP_DIR}/${FONT}.zip" -d "/usr/share/fonts/truetype/${FONT}"
done

# For ALL Nerd fonts (Be careful! HUGE!!! >3.2GB download)
# wget -q "https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/${NF_VERSION}.zip" -O "${TMP_DIR}/${NF_VERSION}.zip"
# unzip -oq "${TMP_DIR}/${NF_VERSION}.zip" -d "$FONT_DIR"                     # Local user only
# sudo unzip -oq "${TMP_DIR}/${NF_VERSION}.zip" -d /usr/share/fonts/truetype  # All users

echo "Refreshing font cache..."
fc-cache -f

echo "Done. Installed fonts are in ${FONT_DIR}."
