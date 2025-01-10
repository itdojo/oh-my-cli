# If MacOS, check if homebrew is installed, if not, install it

# If Linux, check if running as root

# Install tmux
# If linux, install using apt (need sudo privileges)
# If macOS, install using brew

# Remove existing tmux configuration files
# Create new tmux configuration files
# mkdir -p ~/.config/tmux/plugins
# touch ~/.config/tmux/tmux.conf
# ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
# Add XDG_CONFIG_HOME=~/.config to .bashrc or .zshrc (if not already present)

# Install tmux plugin manager
# git clone https://github.com/tmux-plugins/tpm.git ~/.config/tmux/plugins/tpm

# Install tmux plugins
# Add the following to tmux.conf
# set -g @plugin 'tmux-plugins/tpm'
# tmux-powerline
# set -g @plugin 'erikw/tmux-powerline'
# tmux-sensible
# set -g @plugin 'tmux-plugins/tmux-sensible'
# tmux-resurrect
# set -g @plugin 'tmux-plugins/tmux-resurrect'
# tmux-continuum
# set -g @plugin 'tmux-plugins/tmux-continuum'
# tmux-battery
# set -g @plugin 'tmux-plugins/tmux-battery'
# tmux-copycat
# set -g @plugin 'tmux-plugins/tmux-copycat'
# tmux-battery
# set -g @plugin 'tmux-plugins/tmux-battery'
# tmux-yank
# set -g @plugin 'tmux-plugins/tmux-yank'
