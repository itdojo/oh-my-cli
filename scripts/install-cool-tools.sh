#!/usr/bin/env bash
#
# Installs the "cool tools" covered in this repo: eza, fzf, bat, zoxide and tldr.
# Safe to re-run: installs are skipped if a tool is present and shell-config lines
# are only appended once.
#
# Usage: ./install-cool-tools.sh

set -o pipefail

# Globals
CONFIG_FILE=""
DEPENDENCIES=("curl" "git" "wget" "unzip") # Ensure basic tools are installed
SUCCESS=0
FAILURE=1
BAT_VERSION_FALLBACK="0.26.1"  # used if the GitHub API can't be reached
BAT_THEME="tokyonight_moon"    # Options: tokyonight_day, tokyonight_moon, tokyonight_night, tokyonight_storm, Catppuccin Frappe, Catppuccin Latte, Catppuccin Macchiato, Catppuccin Mocha
EZA_DEFAULT="'eza --icons --group -lh'"


# ------------------------------------------------------------------------------------------------
# Helpers
# ------------------------------------------------------------------------------------------------

# Minimal fallbacks so the script still works if base_functions.sh cannot be downloaded.
define_fallback_helpers() {
    if ! declare -f printline >/dev/null; then
        printline() { printf '%.s─' $(seq 1 "$(tput cols 2>/dev/null || echo 80)"); echo ""; }
    fi
    if ! declare -f fstring >/dev/null; then
        # fstring <text> [style...] - fallback just prints the text
        fstring() { printf '%b\n' "$1"; }
    fi
    if ! declare -f check_if_linux >/dev/null; then
        check_if_linux() {
            if [[ "$(uname -s)" != "Linux" ]]; then
                printf "❌  This script is intended for Linux only.\n" >&2
                exit $FAILURE
            fi
        }
    fi
    if ! declare -f not_as_root >/dev/null; then
        not_as_root() {
            if [[ $EUID -eq 0 ]]; then
                printf "❌  Do not run as root. You will be prompted for your password when needed.\n" >&2
                exit $FAILURE
            fi
        }
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Append a line to $CONFIG_FILE only if it is not already there (keeps re-runs clean)
append_once() {
    local line="$1"
    if ! grep -qxF "$line" "$CONFIG_FILE" 2>/dev/null; then
        printf '%s\n' "$line" >> "$CONFIG_FILE"
    fi
}

# Append a multi-line block to $CONFIG_FILE only once, identified by a marker comment
append_block_once() {
    local marker="$1"
    local block="$2"
    if ! grep -qF "$marker" "$CONFIG_FILE" 2>/dev/null; then
        printf '\n%s\n%s\n' "$marker" "$block" >> "$CONFIG_FILE"
    fi
}

# Function to determine the shell config file dynamically
determine_config_file() {
    printf "Determining shell configuration file...\n"
    case "$SHELL" in
        */bash)
            CONFIG_FILE="$HOME/.bashrc"
            ;;
        */zsh)
            CONFIG_FILE="$HOME/.zshrc"
            ;;
        *)
            fstring "ERROR:  Unsupported shell. Only Bash and Zsh are supported.\n" "failure" >&2
            return $FAILURE
            ;;
    esac
    printf "🐚 Shell: %s\n" "$SHELL"
    printf "🔧 Config file: %s\n" "$CONFIG_FILE"
    return $SUCCESS
}

# Function to install dependencies
install_dependencies() {
    printline
    printf "🛠️  Checking and installing dependencies...\n"
    sudo apt-get update
    local dep
    for dep in "${DEPENDENCIES[@]}"; do
        printf "Checking for %s...\n" "$dep"
        if ! command_exists "$dep"; then
            printf "Installing %s.\n" "$dep"
            if ! sudo apt-get install -y "$dep"; then
                fstring "ERROR:  Failed to install $dep\n" "failure" >&2
                return $FAILURE
            fi
        fi
    done
    echo ""
    printf "✅  Dependencies installed successfully.\n"
    return $SUCCESS
}

# Function to determine the hardware platform
get_hardware_platform() {
    local platform
    platform=$(uname -m)   # uname -m is portable; 'uname -i' returns 'unknown' on many systems
    case "$platform" in
        x86_64)
            printf "amd64\n"
            ;;
        aarch64 | arm64)
            printf "arm64\n"
            ;;
        *)
            fstring "ERROR:  Unsupported hardware platform: $platform\n" "failure" >&2
            return $FAILURE
            ;;
    esac
}


