# `bat`: Better `cat`

## Installation

Project Location: https://github.com/sharkdp/bat

### MacOS

```shell
brew install bat
```

### Linux

```shell
sudo apt update && sudo apt install -y bat
```

#### Linux Install Test/Fix

After installing, run `bat`.  If you get a **command not found** error, do this:

```shell
mkdir -p ~/.local/bin

ln -s /usr/bin/batcat ~/.local/bin/bat
```

***

## `bat` Usage

Use like you would use `cat`.

***
## Replace `cat` with `bat` Alias

Edit `~/.zshrc` or `~/.bashrc` and add this to bottom of file:

```shell
alias cat="bat"
```

> Important Note: You can safely pipe bat's output into other programs.  However, the STDOUT shows line numbers on the left side and this does not work if you use your mouse to copy the output of cat to your clipboard.  The added line numbers in bat also get copied and are unlikely to be what you want if trying to copy that way.

***

## `bat` Themes

```
bat --list-themes
```

Or, with `fzf` installed:

```shell
bat --list-themes | fzf --preview="bat --theme={} --color=always /path/to/file"

# Example using SSH config file
# Scroll up/down through themes to see how they look with your files.
bat --list-themes | fzf --preview="bat --theme={} --color=always ~/.ssh/config"
```

***

## Custom `bat` themes

```shell
mkdir -p "$(bat --config-dir)/themes"

# or
# mkdir -p ~/.config/bat/themes
```

A few theme examples:
```shell
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
```

After downloading themes, run:

```shell
bat cache --build
```

Once you find a theme you like, edit `.zshrc` or `.bashrc` with:

```shell
# bat theme configuration
export BAT_THEME=<theme_name>

# Example
export BAT_THEME=DarkNeon
```

