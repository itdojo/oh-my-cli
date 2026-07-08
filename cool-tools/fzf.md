# Fuzzy Finder (fzf)

## fzf Installation

Project Page: https://github.com/junegunn/fzf

#### MacOS Install

```shell
brew install fzf
```

#### Linux Install

> [!Note]
> `sudo apt install fzf` works but distro versions lag far behind (the Ubuntu 24.04 package is too old to support the shell-integration commands below).  The git method installs the current release and makes upgrading easy.

```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

## Upgrading in the future
cd ~/.fzf && git pull && ./install
```

Set up the shell key bindings & completion (requires fzf 0.48+).  Add to `~/.zshrc` or `~/.bashrc`:

> Note: If you answered "yes" to the installer's questions about key bindings/completion, it already added equivalent lines for you — you don't need both.

```shell
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# or, for bash
# eval "$(fzf --bash)"
```

Then run:

```shell
source ~/.zshrc
```

***

## fzf Usage

| Action | What it does | Example
|:--|:--|:--|
| `command <ctrl-t>` | Brings up scrollable/searchable file list; the selection is inserted into your command line | `nvim <ctrl-t>`
| `command ** <tab>` | Same as `CTRL-t`; also has command-specific behavior for some commands | `kill ** <tab>`
| `ctrl-r` | Brings up scrollable/searchable command history |
| `alt-c` | Brings up scrollable/searchable directory list; `cd` into the selection |

> `**` syntax has special meaning with: `kill`, `ssh`, `telnet`, `unset`, `export`, `unalias`

> `CTRL-t` anywhere at the CLI will bring up a scrollable list.  Type to start reducing results (this is pretty awesome).

> `**` does the same thing as `CTRL-t` (but is easier to type for most of us)

***

### fzf Examples

```shell
nvim ** <tab>    # Opens a scrollable list that you can also start typing to filter the list

kill ** <tab> # Brings up list of processes you can scroll through (type to filter the list)
# With process selected, hit Enter and the PID will be populated in the command.

ssh ** <tab>     # Brings up list of known hosts

# Unset environment variables
unset ** <tab>   # Brings up list of environment variables

export ** <tab>

unalias **  <tab>
```

> Tip (tmux users): Newer fzf can render itself in a tmux popup instead of taking over the pane.  Add `--tmux` (fzf 0.53+; renamed `--popup` in 0.71+, `--tmux` still works) to your `FZF_DEFAULT_OPTS`, e.g. `export FZF_DEFAULT_OPTS="--tmux center,80%"`.

***

## fzf Color Scheme

Add to `~/.zshrc` or `~/.bashrc`:

```
# Example colors
# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
```

Then run:

```shell
source ~/.zshrc

# or 
# source ~/.bashrc
```

***

### fzf Theme Generator

Visit https://vitormv.github.io/fzf-themes/ to make your own custom layout.