write_fzf_config_to_file() {
    printf "Adding fzf preview configuration to %s\n" "$CONFIG_FILE"
    if grep -qF "# --- fzf + eza + bat integration ---" "$CONFIG_FILE" 2>/dev/null; then
        printf "fzf preview configuration already present. Skipping.\n"
        return $SUCCESS
    fi
    cat <<'EOF' >> "$CONFIG_FILE"

# --- fzf + eza + bat integration ---
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
EOF
}

# Function to install eza
install_eza() {
    fstring "Installing eza... " "install"
    printline
    if ! command_exists eza; then
        # eza is in the standard repos on Ubuntu 24.04+/Debian 13+; fall back to the
        # project's apt repo (deb.gierens.de) on older releases.
        if ! sudo apt-get install -y eza; then
            printf "eza not in distro repos; adding deb.gierens.de...\n"
            sudo apt-get install -y gpg
            sudo mkdir -p /etc/apt/keyrings
            if ! wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor --yes -o /etc/apt/keyrings/gierens.gpg; then
                fstring "ERROR:  Failed to fetch eza repo signing key\n" "failure" >&2
                return $FAILURE
            fi
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
            sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
            if ! { sudo apt-get update && sudo apt-get install -y eza; }; then
                fstring "ERROR:  Failed to install eza\n" "failure" >&2
                return $FAILURE
            fi
        fi
    fi
    printf "🛠️  Aliasing eza to ls in %s\n" "$CONFIG_FILE"
    append_once "alias ls=$EZA_DEFAULT"
    printf "✅  eza installed successfully.\n\n"
}


# Function to install fzf
install_fzf() {
    fstring "Installing fzf... " "install"
    printline
    if ! command_exists fzf && [ ! -d "$HOME/.fzf" ]; then
        if ! git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"; then
            fstring "ERROR:  Failed to clone fzf repository\n" "failure" >&2
            return $FAILURE
        fi
        # Install the binary only; we manage the shell-integration lines ourselves below
        # so re-running this script never duplicates rc entries.
        if ! "$HOME/.fzf/install" --bin; then
            fstring "ERROR:  Failed to install fzf\n" "failure" >&2
            return $FAILURE
        fi
    fi
    append_once 'export PATH="$HOME/.fzf/bin:$PATH"'
    case "$SHELL" in
        */bash)
            append_once 'eval "$(fzf --bash)"'
            ;;
        */zsh)
            append_once 'source <(fzf --zsh)'
            ;;
    esac

    write_fzf_config_to_file
    printf "✅  fzf installed successfully.\n\n"
}


