# Customizing tmux

```shell
mkdir -p ~/.config/tmux
```

```shell
cd ~/.config/tmux

touch tmux.conf

ln -s ~/.config/tmux/tmux.conf .tmux.conf
```

```shell
vim tmux.conf
# or
# vim ~/.tmux.conf
```

***

Add the following to `tmux.conf`; save and close when done.

```shell
##########################################################################################
# CUSTOM SETTINGS
###########################################################################################
set -g mouse on                         # Mouse support: resize panes, select windows, & scrolling
set -g base-index 1                     # Start window numbering at 1 rather than 0
set -g prefix ^A                        # Sets prefix key to 'a' rather than 'b'
set -g history-limit 1000000            # increase history size (from 2,000)
set -g renumber-windows on              # renumber all windows when any window is closed
set -g detach-on-destroy off            # don't exit from tmux when closing a session
set -g set-clipboard on                 # use system clipboard
set -s escape-time 0                    # address vim mode switching delay
set -g display-time 5000                # set tmux message display duration to 5 seconds
set -g status-interval 5                # refresh status bars every 5s (rather than 15s)
set -g focus-events on                  # focus events enabled for terminals that support them
set -g display-panes-time 4000
setw -g mode-keys vi
set -g window-style 'bg=#0c0c0c,fg=#ffffff'         # Inactive panes: light black
set -g window-active-style 'bg=#010101,fg=#ffffff'  # Active pane: black
```

***

- [ ] If tmux is running, exit all sessions and then re-open it.  Confirm no sessions are running.

```shell
tmux ls
```

***

- [ ] \[Re-]Start tmux.  The settings in `tmux.conf` are applied.  Nothing will look particularly different (yet).

```shell
tmux
```

<img src=assets/tmux-custom-bg-color.png>

***

### tmux Window Numbering

Tmux indexes (numbers) its **windows** starting at zero (0) by default.  Because you can use `prefix <window #>` to cycle between windows (`prefix 0`, `prefix 1`, etc.), this creates an unnatural keyboard flow (becasue 0 is on the far right of on the keyboard).  To fix this, `set -g base-index 1` starts window numbering at one (1).

***

### Changing the tmux Prefix

- [ ] With the `set -g prefix ^A` setting, your prefix key is now `C-a` rather than `C-b`.   This is personal preference.  Many people choose to switch to `C-a` or `C-s`; it's up to you.  Set the `set -g prefix ^<value>` to whatever you want your prefix key to be.  If you prefer the default `C-b`, remove the `set -g prefic ^A` line from `tmux.conf` and refresh the config.

> Note: It is good to always remember what the defaults are so you can still use tmux on remote/new systems.

***

### Config File Reload Options

- [ ] You do not have to exit tmux to update your config file.  You can update the config file using your tmux command line or from within the tmux session (using the CLI).  Try one of those options now.

***

Example using the tmux command-line:

```groovy
prefix :

# then
source-file tmux.conf
```

Example using the CLI from within tmux:

```groovy
tmux source /path/to/tmux.conf
```

***

- [ ] Both of those `tmux.conf` update options still require a good amount of typing.  You can simplify the reloading of `tmux.conf` by adding a `bind` command to `tmux.conf`  Create a new configuration section in your `tmux.conf` file by adding:

> Note: you will have to apply this change using one of the methods from the previous step before you can use it.

```
###########################################################################################
# KEY BINDINGS
###########################################################################################
bind r source-file ~/.config/tmux/tmux.conf \; display "tmux Config Reloaded!"
```

<img src=assets/tmux-bind-r-reload-config.png>

***

- [ ] Test your ability to refresh the `tmux.conf` file using the newly mapped `prefix r` mapping.

> Note: The 'tmux Config Reloaded!' message will be displayed in the status bar for the duration defined by the `set -g display-time 5000` setting (5000 ms, 5s).

```groovy
prefix r
```

<img src=assets/tmux-tmux-config-reloaded.png>

***

### Highlighting the Active Pane

- [ ] Split the tmux window horizontally, then vertically.  You should see the active pane is a different color than the inactive pane(s).  Switch from pane to pane and see that the active pane is always a different color.

This change comes from:

```bash
set -g window-style 'bg=#0c0c0c,fg=#ffffff'         # Inactive panes: light black
set -g window-active-style 'bg=#010101,fg=#ffffff'  # Active pane: black
```

> Note: I set the color difference to be fairly subtle, just enough to be able to tell the difference between panes.  Feel free to tweak the RGB values to your liking.


