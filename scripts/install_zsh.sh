#!/usr/bin/env bash

# This script installs Zsh, Oh My Zsh, Powerlevel10k, and Nerd Fonts.
# It also sets up the Zsh plugins: zsh-autosuggestions, zsh-syntax-highlighting, and zsh-completions.
# It is intended to be run on a fresh install of a Debian-based Linux distribution or macOS.
# It will prompt for your password if it needs to install any packages.
# Usage: ./install_zsh.sh

set -o pipefail

NF_VERSION="v3.4.0"   # Nerd Fonts release; see https://github.com/ryanoasis/nerd-fonts/releases

check_for_root() {
    if [[ $EUID -eq 0 ]]; then
        echo
        echo "❌  Do not run as root.  You will be prompted if your password is needed."
        echo
        exit 1
    fi
}

# Executed when SIGINT (CTRL-C) is received
handle_ctrl_c() {
    printf "%s\n" "CTRL-C detected. Exiting..."
    echo ""
    exit 1
}
trap handle_ctrl_c INT

printline() {
    printf "%.s─" $(seq 1 "$(tput cols 2>/dev/null || echo 80)")    # Line style ─────────
}

format_font() {
    local text="$1"
    local weight="${2:-bold}"
    local color="${3:-yellow}"
    local reset="\033[0m"
    local color_code=""
    local weight_code=""

    # Define color codes
    case "$color" in
        blue) color_code="34";;
        red) color_code="31";;
        green) color_code="32";;
        yellow) color_code="33";;
        *) color_code="33";; # Default to yellow
    esac

    # Define weight codes
    case "$weight" in
        normal) weight_code="0";;
        bold) weight_code="1";;
        *) weight_code="1";; # Default to bold
    esac

    printline
    echo -e "\033[${weight_code};${color_code}m${text}${reset}"
}

install_pkg() {
    # Install a package with the platform's package manager
    local pkg="$1"
    if [[ "$os" = "Darwin" ]]; then
        brew install "$pkg"
    else
        sudo apt-get install -y "$pkg"
    fi
}

check_for_tool() {
    local tool="$1"
    if ! command -v "$tool" &>/dev/null; then
        format_font "📦  Installing ${tool}..."
        install_pkg "$tool"
    fi
    format_font "✅  ${tool} is installed."
}

check_for_homebrew() {
    # macOS only: Homebrew is needed before any other installs
    if [[ "$os" = "Darwin" ]] && ! command -v brew &>/dev/null; then
        format_font "📦  Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
}

check_for_oh_my_zsh() {
    if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
        format_font "📦  Installing Oh My Zsh..."
        # --unattended: don't launch zsh afterward, don't change the shell (handled below)
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    fi
    format_font "✅  Oh-My-Zsh is installed."
}

update_zshrc() {
    format_font "#️⃣  Updating .zshrc..."
    sed -i.bak 's|^ZSH_THEME=.*|ZSH_THEME="powerlevel10k/powerlevel10k"|' "$HOME"/.zshrc
}

install_nerd_fonts() {
    format_font "📦  Installing Nerd Fonts..."
    if [[ "$os" = "Darwin" ]]; then
        brew install --cask font-meslo-lg-nerd-font font-symbols-only-nerd-font
    else
        # ~/.local/share/fonts is the modern XDG per-user font dir (~/.fonts is deprecated)
        local font_dir="$HOME/.local/share/fonts"
        mkdir -p "$font_dir"
        if ! command -v unzip &>/dev/null; then check_for_tool unzip; fi
        if ! command -v fc-cache &>/dev/null; then
            format_font "📦  Installing fontconfig..."
            install_pkg fontconfig
        fi
        local font
        for font in Meslo NerdFontsSymbolsOnly; do
            if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/${NF_VERSION}/${font}.zip" -O "/tmp/${font}.zip"; then
                unzip -oq "/tmp/${font}.zip" -d "${font_dir}/${font}"
                rm -f "/tmp/${font}.zip"
            else
                format_font "❌  Failed to download ${font}.zip" "bold" "red"
            fi
        done
        fc-cache -f
    fi
    format_font "✅  Nerd Fonts are installed."
}

install_powerlevel10k() {
    format_font "📦  Installing Powerlevel10k..."
    local p10k_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
    if [[ -d "$p10k_dir" ]]; then
        git -C "$p10k_dir" pull --quiet
    else
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"
    fi
    format_font "✅  Powerlevel10k is installed."
}

install_zsh_plugins() {
    format_font "📦  Installing Zsh Plugins..."
    local plugin plugin_dir
    for plugin in "${plugins[@]}"; do
        plugin_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/$plugin"
        if [[ -d "$plugin_dir" ]]; then
            git -C "$plugin_dir" pull --quiet
        else
            git clone "https://github.com/zsh-users/$plugin.git" "$plugin_dir"
        fi
    done
    # Note: zsh-syntax-highlighting must be the last plugin in the list
    sed -i.bak 's|^plugins=.*|plugins=(git zsh-autosuggestions zsh-completions zsh-syntax-highlighting)|' "$HOME"/.zshrc
    format_font "✅  Zsh Plugins are installed."
}

change_default_shell() {
    local zsh_path
    zsh_path="$(command -v zsh)"
    if [[ "$SHELL" == "$zsh_path" ]]; then
        format_font "✅  zsh is already the default shell."
        return
    fi
    format_font "#️⃣  Changing default shell to Zsh. Your password is required."
    chsh -s "$zsh_path"
}

check_for_root

os=$(uname -s)

if [[ "$os" != "Darwin" && "$os" != "Linux" ]]; then
    format_font "❌  Unsupported OS. Quitting." "bold" "red"
    exit 1
fi

plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-completions)

check_for_homebrew
check_for_tool git
check_for_tool wget
check_for_tool curl
check_for_tool zsh
check_for_oh_my_zsh
install_nerd_fonts
install_powerlevel10k
change_default_shell
update_zshrc
install_zsh_plugins

format_font "After restarting your terminal, the PowerLevel10k (p10k) setup wizard will run. Run 'p10k configure' any time to reconfigure your preferences."
format_font "✅  Install complete. Please restart your terminal." "bold" "red"

echo ""
