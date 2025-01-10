
## tmux Hierarchical Layout
```groovy
*** tmux session *************************************************************************
*  --- tmux window --------------------------------------------------------------------  *
*  | +++ tmux pane ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | +                                                                              + |  *
*  | ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ |  *
*  | +++ tmux pane ++++++++++++++++++++++++++++ tmux pane +++++++++++++++++++++++++++ |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | +                                      +                                       + |  *
*  | ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ |  *
*  ------------------------------------------------------------------------------------  *
******************************************************************************************
```

- A tmux **session** is a collection of **windows**.
- A tmux **window** is a collection of **panes**.

***
# tmux

**prefix** = `ctrl-a`  (`set -g prefix ^A` in tmux config file)

| Action | How (`prefix + ___`) |
|:--|:--:|
| Create new window | `c`
| Rename current window | `,`
| Split window horizontally | `"`
| Split window vertically | `%`
| Close current window | `&`
| Close a pane | `x`
| Zoom in on a pane (maximize it) | `z`
| Detach from session | `d`
| Open Session Manager | `s`
| Session Manager with window preview | `w`
| Switch between sessions (`s` is easier) | `(` and `)`
| Move between windows | `n` or `p`
| Move between panes | `→`, `←`, `↑`, `↓`
| tmux command line | `:` + `command`

***

## tmux command-line
`prefix :` then:

| Action | How to do
|:--|:--|
| Create session | `new` or `new-session`
| Rename session | `rename-session new_name`
| Rename window | `rename-window new_name`
| Detach from session | `detach`
| Reload a tmux config file after edits | `source path/to/file`
| 

***

## tmux shell commands

From Linux shell:

| Action | How to do | 
|:--|:--|
| New session | `tmux` or `tmux new` or `tmux new-session`
| List sessions | `tmux ls`
| Attach to most recent session | `tmux a` or `tmux attach`
| Attach to a session | `tmux a -t session_name` or `tmux attach -t session_name`
| Kill session | `tmux kill-session -t session_name`


## tmux Customization

Create `~/.tmux.conf` or a config file at `~/.config/tmux/tmux.conf`.
 > These steps assume `~/.tmux.conf`.

- [ ] Clone TPM (tmux plugin manager)

```shell
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```




