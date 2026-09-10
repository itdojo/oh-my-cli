## Ghostty — a fast terminal that needs almost no configuration

[Ghostty](https://ghostty.org) is a GPU-accelerated terminal emulator written by Mitchell Hashimoto. It is fast, it is native on each platform it runs on, and — the part that matters for this repo — it ships with sane defaults, so a config file is a thing you write to express a preference rather than a thing you write to make the terminal usable.

Two things it does that are worth switching for. It renders quickly enough that `cat`-ing a large file or scrolling a long build log does not stutter. And it is standards-obsessive about escape sequences, which means the things that break in other terminals — undercurl, styled underlines, `kitty-keyboard` protocol keybinds in Neovim — work here without a workaround.

It does splits and tabs natively. That overlaps with tmux, and the two coexist fine: use Ghostty's splits locally and tmux when you need sessions that survive a disconnect.

***

## Installing

### macOS

```shell
brew install --cask ghostty
```

macOS is the only platform for which the Ghostty project distributes official signed binaries. The Homebrew cask wraps the same `.dmg` you would download from the site.

### Linux

There is no official Linux binary. Every option below is either a distro package or a community build.

| Distribution | Command |
|:--|:--|
| Ubuntu 26.04+ | `sudo apt install ghostty` |
| Ubuntu (older) | `sudo snap install ghostty --classic` |
| Debian | community `.deb` from [ghostty-ubuntu releases](https://github.com/mkasberg/ghostty-ubuntu/releases) |
| Fedora / RHEL | `sudo dnf copr enable scottames/ghostty && sudo dnf install ghostty` |
| Arch / Manjaro | `sudo pacman -S ghostty` |
| Alpine | `sudo apk add ghostty` (testing repository) |
| openSUSE | `sudo zypper in ghostty` |
| Anything else | the [AppImage](https://ghostty.org/docs/install/binary) |

### Or use the script

- [ ] Run the following, which picks the right path for your platform and drops in the example config:

```shell
cd oh-my-cli/scripts

chmod +x install-ghostty.sh

./install-ghostty.sh
```

***

## Configuring

Ghostty reads the first of these it finds:

```
$XDG_CONFIG_HOME/ghostty/config.ghostty     # ~/.config/ghostty/config.ghostty
$XDG_CONFIG_HOME/ghostty/config
```

On macOS it also checks `~/Library/Application Support/com.mitchellh.ghostty/`, but `~/.config/ghostty/` works on both platforms, so use that one and keep a single path in your head. The `config.ghostty` filename is the current preference; plain `config` is the pre-1.2.3 name and still works.

The format is `key = value`, one per line, `#` for comments. There is no nesting and no sections — the headings in the example config below are decoration.

- [ ] Drop the example config in place:

```shell
mkdir -p ~/.config/ghostty

curl -fLo ~/.config/ghostty/config.ghostty \
  https://raw.githubusercontent.com/itdojo/qol/main/configs/config.ghostty
```

The full file lives at [itdojo/qol/configs/config.ghostty](https://github.com/itdojo/qol/blob/main/configs/config.ghostty). Here is the part of it you are most likely to change:

```shell
# Theme and font
theme = "Catppuccin Mocha"
font-family = "MesloLGS Nerd Font Mono"
font-size = 12
font-thicken = true

# Transparency: 0.00 (clear) through 1.00 (opaque)
background-opacity = 1.00
background-blur = true

# macOS: embed tabs in the title bar. Options: standard, hidden, tabs
macos-titlebar-style = tabs

window-theme = dark
window-padding-x = 12
window-padding-y = 12

# Cursor
cursor-color = #ffff00
cursor-style = block
cursor-style-blink = false
cursor-click-to-move = true

# Jump between splits with Cmd + arrow keys
keybind = cmd+left=goto_split:left
keybind = cmd+right=goto_split:right
keybind = cmd+up=goto_split:top
keybind = cmd+down=goto_split:bottom
```

A few of those are macOS-only — `macos-titlebar-style`, and the `cmd+` keybinds, since Linux has no Cmd key. Ghostty ignores settings it does not recognize on the current platform rather than refusing to start, so the same file is portable. On Linux, rebind the split navigation to `ctrl+alt+` arrows.

***

## Finding your options

Ghostty is self-documenting from the command line, and this is faster than reading the docs:

```shell
ghostty +list-themes     # every built-in theme, with a live preview
ghostty +list-fonts      # every font Ghostty can see, by its exact name
ghostty +list-colors     # named colors you can use for cursor-color and friends
ghostty +show-config     # your current config, fully resolved
ghostty +list-actions    # every action a keybind can be bound to
```

`+list-fonts` is the one to reach for first. Font names in a config file have to match exactly, and the name a font reports is rarely the name of the file it came in — this is why `MesloLGS Nerd Font Mono` and not `Meslo.ttf`.

The full reference is at [ghostty.org/docs/config](https://ghostty.org/docs/config).

***

## Fonts

The example config asks for a Nerd Font, which is a normal font with a few thousand icon glyphs patched into its private-use area. Starship, eza and tmux status bars all draw from that set. If you have not installed one yet, do that first:

```shell
cd oh-my-cli/scripts && ./install-nerd-fonts.sh
```

Boxes instead of icons means the font is missing or the name in the config does not match what `ghostty +list-fonts` reports.

***

End.
