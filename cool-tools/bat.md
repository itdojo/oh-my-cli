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

After installing, run `bat`.  If you get a **command not found** error, it is because Debian/Ubuntu install the binary as `batcat` (a package name conflict).  Fix it with a symlink:

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

> Important Note: You can safely pipe bat's output into other programs — when bat detects its output is not a terminal, it automatically drops the line numbers, colors and frame.  The one gotcha is *mouse-copying from the screen*: the displayed line numbers and frame get copied along with the text, which is rarely what you want.  For copy-friendly output, use `bat -p <file>` (plain style).

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

> Tip: bat 0.25+ can auto-switch between a light and dark theme to match your terminal: set `export BAT_THEME_LIGHT=<theme>` and `export BAT_THEME_DARK=<theme>` (and leave `BAT_THEME` unset).

