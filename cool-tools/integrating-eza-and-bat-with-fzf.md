## Integrating `bat` and `eza` into `fzf` output

> This is just an example.  You can tweak this to your liking.

The settings below will cause `fzf` to use `bat` for its preview window and `eza` for previewing directories and files.

Add the following to your `~/.zshrc` or `~/.bashrc`:

> When the preview is displayed on the right-side of the terminal, you can use your mouse to scroll through the data.  How much you can scroll is controlled by the `--line-range :500` option (500 lines).

```shell
# Add to ~/.zshrc or ~/.bashrc

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
```

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

Try it:

```shell
vim <ctrl-t>
```
<img src=../assets/fzf-with-bat.png>

***

```shell
cd **<tab>

# or
# z **<tab>
```

<img src=../assets/eza-with-bat.png>