```
prefix "        # Split horizontally

prefix %        # Split vertically

prefix ⬅️, prefix ⬆️, prefix ⬇️, prefix ➡️     # Move between panes
```

<img src=assets/tmux-custom-inactive-bg-color.png>

***

### Further Highlighting the Active Pane

- [ ] Add the following to `tmux.conf` in the **CUSTOM SETTINGS** section.

```shell
set -g pane-active-border-style 'fg=yellow'
set -g pane-border-style 'fg=brightblack'
```

<img src=assets/tmux-conf-pane-border-config.png>

Reload the `tmux.conf` file.

```groovy
prefix r
```

***

- [ ] Move from pane-to-pane or create new panes and you should now see additional highlighting around the border of the active pane.  This further helps to identify which pane is active.

<img src=assets/tmux-conf-pane-border-color.png>

***

### Changing Key Bindings

- [ ] Some people prefer to re-map their **window** split keys to something more intuitive than the default `prefix "` and `prefix %`.  Many prefer to use `prefix -` and `prefix \` (because `\` is the same key as `|`) to split horizontally and vertically, respectively.  Try that by adding the following to `tmux.conf`.  Add the following to the **KEY BINDINGS** section of `tmux.conf`:

> Remember to update your `tmux.conf` file (`prefix r`) after making the changes.

```shell
bind-key '-' split-window -v      # '-' horizontal window split
bind-key '\' split-window -h      # '\' vertical window split
```

<img src=assets/tmux-conf.split-window-bindings.png

***

- [ ] Test the new `prefix -` and `prefix \` bindings.  

> The old key bindings are still in place so you can use either `prefix "` or `prefix -` to split horizontally and `prefix %` or `prefix \` to split vertically.  If you want to unbind the old keys, add `unbind '%'` and `unbind "` to `tmux.conf`.

> Note: Some people (e.g. tmux super-nerds) get aggressive with tmux and unbind all keys using `unbind-key -a` and then manually bind everything to their personal preferences.   This is well beyond the scope of this lab.  Your takeaway is that you can selectively bind and unbind (i.e. change) keys to better match how you use your keyboard, what seems intuitive to you, etc.  You are not locked in to using the default, and often ambiguous, key bindings.

***

### Enabling Mouse Control

- [ ] The `set -g mouse on` setting enabled the ability to use your mouse to do the following:

* Resize frames
* Select frames
* Change between windows

Try it now.  Create two or more windows (`prefix c`) and divide them into some panes (`prefix "`, `prefix %` or your newly bound `prefix \` and `prefix -`) then use your mouse to move between the windows, frames.  Also try resizing the frames by clicking and dragging the frame line.

***

### Tweaking Pane Size

Earlier in this lab you used `prefix <space>` to cycle through different pre-set **pane** layouts.  The pre-defined layouts are different depending on how many panes you have open in a **window**.

With `set -g mouse on` in your `tmux.conf` you can use the mouse to change **pane** size similar to how you would any window on your computer.  Try that now.

***

Some people prefer to keep their fingers on the keyboard as much as possible (it speeds up your workflow).  There are key bindings for that.

- [ ] Add the following to `tmux.conf` in the the **KEY BINDINGS** section:

> Note: the `-r` means the command can be repeated.  For example, `prefix H H H H`. Each `H` press will rezise the window a little more.

```bash
bind -r H resize-pane -L                # Resize pane left
bind -r J resize-pane -D                # Resize pane down
bind -r K resize-pane -U                # Resize pane up
bind -r L resize-pane -R                # Resize pane right
```

<img src=assets/tmux-conf-resize-pane-keys.png>

Reload `tmux.conf`.

```groovy
prefix r
```

- [ ] Create a window with multiple vertical and horizontal panes.  Select a pane that has both horizontal and vertical sides and use the newly added bindings to resize the windows.

> Note: Use capital `H`, `J`, `K` and `L`.

```groovy
prefix H        # moves pane to the left (repeat H to move more)

prefix J        # moves pane to down (repeat J to move more)

prefix K        # move pane up (repeat K to move more)

prefix L        # move pane right (repeat L to move more)
```

***

### Scrolling Through History

