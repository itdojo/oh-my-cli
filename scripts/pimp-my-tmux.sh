# Rough draft of a script to install tmux, fonts, and plugins

install tmux

install fonts

clone tpm

clone catppuccin

install nvim ?

alias' and exports in .zshrc

write tmux.conf to ~/.config/tmux/tmux.conf
download tmux.conf.base, tmux.conf.catppucin, and tmux.conf.powerline from github, and write them to ~/.config/tmux/

if ! command -v tmux >/dev/null 2>&1; then sudo apt update && sudo apt install -y tmux; else echo "tmux is already installed."; fi

# MacOS
if ! command -v tmux >/dev/null 2>&1; then brew install tmux; else echo "tmux is already installed."; fi

mkdir -p ~/.config/tmux
wget tmux.conf from github


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

cat >> ~/.zshrc << 'EOL'
if [[ ! -d ~/.config ]]; then mkdir -p ~/.config/; fi
export XDG_CONFIG_HOME=$HOME/.config
EOL

source ~/.zshrc

# or
# source ~/.bashrc

mkdir -p ~/.config/tmux/plugins/catppuccin


git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm


# Check the repo page for the most up-to-date release (v2.1.2 at the time of writing)
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux

