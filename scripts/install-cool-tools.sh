#!/bin/bash

# Globals
CONFIG_FILE=""
DEPENDENCIES=("curl" "git" "wget") # Ensure basic tools are installed
SUCCESS=0
FAILURE=1
BAT_THEME="tokyonight_moon" # Options: tokyonight_day, tokyonight_moon, tokyonight_night, tokyonight_storm, Catppuccin Frappe, Catppuccin Latte, Catppuccin Macchiato, Catppuccin Mocha
EZA_DEFAULT="'eza --icons --group -lh'"


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
    printf "🐚 Shell: $SHELL\n"
    printf "🔧 Config file: $CONFIG_FILE\n"
    return $SUCCESS
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


# Function to install dependencies
install_dependencies() {
    printline
    printf "🛠️  Checking and installing dependencies...\n"
    local dep
    for dep in "${DEPENDENCIES[@]}"; do
        printf "Checking for $dep...\n"
        if ! command_exists "$dep"; then
            printf "Installing $dep."
            if ! sudo apt-get install -y "$dep"; then
                fstring "ERROR:  Failed to install %s\n" "$dep" "failure" >&2
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
    platform=$(uname -i)
    case "$platform" in
        x86_64)
            printf "amd64\n"
            ;;
        aarch64 | arm64)
            printf "arm64\n"
            ;;
        *)
            fstring "ERROR:  Unsupported hardware platform: %s\n" "$platform" "failure" >&2
            return $FAILURE
            ;;
    esac
}


write_fzf_config_to_file() {
    printf "Adding fzf key bindings to %s\n" "$CONFIG_FILE"
    cat <<'EOF' >> $CONFIG_FILE
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
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
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
    if ! command_exists eza; then
        fstring "Installing eza... " "install"
        printline
        sudo apt install -y gpg
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update && sudo apt install -y eza
        printf "🛠️  Aliasing eza to ls in %s\n" "$CONFIG_FILE"
        printf "alias ls=%s\n" "$EZA_DEFAULT" >> "$CONFIG_FILE"
    fi
}


# Function to install fzf
install_fzf() {
    fstring "Installing fzf... " "install"
    printline
    if ! command_exists fzf; then
        if ! git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf; then
            fstring "ERROR:  Failed to clone fzf repository\n" "failure" >&2
            return $FAILURE
        fi
        if ! ~/.fzf/install --all; then
            fstring "ERROR:  Failed to install fzf\n" "failure" >&2
            return $FAILURE
        fi
    fi
    case "$SHELL" in
        */bash)
            printf 'eval "$(fzf --bash)"\n' >> "$CONFIG_FILE"
            ;;
        */zsh)
            printf 'source <(fzf --zsh)\n' >> "$CONFIG_FILE"
            ;;
    esac
    
    # Write $FZF_CONFIG to $CONFIG_FILE
    write_fzf_config_to_file
}


