#!/bin/bash

BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0"
FONTS=("Meslo" "NerdFontsSymbolsOnly" "FiraCode" "Hack" "SourceCodePro")
TMP_DIR="/tmp"

if [[ ! $(command -v fc-cache) ]]; then echo "Installing fontconfig..." && sudo apt install fontconfig; fi

if [[ ! $(command -v unzip) ]]; then echo "Installing unzip..." && sudo apt install unzip; fi

mkdir -p ~/.fonts

for FONT in "${FONTS[@]}"; do
  wget -q "${BASE_URL}/${FONT}.zip" -O "${TMP_DIR}/${FONT}.zip"
  unzip -oq "${TMP_DIR}/${FONT}.zip" -d ~/.fonts/
  # Global install
  # sudo unzip -oq "${TMP_DIR}/${FONT}.zip" -d /usr/share/fonts/truetype/
  
done

rm /tmp/Meslo.zip /tmp/NerdFontsSymbolsOnly.zip /tmp/FiraCode.zip /tmp/SourceCodePro.zip /tmp/Hack.zip

# For ALL Nerd fonts (Be careful! HUGE!!! >3.2GB file)
# Check https://github.com/ryanoasis/nerd-fonts/tags for most up-to-date release

# wget -q https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v3.3.0.zip -O /tmp/v3.3.0.zip
# sudo unzip -oq /tmp/v3.3.0.zip -d ~/.fonts                    # Local User Only
# sudo unzip -oq /tmp/v3.3.0.zip -d /usr/share/fonts/truetype   # All Users
# rm /tmp/v3.3.0.zip

sudo fc-cache -f