# Function to install bat
install_bat() {
    fstring "Installing bat..." "install"
    printline
    if ! command_exists bat; then
        local platform
        if ! platform=$(get_hardware_platform); then
            return $FAILURE
        fi

        # Find the latest release version; fall back to a known-good pin if the API is unreachable
        local bat_version
        bat_version=$(curl -fsSL https://api.github.com/repos/sharkdp/bat/releases/latest 2>/dev/null | grep -oPm1 '"tag_name":\s*"v\K[^"]+')
        if [ -z "$bat_version" ]; then
            printf "⚠️  Could not query GitHub for the latest bat release. Using v%s.\n" "$BAT_VERSION_FALLBACK"
            bat_version="$BAT_VERSION_FALLBACK"
        fi

        local deb_url="https://github.com/sharkdp/bat/releases/download/v${bat_version}/bat_${bat_version}_${platform}.deb"
        local deb_file="/tmp/bat_${platform}.deb"

        printf "⬇️  Downloading bat v%s for platform %s...\n" "$bat_version" "$platform"
        if ! wget -q -O "$deb_file" "$deb_url"; then
            fstring "ERROR:  Failed to download bat package\n" "failure" >&2
            return $FAILURE
        fi

        if ! sudo dpkg -i "$deb_file"; then
            fstring "ERROR:  Failed to install bat package\n" "failure" >&2
            rm -f "$deb_file"
            return $FAILURE
        fi
        rm -f "$deb_file"
        printf "✅  bat installed successfully for platform %s\n" "$platform"
    fi

    printf "🛠️  Aliasing cat to bat in %s\n" "$CONFIG_FILE"
    append_once "alias cat='bat'"

    printf "🗂️   Creating bat themes directory in %s.\n" "$(bat --config-dir)"
    mkdir -p "$(bat --config-dir)/themes"

    # Install extra theme files
    printf "⬇️  Downloading some bat themes...\n"
    local theme
    printf "  Getting tokyonight themes...\n"
    for theme in tokyonight_day tokyonight_moon tokyonight_night tokyonight_storm; do
        wget -q "https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/${theme}.tmTheme" \
            -O "$(bat --config-dir)/themes/${theme}.tmTheme" || printf "⚠️  Failed to download %s\n" "$theme"
    done
    printf "  Getting Catppuccin themes...\n"
    for theme in Frappe Latte Macchiato Mocha; do
        wget -q "https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20${theme}.tmTheme" \
            -O "$(bat --config-dir)/themes/Catppuccin ${theme}.tmTheme" || printf "⚠️  Failed to download Catppuccin %s\n" "$theme"
    done

    echo ""
    printf "🛠️  Building bat syntax highlighting database...\n"
    bat cache --build
    printf "✅  bat themes installed successfully.\n"
    echo ""
    printf "ℹ️  Preview bat themes:\n"
    fstring "\tbat --list-themes | fzf --preview=\"bat --theme={} --color=always $CONFIG_FILE\"\n" "normal" "bold" "blue"

    printf "🛠️  Setting bat theme to %s.  Change it later if you prefer (BAT_THEME in %s).\n" "$BAT_THEME" "$CONFIG_FILE"
    append_once "export BAT_THEME=$BAT_THEME"
    echo ""
}


# Function to install zoxide
install_zoxide() {
    fstring "Installing zoxide... " "install"
    printline
    if ! command_exists zoxide; then
        if ! curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh; then
            fstring "ERROR:  Failed to install zoxide\n" "failure" >&2
            return $FAILURE
        fi
    fi

    printf "Updating \$PATH to include %s/.local/bin.\n" "$HOME"
    append_once 'export PATH="$HOME/.local/bin:$PATH"'

    printf "Adding zoxide to %s\n" "$CONFIG_FILE"
    case "$SHELL" in
        */bash)
            append_once 'eval "$(zoxide init bash)"'
            ;;
        */zsh)
            append_once 'eval "$(zoxide init zsh)"'
            ;;
    esac

    printf "Aliasing zoxide to cd in %s\n" "$CONFIG_FILE"
    append_once 'alias cd="z"'
    printf "✅  zoxide installed successfully.\n"
    echo ""
}


# Function to install a tldr client
install_tldr() {
    fstring "Installing tldr (tealdeer client)... " "install"
    printline
    if ! command_exists tldr; then
        # The apt 'tldr' package is an outdated client; tealdeer is a maintained Rust
        # client that provides the same 'tldr' command.
        if ! sudo apt-get install -y tealdeer; then
            printf "tealdeer not available via apt; trying pipx...\n"
            if ! { sudo apt-get install -y pipx && pipx install tldr; }; then
                fstring "ERROR:  Failed to install a tldr client\n" "failure" >&2
                return $FAILURE
            fi
        fi
    fi
    # Populate/refresh the page cache (non-fatal if offline)
    tldr --update >/dev/null 2>&1 || true
    echo ""
    printf "✅  tldr installed successfully.\n\n"
}


# Main function
main() {
    # Download base functions (fstring, printline, check_if_linux, not_as_root).
    # If the download fails, built-in fallbacks (defined above) are used instead.
    if wget -q https://raw.githubusercontent.com/itdojo/qol/refs/heads/main/linux/base_functions.sh -O /tmp/base_functions.sh 2>/dev/null; then
        # shellcheck source=/dev/null
        source /tmp/base_functions.sh
        rm -f /tmp/base_functions.sh
    else
        printf "⚠️  Could not download base_functions.sh; using built-in fallbacks.\n"
    fi
    define_fallback_helpers

    check_if_linux
    not_as_root
    clear

    printline
    printf "🚀 Installing Cool CLI Tools 🚀\n"
    printline

    if ! determine_config_file; then
        fstring "ERROR:  Unable to determine the shell configuration file.\n" "failure" >&2
        exit $FAILURE
    fi

    if ! install_dependencies; then
        fstring "ERROR:  Failed to install dependencies\n" "failure" >&2
        exit $FAILURE
    fi

    if ! install_eza; then printf "❌ eza installation failed\n" >&2; fi
    if ! install_fzf; then printf "❌ fzf installation failed\n" >&2; fi
    if ! install_bat; then printf "❌ bat installation failed\n" >&2; fi
    if ! install_zoxide; then printf "❌ zoxide installation failed\n" >&2; fi
    if ! install_tldr; then printf "❌ tldr installation failed\n" >&2; fi

    printline
    printf "🏁 Installation complete.\n"
    printline
    echo ""
    printf "ℹ️  Reload your shell or run: source %s\n" "$CONFIG_FILE"
    echo ""
}

main "$@"
