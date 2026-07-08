# Commenting & Uncommenting Blocks of Text in vim

There are several ways to comment/uncomment blocks of text in vim.  Methods 1–3 work in ***any*** vim, with no plugins.  Method 4 uses the comment plugin that ships built-in with newer versions of vim.

## Method 1: Visual Block Mode (works everywhere)

### Comment

1. `ESC` to **Normal Mode**
2. Move to the first line of the block, then `CTRL-v` (**Visual Block Mode**)
3. Select lines (first character on each line) using `j`/`k` (or ⬆️ ⬇️)
4. `SHIFT-i` (capital `I`, insert at beginning) (highlighting disappears; only the first line will appear to have a cursor; it's OK)
5. Type `# ` (or whatever comment character your language uses)
6. `ESC` to apply to all selected lines

<img src=https://dojolabs.s3.amazonaws.com/vim/vim-uncommented-text.png>
<br/>
<img src=https://dojolabs.s3.amazonaws.com/vim/vim-commented-text.png>

### Uncomment

1. `ESC` to **Normal Mode**
2. Move to the first `#`, then `CTRL-v` (**Visual Block Mode**)
3. Select the column of `#` characters (and the trailing space, if you added one — use `l` to widen the selection) using `j`/`k` (or ⬆️ ⬇️)
4. `x` or `d` to delete the selected characters

<img src=https://dojolabs.s3.amazonaws.com/vim/vim-commented-text.png>
<br/>
<img src=https://dojolabs.s3.amazonaws.com/vim/vim-uncommented-text.png>

***

## Method 2: Range Substitution (great when you know the line numbers)

Comment lines 10-20 by inserting `#` at the start of each line:

```vim
:10,20s/^/#/
```

Uncomment the same lines (remove a leading `#`):

```vim
:10,20s/^#//
```

> Note: The uncomment version errors with `E486: Pattern not found` if any line in the range does not start with `#`.  Add the `e` flag to ignore those lines: `:10,20s/^#//e`

> Tip: After selecting lines in **Visual Line Mode** (`V`), just type `:` — vim pre-fills the range as `:'<,'>` and you can complete it as `:'<,'>s/^/#/`.

***

## Method 3: The `:normal` Command

Run a **Normal Mode** keystroke sequence on a range of lines.  `I#` means "insert `#` at the beginning of the line":

```vim
:10,20norm I#
```

Uncomment by deleting the first non-blank character of each line (`^x`):

```vim
:10,20norm ^x
```

> Caution: `norm ^x` blindly deletes the first non-blank character — only run it on lines you know are commented.

***

## Method 4: The Built-in Comment Plugin (vim 9.1.0375+ / Neovim 0.10+)

Newer versions of vim ship an optional comment plugin (added May 2024).  Check whether your vim has it:

```vim
:echo has('patch-9.1.0375')   " 1 = yes, 0 = too old
```

> Note: Stock vim on Ubuntu 24.04 (9.1.0016) predates this plugin.  Debian 13+, vim 9.2+, and Homebrew vim all have it.  **Neovim** has this functionality built-in and enabled by default since 0.10 — no setup needed.

Enable it (add the `packadd` line to `~/.vimrc` to make it permanent):

```vim
:packadd comment
```

The plugin is *comment-aware*: it toggles, uses the right comment string for the file type, and works with counts and motions:

| Command | What it Does
|:--|:--|
| `gcc` | Toggle comment on the current line
| `gc{motion}` | Toggle comment over a motion (Ex: `gcip` = comment the paragraph, `gc3j` = comment 3 lines down)
| `gc` (in **Visual Mode**) | Toggle comment on the selected lines

If your vim is too old for the built-in plugin, [tpope/vim-commentary](https://github.com/tpope/vim-commentary) provides the same `gcc`/`gc` mappings as an installable plugin.
