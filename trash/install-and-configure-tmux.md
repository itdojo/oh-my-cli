# tmux

## Installation

### MacOS 

- [ ] Install Homebrew if necessary.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

***

- [ ] Install tmux.

```shell
brew install tmux
```

### Linsx

- [ ] Install tmux.

```shell
sudo apt update && sudo apt install -y tmux
```

***

## Install tmux plugin manager (tpm)

- [ ] Install tmux plugin manager (tpm).

```shell
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

```shell
vim ~/.config/tmux/tmux.conf
```

Add the following to `tmux.conf`:

```groovy
# List of plugins
set -g @plugin 'plugins/tpm'
set -g @plugin 'plugins/tmux-sensible'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.config/tmux/plugins/tpm/tpm'
```

*** 

- [ ] Alias the `tmux.conf` file to `~/.tmux.conf`.

```shell
ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
```

***

- [ ] Restart tmux.

***

## Key bindings

| Binding | What it does
|:--|:--|
| `prefix + I` | Installs plugin (after adding it to `~/.tmux.conf`)
| `prefix + u` | Updates plugins 
| `prefix + ALT + u` | Uninstalls plugins not in plugins list in `~/.tmux.conf`

```shell
brew install --cask font-meslo-lg-nerd-font
```

## Catppuccin for Tmux

```shell
mkdir -p ~/.config/tmux/plugins/catppuccin

git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

Theme options:
🌻 Latte
🪴 Frappé
🌺 Macchiato
🌿 Mocha