# Function to install bat
install_bat() {
    fstring "Installing bat..." "install"
    printline
    local platform
    if ! platform=$(get_hardware_platform); then
        return $FAILURE
    fi

    local deb_url
    case "$platform" in
        amd64)
            deb_url="https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_amd64.deb"
            ;;
        arm64 | aarch64)
            deb_url="https://github.com/sharkdp/bat/releases/download/v0.24.0/bat_0.24.0_arm64.deb"
            ;;
        *)
            fstring "ERROR:  No download URL available for platform: $platform" "failure" >&2
            return $FAILURE
            ;;
    esac

    local deb_file
    deb_file="/tmp/bat_${platform}.deb"

    printf "⬇️  Downloading bat for platform %s...\n" "$platform"
    if ! wget -O "$deb_file" "$deb_url"; then
        fstring "ERROR:  Failed to download bat package\n" "failure" >&2
        return $FAILURE
    fi
    
    fstring "Installing bat... " "install"
    printline
    if ! sudo dpkg -i "$deb_file"; then
        fstring "ERROR:  Failed to install bat package\n" "failure" >&2
        return $FAILURE
    fi

    rm -f "$deb_file"

    printf "🛠️  Aliasing cat to bat in %s\n" "$CONFIG_FILE"
    printf "alias cat='bat'\n" >> "$CONFIG_FILE"
    echo ""
    printf "✅  bat installed successfully for platform %s\n" "$platform"

    printf "🗂️   Creating bat themes directory in %s.\n" "$(bat --config-dir)"
    mkdir -p "$(bat --config-dir)/themes"
    
    # Install extra theme files
    printf "⬇️  Downloading some bat themes...\n"
    printf "  Getting tokyonight themes...\n"
    wget -q https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_day.tmTheme -O "$(bat --config-dir)/themes/tokyonight_day.tmTheme"
    wget -q https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_moon.tmTheme -O "$(bat --config-dir)/themes/tokyonight_moon.tmTheme"
    wget -q https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_night.tmTheme -O "$(bat --config-dir)/themes/tokyonight_night.tmTheme"
    wget -q https://raw.githubusercontent.com/folke/tokyonight.nvim/refs/heads/main/extras/sublime/tokyonight_storm.tmTheme -O "$(bat --config-dir)/themes/tokyonight_storm.tmTheme"
    printf "  Getting Catppuccin themes...\n"
    wget -q https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Frappe.tmTheme -O "$(bat --config-dir)/themes/Catppuccin Frappe.tmTheme"
    wget -q https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Latte.tmTheme -O "$(bat --config-dir)/themes/Catppuccin Latte.tmTheme"
    wget -q https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Macchiato.tmTheme -O "$(bat --config-dir)/themes/Catppuccin Macchiato.tmTheme"
    wget -q https://raw.githubusercontent.com/catppuccin/bat/refs/heads/main/themes/Catppuccin%20Mocha.tmTheme -O "$(bat --config-dir)/themes/Catppuccin Mocha.tmTheme"
    
    echo ""
    printf "🛠️  Building bat syntax highlighting database...\n"
    bat cache --build  # Build syntax highlighting database
    printf "✅  Bat themes installed successfully.\n\n"
    echo ""
    printf "ℹ️  Preview bat themes:\n"
    fstring "\tbat --list-themes | fzf --preview=\"bat --theme={} --color=always $CONFIG_FILE\n" "normal" "bold" "blue"
    
    printf "ℹ️  Set bat theme by editing %s. Example:\n" "$CONFIG_FILE"
    fstring "\texport BAT_THEME=$BAT_THEME" "normal" "bold" "blue"
  

    # Preview themes with fzf
    # bat --list-themes | fzf --preview="bat --theme={} --color=always $CONFIG_FILE"

    # Set default theme
    echo ""
    printf "🛠️  Setting bat theme to $(fstring "$BAT_THEME" "normal" "bold" "blue").  Change it later if you prefer.\n"
    printf "export BAT_THEME=$BAT_THEME\n" >> "$CONFIG_FILE"
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

    printf "Updating \$PATH to include $HOME/.local/bin.\n"
    printf 'export PATH="$HOME/.local/bin:$PATH"\n' >> "$CONFIG_FILE"
    
    case "$SHELL" in
        */bash)
            printf "Adding zoxide to %s\n" "$CONFIG_FILE"
            printf 'eval "$(zoxide init bash)"\n' >> "$CONFIG_FILE"

            ;;
        */zsh)
            printf "Adding zoxide to %s\n" "$CONFIG_FILE"
            printf 'eval "$(zoxide init zsh)"\n' >> "$CONFIG_FILE"

            ;;
    esac
    
    printf "Aliasing zoxide to cd in %s\n" "$CONFIG_FILE"
    printf 'alias cd="z"\n' >> "$CONFIG_FILE"
    printf "✅  zoxide & zoxide themes installed successfully.\n"
    echo ""
}


# Function to install tldr
install_tldr() {
    fstring "Installing tldr... " "install"
    printline
    if ! command_exists tldr; then
        if ! sudo apt-get install -y tldr; then
            fstring "ERROR:  Failed to install tldr\n" "failure" >&2
            return $FAILURE
        fi
    fi
    echo ""
    printf "✅  tldr installed successfully.\n\n"
}


# Function to install thefuck
# install_thefuck() {
#     fstring "Installing thefuck... " "install"
#     printline
#     if ! command_exists thefuck; then
#         if ! sudo apt-get install -y python3-dev python3-pip; then
#             printf "Error: Failed to install Python dependencies for thefuck\n" >&2
#             return $FAILURE
#         fi
#         if ! pip3 install thefuck --user; then
#             fstring "ERROR:  Failed to install thefuck\n" "failure" >&2
#             return $FAILURE
#         fi
#     fi
#     printf "eval \$(thefuck --alias)\n" >> "$CONFIG_FILE"
# }


# Main function
main() {
    # Download base functions
    # fstring, printline, check_if_linux, not_as_root all come from this file.  The script cannot run without it.
    wget -q https://raw.githubusercontent.com/itdojo/qol/refs/heads/main/linux/base_functions.sh -O base_functions.sh 2> /dev/null
    if [ ! -f ./base_functions.sh ] > /dev/null; then
        fstring "ERROR:  base_functions.sh not found. Cannot continue." "failure" >&2
        printf "Check for it at https://github.com/itdojo/qol/blob/main/linux/base_functions.sh\n" >&2
        return $FAILURE
    else
        source base_functions.sh
    fi
    
    check_if_linux
    not_as_root
    clear

    printline dentistry
    printf "🚀 Installing Cool CLI Tools 🚀\n"
    printline dentistry

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
    # if ! install_thefuck; then printf "❌ thefuck installation failed\n" >&2; fi
    
    printline dentistry
    printf "🏁 Installation complete.\n"
    printline dentistry
    echo ""
    printf "ℹ️  Reload your shell or run: $(fstring "source $CONFIG_FILE" "normal" "bold" "blue")\n"
    
    echo ""
    
    # Clean up
    rm -f base_functions.sh
}

main "$@"