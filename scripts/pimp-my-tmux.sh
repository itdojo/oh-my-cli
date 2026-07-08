#!/usr/bin/env bash
#
# Sets up tmux the way the tmux lab in this repo does:
#   * installs tmux (apt or Homebrew)
#   * installs the required Nerd Fonts (Meslo + Symbols)
#   * ensures XDG_CONFIG_HOME is set in your shell config
#   * clones tpm (tmux plugin manager) and the catppuccin theme
#   * installs this repo's tmux.conf files into ~/.config/tmux/
#     (an existing tmux.conf is backed up first)
#   * installs the tmux plugins non-interactively
#
# Usage: ./pimp-my-tmux.sh

set -o pipefail

NF_VERSION="v3.4.0"          # https://github.com/ryanoasis/nerd-fonts/releases
CATPPUCCIN_VERSION="v2.3.0"  # https://github.com/catppuccin/tmux/releases
REPO_RAW="https://raw.githubusercontent.com/itdojo/oh-my-cli/main"
TMUX_DIR="$HOME/.config/tmux"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS="$(uname -s)"

info()  { printf 'ℹ️  %s\n' "$1"; }
ok()    { printf '✅  %s\n' "$1"; }
warn()  { printf '⚠️  %s\n' "$1" >&2; }
fail()  { printf '❌  %s\n' "$1" >&2; exit 1; }

if [[ $EUID -eq 0 ]]; then
    fail "Do not run as root. You will be prompted for your password when needed."
fi

# ------------------------------------------------------------------ tmux ----
install_tmux() {
    if command -v tmux >/dev/null 2>&1; then
        ok "tmux is already installed ($(tmux -V))."
        return
    fi
    info "Installing tmux..."
    if [[ "$OS" = "Darwin" ]]; then
        command -v brew >/dev/null 2>&1 || fail "Homebrew is required on macOS. Visit https://brew.sh"
        brew install tmux
    else
        sudo apt-get update && sudo apt-get install -y tmux
    fi
    ok "tmux installed ($(tmux -V))."
}

# ----------------------------------------------------------------- fonts ----
install_fonts() {
    info "Installing Nerd Fonts (Meslo + Symbols)..."
    if [[ "$OS" = "Darwin" ]]; then
        brew install --cask font-meslo-lg-nerd-font font-symbols-only-nerd-font
    else
        local font_dir="$HOME/.local/share/fonts"
        mkdir -p "$font_dir"
        command -v unzip >/dev/null 2>&1 || sudo apt-get install -y unzip
        command -v fc-cache >/dev/null 2>&1 || sudo apt-get install -y fontconfig
        local font
        for font in Meslo NerdFontsSymbolsOnly; do
            if [[ -d "${font_dir}/${font}" ]]; then
                info "${font} already installed. Skipping."
                continue
            fi
            if wget -q "https://github.com/ryanoasis/nerd-fonts/releases/download/${NF_VERSION}/${font}.zip" -O "/tmp/${font}.zip"; then
                unzip -oq "/tmp/${font}.zip" -d "${font_dir}/${font}"
                rm -f "/tmp/${font}.zip"
            else
                warn "Failed to download ${font}.zip -- continuing without it."
            fi
        done
        fc-cache -f
    fi
    ok "Fonts installed."
}

# ------------------------------------------------------- shell rc entries ----
configure_shell_rc() {
    local rc
    case "$SHELL" in
        */zsh)  rc="$HOME/.zshrc" ;;
        */bash) rc="$HOME/.bashrc" ;;
        *)      warn "Unsupported shell ($SHELL); skipping XDG_CONFIG_HOME setup."; return ;;
    esac
    mkdir -p "$HOME/.config"
    if ! grep -q 'XDG_CONFIG_HOME' "$rc" 2>/dev/null; then
        info "Adding XDG_CONFIG_HOME to ${rc}..."
        printf '\nexport XDG_CONFIG_HOME=$HOME/.config\n' >> "$rc"
    else
        info "XDG_CONFIG_HOME already set in ${rc}."
    fi
}

# --------------------------------------------------------------- plugins ----
clone_plugins() {
    mkdir -p "$TMUX_DIR/plugins/catppuccin"

    if [[ -d "$TMUX_DIR/plugins/tpm" ]]; then
        info "tpm already cloned. Updating..."
        git -C "$TMUX_DIR/plugins/tpm" pull --quiet || warn "Could not update tpm."
    else
        info "Cloning tpm..."
        git clone --depth 1 https://github.com/tmux-plugins/tpm "$TMUX_DIR/plugins/tpm"
    fi

    if [[ -d "$TMUX_DIR/plugins/catppuccin/tmux" ]]; then
        info "catppuccin already cloned. Skipping."
    else
        info "Cloning catppuccin ${CATPPUCCIN_VERSION}..."
        git clone -b "$CATPPUCCIN_VERSION" --depth 1 https://github.com/catppuccin/tmux.git "$TMUX_DIR/plugins/catppuccin/tmux"
    fi
    ok "tmux plugins are in place."
}

# ---------------------------------------------------------------- configs ----
install_configs() {
    mkdir -p "$TMUX_DIR"

    if [[ -f "$TMUX_DIR/tmux.conf" ]]; then
        local backup
        backup="$TMUX_DIR/tmux.conf.backup.$(date +%Y%m%d%H%M%S)"
        info "Backing up existing tmux.conf to ${backup}"
        cp "$TMUX_DIR/tmux.conf" "$backup"
    fi

    local f
    for f in tmux.conf tmux.conf.base tmux.conf.catppuccin; do
        # Prefer the local repo copy (script normally lives in oh-my-cli/scripts/);
        # fall back to fetching from GitHub.
        if [[ -f "$SCRIPT_DIR/../tmux/config/$f" ]]; then
            cp "$SCRIPT_DIR/../tmux/config/$f" "$TMUX_DIR/$f"
        elif ! wget -q "$REPO_RAW/tmux/config/$f" -O "$TMUX_DIR/$f"; then
            warn "Could not obtain $f"
            continue
        fi
        info "Installed $f -> $TMUX_DIR/$f"
    done
    ok "tmux configuration installed."
}

# ---------------------------------------------------------- tpm plugins -----
install_tpm_plugins() {
    info "Installing tmux plugins via tpm..."
    if "$TMUX_DIR/plugins/tpm/bin/install_plugins"; then
        ok "tmux plugins installed."
    else
        warn "tpm plugin install reported a problem. Inside tmux, run 'prefix I' to retry."
    fi
}

install_tmux
install_fonts
configure_shell_rc
clone_plugins
install_configs
install_tpm_plugins

echo ""
ok "All done. Start tmux with: tmux"
info "If tmux was already running, reload the config with: tmux source-file $TMUX_DIR/tmux.conf"
