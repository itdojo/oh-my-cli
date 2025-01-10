**prefix** = `ctrl-a`  (`set -g prefix ^A` in tmux config file)

| Action | How <br/>(`prefix + ___`) |
|:--|:--|
| Create new window | `c`
| Close current window | `&`
| Move between windows | `n`, `p` <br/>  window # 
| Rename current window | `,`
| Open Window Manager | `w`
| Split window horizontally | `"`
| Split window vertically | `%`
| Move between panes | `→`, `←`, `↑`, `↓`
| Close a pane | `x`
| Zoom in on pane (maximize) | `z`
| Swap panes left/right | `{` & `}`
| Show/Select pane numbers | `q` or `q #`
| Rename session | `$`
| Detach from session | `d`
| Open Session Manager | `s`
| Switch between sessions | `(` (left) <br/> `)` (right)
| tmux command line | `:` + `command`
| toggle pane layout | spacebar

***

## tmux command-line
`prefix :` then:

| Action | How to do
|:--|:--|
| Create session | `new` <br/> `new-session`
| Rename session | `rename-session new_name`
| Rename window | `rename-window new_name`
| Detach from session | `detach`
| Reload a tmux config | `source path/to/file`
| 

***

## tmux shell commands

From Linux shell

| Action | How to do | 
|:--|:--|
| New session | `tmux` or `tmux new` <br/> `tmux new-session`
| List sessions | `:tmux ls`
| Attach most recent session | `tmux a` <br/> `tmux attach`
| Attach session by name | `tmux a -t session_name` <br/> `tmux attach -t session_name`
| Kill session | `tmux kill-session -t session_name`

## tmux copy mode

> Requires `setw -g mode-keys vi` in `tmux.conf`

| Action | How (`prefix + ___`) | 
|:--|:--|
| Enter copy mode | `[`
| Search for string | `/string` (down) <br/> `&string` (up)
| Start selecting text | spacebar
| Copy selection | `y` or Enter
| Paste selection | `]`
| Goto top / bottom | `g` (top) <br/> `G` (bottom)
| Cursor left, down, up, right | `h`, `j`, `k`, `l`<br/>⬅️, ⬇️, ⬆️, ➡️
| Word jump | `w` (forward) <br/> `b` (back)