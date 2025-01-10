## Fuzzy Finder (fzf)

## fzf Installation

Project Page: https://github.com/junegunn/fzf

### MacOS

```shell
brew install fzf
```

### Linux

```shell
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

~/.fzf/install

## Upgrading in the future
cd ~/.fzf && git pull && ./install
```

Add to `~/.zshrc` or `~/.bashrc`:

```shell
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
```

Then run:

```shell
source ~/.zshrc
```

***

## fzf Usage

| Action | What it does | Example
|:--|:--|:--|
| `commnand <ctrl-t>` | Brings up scrollable/searchable menu | `nvim <ctrl-t>`
| `command ** <tab>` | Brings up `command`-specific options | `kill ** <tab>`
| `command ** <tab>` | Brings up scrollable/searchable menu foe commands without special use/meaning | 
| `ctrl-r` | Brings up scrollable/searchable command history

> `**` syntax has special meaning with: `unset`, `kill`, `export`, `unalias`

> `CTRL-t` anywere at CLI will bring up scrollable list.  Type to start reducing results (this is pretty awesome).

> `**` does the same thing as `CTRL-t` (but is easier to type for most of us)

***

### fzf Examples

```shell
nvim ** <tab>    # Opens a scrollable list that you can also start typing to filter the list

kill ** <tab> # Brings up list of processes you can scroll through (type to filter the list)
# With process selected, hit Enter and the PID will be populated in the command.

# Unset environment variables
unset ** <tab>   # Brings up list of environment variables

export ** <tab>

unalias **  <tab>
```

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
