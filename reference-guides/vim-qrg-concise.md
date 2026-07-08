## Normal Mode

| Command | What it Does... |
|:--:|:--|
| `h` | left (left arrow)
| `j` | down (down arrow)
| `k` | up (up arrow)
| `l` | right (right arrow)
| `w` | forward a word
| `b` | back a word
| `0` | goto beginning of line (column 1)
| `^` | goto first non-blank character of line
| `$` | goto end of line
| `gg` | goto first line 
| `G` | goto last line
| `H` | jump to top of visible screen
| `L` | jump to bottom of visible screen
| `M` | jump to middle of visible screen
| `{` | jump backward a paragraph/block of code
| `}` | jump forward a paragraph/block of code

> Most motions accept a count: `5j` = down 5 lines, `3w` = forward 3 words

***

## Undo, Redo & Repeat

| Command | What it Does... |
|:--:|:--|
| `u` | undo last change (repeat to keep undoing)
| `Ctrl-r` | redo (undo the undo)
| `.` | repeat last change

***

## Insert Mode

| Command | Insert Mode at... |
|:--:|:--|
| `i` | cursor position
| `I` | beginning of line
| `a` | after cursor
| `A` | end of line
| `o` | below current line (adds new blank line)
| `O` | above current line (adds new blank line)

***

## Visual Mode

| Command | Select text...
|:--|:--|
| `v` | character-by-character
| `V` | line-by-line
| `Ctrl-v` | by rectangular blocks

> Note: `y`, `"+y`, `d`, `"+d` after selecting

***

## Command-Line Mode

| Command | What it Does...
|:--|:--|
| `:#` | go to line `#`
| `:w` | write (save file)
| `:q` | quit (close)
| `:wq` | write & quit (close)
| `:q!` | quit without saving
| `/<string>` | forward search (down document)  `n` next instance, `N` previous instance
| `?<string>` | backward search (up document)
| `:!<command>` | run a shell command without leaving vim (Ex: `:!ip addr show`)
| `:%s/old/new/g` | search for all `old` and replace with `new` globally (`g`)
| `:set number` | turn on line numbers
| `:set nonumber` | turn off line numbers
| `:set relativenumber` | numbers lines above/below relative to cursor position
| `:set norelativenumber` | turns off relative line numbers

***

## Yank, Delete & Paste Actions

| Action | Command | What it Does
|:--|:--|:--|
| Copy (Yank) | `yy` | Yank (copy) current line to unnamed register
| | `y{motion}` | `y$` yank to end of line, `y^` yank to beginning of line).
| | `y#y` | Yank `#` lines down.  Ex: `y8y` = yank (copy) 8 lines down from current line (including current line)
| | `y#k` | Yank `#` lines up. Ex: `y20k` = yank (copy) 20 lines up from current line (including current line)
| | `"+y` | Yank (Copy) to ***system clipboard*** (+ register).
| Cut (Delete) | `dd` | Cut (delete) current line (into unnamed register).
| | `d{motion}` | `d$` cut to end of line, `d^` cut to beginning of line.
| | `d#d` | Delete (Cut) `#` lines down.  Ex: `d8d` = delete (cut) 8 lines down from current line (including current line)
| | `"+d` | Cut text to ***system clipboard***.
| Paste | `p` | Paste [unnamed] register ***after*** cursor
| | `P` | Paste before cursor
| | `"+p` | Paste from ***system clipboard***