- [ ] The `set -g history-limit 1000000` command enabled the ability for your to scroll back through your command history the way you can with a regular CLI.  Try that now.  Issue a command with a lot of output (`history`, `sudo dmesg`, `sudo cat /var/log/syslog`, etc.`) and scroll back through the command output.

The ability to scroll back is per-pane.

***

### Working in tmux Windows and Panes

> `nano` users: If you are a `nano` user, stick with me.  It is worth it.

The `setw -g  mode-keys vi` option set in `tmux.conf` enables `vi`-sytle key bindings within tmux.  In the steps below you will explore a portion of what that means.
















```shell
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

git clone https://github.com/dreknix/tmux-plugin-catppuccin.git  ~/.config/tmux/plugins/catppuccin/tmux
```


```shell
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Other examples:
# set -g @plugin 'github_username/plugin_name'
# set -g @plugin 'github_username/plugin_name#branch'
# set -g @plugin 'git@github.com:user/plugin'
# set -g @plugin 'git@bitbucket.com:user/plugin'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```

```groovy
prefix :

# then
source-file ~/.tmux.conf
```




###########################################################################################
# CATPPUCCIN THEME SETTINGS
###########################################################################################
set -g @catppuccin_flavor "mocha"  # latte, frappe, macchiato or mocha
set -g @catppuccin_window_current_text "#{window_name}"
set -g @catppuccin_window_text "#{window_name}"
set -g @catppuccin_window_status_style "rounded"
set -g @catppuccin_window_left_separator ""
set -g @catppuccin_window_right_separator " "
set -g @catppuccin_window_middle_separator " █"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_default_fill "number"
set -g @catppuccin_window_default_text "#W"
set -g @catppuccin_window_current_fill "number"
set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
set -g @catppuccin_status_modules_right "directory date_time"
set -g @catppuccin_status_modules_left "session"
set -g @catppuccin_status_left_separator  " "
set -g @catppuccin_status_right_separator " "
set -g @catppuccin_status_right_separator_inverse "no"
set -g @catppuccin_status_fill "icon"
set -g @catppuccin_status_connect_separator "no"
set -g @catppuccin_directory_text "#{b:pane_current_path}"
```

| Command                                       | Description                                                                                          |
|-----------------------------------------------|------------------------------------------------------------------------------------------------------|
| `set -g mouse on`                             | Enables mouse support for resizing panes, selecting windows, and scrolling in tmux.                 |
| `set -g base-index 1`                         | Starts window numbering at 1 instead of 0, making numbering more intuitive.                         |
| `set -g prefix ^A`                            | Changes the tmux prefix key from `Ctrl-b` to `Ctrl-a` for easier access.                            |
| `set -g history-limit 1000000`                | Increases the scrollback history buffer size from 2,000 lines to 1,000,000 lines.                   |
| `set -g renumber-windows on`                  | Automatically renumbers windows sequentially when a window is closed.                               |
| `set -g detach-on-destroy off`                | Prevents tmux from exiting when the last session is closed.                                          |
| `set -g set-clipboard on`                     | Allows tmux to use the system clipboard for copy-paste operations.                                   |
| `set -s escape-time 0`                        | Eliminates delays when switching between modes (e.g., in Vim or similar applications).               |
| `set -g display-time 5000`                    | Sets the duration for tmux on-screen messages (e.g., status updates) to 5 seconds.                  |
| `set -g status-interval 5`                    | Refreshes the tmux status bar every 5 seconds instead of the default 15 seconds.                    |
| `# set -g status-keys emacs`                  | (Commented out) Would switch key bindings for the tmux status line to Emacs-style if uncommented.    |
| `set -g focus-events on`                      | Enables focus events, allowing terminals to notify tmux when they gain or lose focus.               |
| `set -g pane-active-border-style 'fg=magenta,bg=default'` | Sets the border color for the active pane to magenta with no background color change.                |
| `set -g pane-border-style 'fg=brightblack,bg=default'`       | Sets the border color for inactive panes to bright black with no background color change.            |


##########################################################################################                                                                     [0/0]
# CUSTOM SETTINGS
###########################################################################################
set -g mouse on                         # Mouse support: resizing panes, selecting windows, & scrolling
set -g base-index 1                     # Start window numbering at 1 rather than 0
set -g prefix ^A                        # Sets prefix key to 'a' rather than 'b'
set -g history-limit 1000000            # increase history size (from 2,000)
set -g renumber-windows on              # renumber all windows when any window is closed
set -g detach-on-destroy off            # don't exit from tmux when closing a session
set -g set-clipboard on                 # use system clipboard
set -s escape-time 0                    # address vim mode switching delay
set -g display-time 5000                # set tmux message display duration to 5 seconds
set -g status-interval 5                # refresh status bars every 5s (rather than 15s)
set -g focus-events on                  # focus events enabled for terminals that support them
set -g window-style 'bg=#0c0c0c,fg=#ffffff'         # Inactive panes: light black
set -g window-active-style 'bg=#010101,fg=#ffffff'  # Active pane: black