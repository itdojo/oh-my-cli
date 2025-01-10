
- [ ] Check if tmux is installed.  Install if necessary.

```bash
# Linux
if ! command -v tmux >/dev/null 2>&1; then sudo apt update && sudo apt install -y tmux; else echo "tmux is already installed."; fi

# MacOS
if ! command -v tmux >/dev/null 2>&1; then brew install tmux; else echo "tmux is already installed."; fi
```

- [ ] Start a new tmux session.

> You can visually tell the tmux session is running because the bottom of the terminal shows a green bar with `[0] 0:bash*` on the left-hand side.

```bash
tmux
```

<img src=../assets/tmux-basic.png>

***

Commands are sent to tmux using 'prefix' followed by a keystroke.  The default 'prefix' is 'CTRL-b', which this lab refers to simply as '***prefix***'.

Some simple navigation:

## Working with Default Key Bindings

### Why You Care About Default Key Bindings

| Truth # | Why
|:--:|:--|
| 1 | On your personal machine, you will likely customize these commands to your liking, making many of the default bindings irrelevant.
| 2 | When connecting to remote machines you are unlikely to change the tmux commands from their defaults so knowing them is important.

***

### Horizontal Split

Answers the question: 
*How do I visually divide my session window so I can see multiple things happening at once?*

- [ ] Split the window horizontally into two panes.

```
prefix "     # CTRL-b, then "
```
<img src=../assets/tmux-horizontal-split.png>

***

### Vertical Split

- [ ] Split the pane vertically into two panes.

```
prefix %
```

<img src=../assets/tmux-vertical-split.png>

***

### Moving Between Panes in a Window

- [ ] Move between the panes using `prefix` and arrow keys. Try it.

***

### Closing a Pane

- [ ] Select the bottom pane and use `prefix x` to kill (close) it.  You will be prompted to confirm.

```
prefix x
```

<img src=../assets/tmux-kill-pane-confirm.png>

<br/>

You once again have a single pane in your window.

<img src=../assets/tmux-basic.png>

***

## tmux Command Line

tmux has its own command line, which you access using `prefix :`

- [ ] Open the tmux command line using `prefix :`.
- [ ] From the tmux command line, use a command to turn the status bar off with `set status off`.  The green status bar will disappear.

> Note: This is just to demonstrate how the tmux command-line works: `prefix :`, then type a command.

```
prefix :

# then
set status off
```

<img src=../assets/tmux-command-line.png>

<br/>

<img src=../assets/tmux-set-status-off.png>

*** 

- [ ] Turn the status bar back on using `prefix :`, then `set status on`.

```
prefix :

# then
set status on
```

<img src=../assets/tmux-set-status-on.png>

***

### tmux Command-Line Menus

The tmux command-line will display menus to simplify entering commands.  Try the following:

> Use the arrow keys to scroll through the menu options.

```
prefix :

# then
new<tab>

# Press ESC to close the command window without selecting anything.
```

<img src=../assets/tmux-command-line-new.png>

*** 

```
prefix :

# then
kill<tab>

# Press ESC to close the command window without selecting anything.
```

<img src=../assets/tmux-command-line-kill.png>

***

If you are not sure of the command you can type the first letter to get a list of commands that begin with that letter.

```
prefix :

# then
d<tab>
```

<img src=../assets/tmux-command-line-d.png>

***

- [ ] Use the tmux command-line to rename your current window to `first`.

```
prefix :

# then
rename-window first
```

<img src=../assets/tmux-command-line-rename-window.png>

<br/>

<img src=../assets/tmux-command-line-rename-window-first.png>

***

## Pane Zoom

Answers the question: *How do I temporarily view this pane in 'full screen' mode?*

You can zoom in on any selected pane using `prefix z`.  This will cause that pane to take up the full window until you press `prefix z` to zoom back out.

Test the zoom feature as follows:

- [ ] Split the window into two horizontal panes using `prefix "`.

- [ ] In the top pane, start a ping to 1.1.1.1 or 8.8.8.8.

```bash
ping 1.1.1.1
```

- [ ] Use the arrow keys to move to the bottom pane (`prefix ⬇️`).  Once in the bottom pane, run `htop`.

```bash
htop
```

<img src=../assets/tmux-two-panes-ping-top.png>

***

- [ ] Zoom in on the ***ping*** pane.  To zoom in on a pane:
    * Navigate to the pane using `prefix` + ⬆️, ⬇️, ⬅️ or ➡️
    * Zoom using `prefix z`.
    * Zoom back out using `prefix z`.

```
prefix z    # zoom in on a pane

prefix z    # zoom back out
```

Zoomed in on ***ping*** pane:

<img src=../assets/tmux-zoom-ping-pane.png>

***

- [ ] Zoom in on the ***htop*** (command) pane.  To zoom in on a pane:
    * Navigate to the pane using `prefix` + ⬆️, ⬇️, ⬅️ or ➡️
    * Zoom using `prefix z`.
    * Zoom back out using `prefix z`.

```
prefix z  # to zoom in on a pane

prefix z  # to zoom back out
```

Zoomed in on ***htop*** pane:

<img src=../assets/tmux-zoom-top-pane.png>

***

## Renaming tmux Sessions

Answers the question: *How do I name my sessions so I can keep them better organized?*

The default session name is the number of the session the order in which it was created (i.e. **0**, **1**, **2**, etc.); not very intuitive.  If you use multiple sessions, giving them meaningful names can be very helpful in your workflows.

- [ ] Change the name of the current tmux session to **ssh-comms**.

```
prefix :

# then

rename-session ssh-comms
```

<img src=../assets/tmux-rename-session1.png>

<br/>

<img src=../assets/tmux-rename-session2.png>

***

## Detaching from a tmux Session (returning to the CLI)

Answers the question: *How do I detach from this session to return to the CLI?*

Detaching from a tmux session returns you to your shell (bash, zsh, etc.) but ***does not*** terminate the tmux session.

- [ ] From ***within*** a tmux session, run `tmux detach` to detach from the session.

> You can also use `prefix d` to detach from a session.

```bash
tmux detach

# or 

prefix d
```

<img src=../assets/tmux-tmux-detach-session.png>

***

## Viewing Running tmux Sessions

Answers the question: *What tmux sessions do I have running?*

- [ ] From the shell, run `tmux ls` to view current tmux sessions.

```bash
tmux ls
```

<img src=../assets/tmux-tmux-ls.png>

***

## Attaching to a Running tmux Session

`tmux a` or `tmux attach` from the shell will attach you to your most recent running tmux session.

- [ ] Attach to your running session using `tmux attach`.

```bash
tmux attach

# or
# tmux a
```
<img src=../assets/tmux-tmux-attach.png>

<br/>

<img src=../assets/tmux-back-in-tmux-session.png>

`tmux attach` connects you to your most recent tmux session.  If you have more than one tmux session, use `tmux attach -t <session_name>` to attach to the desired session.

***

## Create a New tmux Session

- [ ] Detach from your current tmux session:  `tmux detach` or `prefix d`.

- [ ] From your shell, use `tmux new -s <session_name>` to create a new named tmux session named **server**.

```bash
tmux new -s server
```

<img src=../assets/tmux-new-named-session-creation.png>

<br/>

<img src=../assets/tmux-new-named-tmux-session.png>

***

- [ ] Run `echo server session` to mark the session.

```bash
echo server session
```

<img src=../assets/tmux-echo-server-session.png>

*** 

- [ ] Detach from the **server** session.

```
prefix d
```

*** 

- [ ] From the CLI, view your current sessions.  There should be two (2): **ssh-comms** and **server**.

```bash
tmux ls
```

<img src=../assets/tmux-two-tmux-sessions.png>

*** 

- [ ] Create a third session named **local**.

```bash
tmux new -s local
```

<img src=../assets/tmux-create-3rd-session.png>

<br/>

<img src=../assets/tmux-new-local-session.png>

***

- [ ] Run `echo local session` to mark the session

```bash
echo local session
```

<img src=../assets/tmux-echo-local-session.png>

***

## Moving Between tmux Session

Sessions are independent of each other but you can move between them.

There are a few ways to move between tmux session.  They are:

### Session Switch Method #1

Detach from a session (`tmux detach` or `prefix d`) then attach to the desired session using `tmux attach -t <session_name>`.

- [ ] Do that now.  Detach from the **local** session and then use `tmux ls` (to show available sessions) and `tmux attach -t server` to attach to the **server** session.

<img src=../assets/tmux-detaching-server-session.png>

<img src=../assets/tmux-switch-between-sessions.png>

<img src=../assets/tmux-attached-to-local-session.png>

***

### Session Switch Method #2

From within a session, switch between sessions using `prefix )` and `prefix (`.  This syntax will move you 'left' and 'right' through your sessions.

- [ ] Do that now.  You should currently be in your **local** session.  Use `prefix (` to move the the session on your 'left'.  This should take you to your **ssh-comms** session (look in bottom left corner for the session name).

Ues `prefix (` again move to the next session. This should take you to the **server** session.

Ues `prefix (` again to move to the next session. This will take you to the **local** session.  Notice that you are looping around the sessions.

Use `prefix )` to move to the 'right' a session.

Stop when are once again at your **local** session.

***

### Session Switch Method #3

**tmux Session Manager**: Use `prefix s` to bring up the tmux Session Manager then use the arrow keys to select the session you want.  The bottom pane display a preview of what is running in the selected session.

<img src=../assets/tmux-session-manager.png>

***

- [ ] Using the tmux Session Manager, navigate to the **server** session.

***

- [ ] Divide the **server** session window into three (3) panes as shown below.

<img src=../assets/tmux-server-3-panes.png>

***

- [ ] Task the **server** panes as follows:
* Top right pane: `ping localhost`
* Bottom pane: `htop`.
* Top left pane:  free/nothing

<img src=../assets/tmux-server-3-pane-tasks.png>

***

- [ ] Leave the **server** tasks running.  Use tmux Session Manager to switch the **local** session.

- [ ] Divide the **local** session window into two vertical panes.  Task the panes as follows:
* Top pane: `watch ss -tn`
* Bottom pane: `sudo tail -f /var/log/syslog`

<img src=../assets/tmux-local-session-2-panes.png>

<br/>

<img src=../assets/tmux-local-session-2-panes-with-tasks.png>

***

- [ ] Go to the top pane of the **local** session (the one running `watch ss -tn`) and divide the pane into two vertical panes (you do not have to stop the atch command).  Leave the new pane free (no command running.)

Your **local** session should look like this:

<img src=../assets/tmux-local-session-3-panes.png>

Leave the tasks in the **local** session running.

***

- [ ] Bring up the tmux Session Manager (`prefix s`).  Select the **server** session and press the right arrow key ➡️.  A sub-option will appear labeled `+ 0: bash*`.  The `0` means this is ***window*** zero (0) in the **server** session. The preview window at the bottom will show you one of the panes (pane 0) in the **server** session.

<img src=../assets/tmux-session-manager-layout.png>

***

- [ ] Arrow down ⬇️ to the **server** window zero (0) and press the right arrow ➡️.  This will expand each of the avaiable panes in this window.  At the bottom you will see a preview of the different panes currently open in the **server** session.

<img src=../assets/tmux-local-session-manager-3-panes.png>

If you select the ***window*** and press enter you will return to the window with all the panes. (your original view of the session).

When you select one of the panes, the session window will open with that pane selected.

- [ ] Try that now:
1. Select the **server** session window and press enter.  

You should see this:

<img src=../assets/tmux-server-session-window-selected.png>

***

2. Re-open tmux Session Manager (`prefix s`) and use the arrow keys to select the **server** session --> ***window*** 0 --> then the `htop` ***pane***.  

You should see a preview of the `htop` program running in the pane; similar to the image below:

<img src=../assets/tmux-session-manager-top-pane-selected.png>

***

- [ ] Re-open tmux Session Manager and select the open window in the **local** session.  With the ***window*** selected you should see each of the three panes in the bottom preview.  Notice that each has a number in the center of the preview (0, 1, 2).  These are to help you ID the desired pane.

<img src=../assets/tmux-local-session-pane-numbers.png>

> Note: tmux Session Manager uses a relative indexing (numbering) system for its **sessions**, **windows** and **panes**.  These indexes are in parenthesis on the left margin of the Session Manager window.  
In the screen shot below the index numbers are from `(0)` thru `(6)`.  You can press one of these number to go to that **session**, **window** or **pane**.  Note that these number are relative; they will change as more sessions are expanded in Session Manager.

<img src=../assets/tmux-dynamic-index-values.png>

- [ ] Try that now.  Select the index number that will take you to the **bash** pane in window 0 in the **local** session.  In the image above, that number is ***5***.  Your number may be different.  The end result is that you are taken to the **session** **window** and the desired **pane** is selected for your use.

***

## Moving Between tmux Panes in a Window

Earlier you used `prefix ➡️`, `prefix ⬇️`, `prefix ⬆️` and `prefix ⬅️` to move between panes within a **session** **window**.

You can also use `prefix q` to identify pane numbers and navigate between them.

- [ ] Try that now.  With the **local** session displayed, press `prefix q`.  A number will briefly appear over each of the panes.  If you press the number of the desired pane (while it is displayed, you have to be quick), your focus will be moved to that pane.

> Note: By default, numbers appear for one (1) second.  This can be annoying.  You can set the value using `tmux set-option display-panes-time <milliseconds>`.  For example, `tmux set-option display-panes-time 4000`.

<img src=../assets/tmux-display-pane-numbers.png>

```
prefix q, then 0

prefix q, then 1

prefix q, then 2
```

***

## Swapping Panes in a tmux Window

Sometimes your panes are not aligned in an optimal way.  This can crowd the output, making it difficult to read, etc.  You can swap the position of panes.

- [ ] Close all but the last pane in your **server** session.  You can close a pane by running `exit` from the pane or by using `prefix x` when the pane is selected.

<img src=../assets/tmux-server-session-single-pane.png>

***

- [ ] Divide your **server** session window into two horizontal panes.

```
prefix "
```

- [ ] If not already there, move to the bottom pane (`prefix ⬇️`) and divide that pane into two horizontal panes (`prefix "`).

```
prefix ⬇️

# then

prefix "
```

***

- [ ] Move to the top pane and divide it into two vertical panes.

```
prefix %
```

***

- [ ] Your window should now be divided into panes that look like the image below:

<img src=../assets/tmux-server-session-4-panes.png>

***

- [ ] Move to pane zero (0) per the pane labels in the image below.  To do so, use `prefix + <arrow>` or `prefix q`, then `0`.

<img src=../assets/tmux-show-4-pane-numbers.png>

*** 

- [ ] In pane `0`, run `htop`.  Move to pane `1` and run `watch ss -tn`.

<img src=../assets/tmux-top-pane0-ss-pane1.png>

- [ ] Move to pane 0 and swap pane 0 with pane 1.  From pane 0, `prefix }`.

`prefix }` - Moves a pane to the right
`prefix {` - Moves a pane to the left

After the pane swap:

<img src=../assets/tmux-top-panes-after-swap.png>

***

- [ ] Move your focus to pane 3.

```
prefix q, then 3

# or

prefix <arrow> as needed to get to pane 3
```

***

- [ ] From pane 3, swap pane 1 to pane 3.

```bash
# Syntax:
# tmux swap-pane -s <source_pane> -t <target_pane>

tmux swap-pane -s 1 -t 3
```

Before swap:

<img src=../assets/tmux-before-pane-swap.png>

<br/>

After swap:

<img src=../assets/tmux-after-pane-swap.png>

***

- [ ] Using `prefix {`, attempt to swap pane 0 with pane 2 using `prefix {`.  

> Note: The pane does not go where you want.  Instead of going to pane 2, it swaps with pane 3.  This is because the panes swap in a loop based on their numbers.  Pane 0 moved left with `prefix {` loops back around to pane 3.

Before swap:

<img src=../assets/tmux-after-pane-swap.png>

After swap:

<img src=../assets/tmux-pane-swap-gone-wrong.png>

***

- [ ] You have a few choices on how to get the panes the way you want.  

**Choice #1** - Use `prefix {` again to move pane 3 to pane 2.  Go to pane 0 and move it back to pane 3 using `prefix }`

**Choice #2** - Use `prefix {` to move `htop` back to pane 3 then go to pane 2 and run `tmux swap-pane -s 0 -t 2`.

**Choice #3** - Return to pane 0 and use `prefix {` to move `htop` back to pane 3.

- [ ] Pick one of those options and do it.  The end result should look like the screen shot below.

<img src=../assets/tmux-panes-in-correct-layout.png>

***

## Killing tmux Sessions

There are a variety of ways to kill tmux sessions.  In the steps below you will explore them.

### Session Kill Method #1

- [ ] From the **server** session, use either `exit` or `prefix x` from each pane to kill them all one-by-one.  When the last one is killed, the session will be killed and you will be returned to the CLI.  Once you are back to the CLI, use `tmux ls` to confirm your **server** tmux session is gone.

<img src=../assets/tmux-server-session-killed.png>

***

### Session Kill Method #2

- [ ] From the CLI, attach to the **ssh-comms** session.

```bash
tmux attach -t ssh-comms
```

- [ ] Open the tmux command line (`prefix :`) and run `kill-session`.  The session will be killed and you will be returned to the CLI.  Run `tmux ls` to confirm the **ssh-comms** session is gone.

```
prefix :

# then
kill-session
```

```bash
# Confirm from the CLI
tmux ls
```

***

### Session Kill Method #3

- [ ] From the CLI, use `tmux ls` to determine the session name/number you want to kill.  The **local** session is the only only one remaining.

- [ ] Kill the **local** session using `tmux kill-session -t local`.

<img src=../assets/tmux-kill-session-local.png>

***

- [ ] Before continuing to the next section, make sure there are no tmux **sessions** running on your computer.

***

## Sessions, Windows & Panes

When you run `tmux` a new **session** is created.  A session is the outermost portion of tmux running on your computer; think of it as a 'container' for a group of **windows** and **panes**.

You can run multiple different tmux **sessions** on your computer, each independent of the other.

A **session** can have one for more **windows**.  A session always has at least one (1) window.

A **window** can be divided into multiple **panes**.  By default, every **window** has a single pane.  The number of panes a **window** can be divided into is limited more by screen real estate than anything else.

How you use **sessions**, **windows** and **panes** is mostly a matter of personal preference for your workflows.  The more you use tmux, the more you will develop your own personal style for managing your **sessions**.

***

## tmux Visual Hierarchy

The image below is a single tmux **session**, showing one **window** that has three *panes**.

```
## tmux Hierarchical Layout

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

- A tmux **session** is a collection of one or more **windows**.
  - You can have multiple **sessions**.
  - If a **session** is running, it has at least one **window**.
  - Each **session** can have multiple **windows** and always has at least one.
  - A **windows** cannot exist independent of a **session**.
- A tmux **window** is a collection of **panes**.
  - By default a **window** consists of a single **pane**
  - **panes** do not exist without a supporting **window**
  - Each **window** can have multiple **panes**.
  - Each **window** always has at least one **pane**.

How you use **sessions**, **windows** and **panes** is ultimately a matter of personal preference. Shows below are some possible ways in which they can be used. 

## Use-Case Example #1

Multiple **sessions**, each dedicated to a specific remote system.  For example, you can create three (3) sessions named ***RPi-1**, **RPi-2** and **wg-server**.

Session #1: **RPi-1**
Windows: 1
    Window #1 is an SSH connection to the device.
Panes: 2
    Windows #1 is divided into two (3) panes.  Panes are split horizontally, then one of those is split vertically.
        Pane #1: Runs a custom, long-running, script that displays SSIDs being probed for in the 802.11 RF environment.
        Pane #2: Displays realtime GPS data
        Pane #3: A terminal window for executing other commands.

Session #2: **RPi-2** 
    1 Window, 2 panes, just like in Session #1.

Session #3: **wg-server** 
Windows: 3
    Window #1 - 2 Panes, split horizontally
        Pane #1: A continuously running display of wireguard statistics (`sudo watch pivpn -c`)
        Pane #2: A continuously running tool like `bmon -p wg0` or `sudo vnstat -l -i wg0` to monitor network traffic on the wg0 interface.
    Window #2 - 2 Panes, split horizontally
        Pane #1 - `sudo tail -f  /var/log/auth.log | grep -i user` to watch who is attempting to run command on the system (and what command they are running)
        Pane #2 - `sudo tail -f /var/log/syslog` to watch system events.
    Window #3 - 2 Panes, split horizontally
        Pane #1 - a CLI to run arbitrary commands
        Pane #2 - `sudo watch ss -tnp` to display active connections and the proccesses involved in the connection.


## Use-Case Example #2

Managing/Configuring AutoSSH

One **session** with multiple named **windows**, each divided into multiple panes.
Session name: autossh
Windows #1:
    Name: digitalocean
        Pane #1: `watch ss -tn`
        Pane #2: `watch ss -tln`
        Pane #3: CLI for arbitrary commands
Window #2: 
    Name: autossh-server
        Pane #1: `watch -ss tn`
        Pane #2: CLI for arbitrary commands
Window #3:
    Name: ssh-client
        Pane #1: `watch ss -tn`
        Pane #2: `CLI for arbitrary commands

## Use-Case Example #3

Monitoring multiple remote Kismet servers using Kismet API websockets

One **session** with one **window** divided into four (4) panes: 2 horizontal panes, one of which is divided into three vertical panes.
Window #1: 
    Pane #1 (vertical pane #1): websocket connection to remote Kismet server #1
    Pane #2 (vertical pane #2): websocket connection to remote Kismet server #2
    Pane #3 (vertical pane #3): websocket connection to remote Kismet server #3
    Pane #4 (horizontal pane): CLI for running arbitrary commands.

* You could vary this layout by moving the CLI pane to its own separate window.
* You could also add an additional **windows** divided into three (3) panes, each an SSH connection to the three remote Kismet servers.
* Alternately, you could have a window for each SSH connection.  It's up to you.

***

## Where Should tmux Run?  Locally or Remotely?  Or Both?

This is an involved conversation best tackled via discussion rather than lab steps that will make this lab much too long.

But know there is a time and place for all three to be used.  It depends on what you are doing.

In a majority of cases, however, running tmux on your local client is the least complicated option.

***

## tmux Windows

- [ ] On your local computer start a tmux session named **RPis**.

```bash
tmux new -s RPis
```

<img src=../assets/tmux-new-rpi-session.png>

***

To reiterate, what you are looking at right now is a **session** with a single **window** that has one **pane**.  But it looks like a regular CLI session running in tmux.

- [ ] Divide the window into two (2) vertical panes.

```
prefix %
```

<img src=../assets/tmux-rpi-window1-2panes.png>

***

- [ ] Change the name of the **window** to ***dojoPi***.  There are at least two (2) ways to do this:

1.  `prefix ,` then backspace out the old name and enter a new name.
2.  `prefix :` to open a tmux command line, then `rename-window <name>`

Pick one and rename the window.

<img src=../assets/tmux-rpi-session-renamed-window.png>

***

- [ ] Mark the window using `echo dojoPi window`.

***

- [ ] Create a second window in the session.  There are at least two (2) way to do this:

> Note: The asterisk (**\***) next to the **window** name indicates the current/active **window**.

1. `prefix c`
2. `prefix :` to open a tmux command line, then `new-window`

<img src=../assets/tmux-rpi-session-2windows.png>

***

- [ ] Rename the new **window** to ***gateworks***.

> Note: The asterisk (**\***) next to the **window** name indicates the current/active **window**.

<img src=../assets/tmux-rpi-session-gateworks-window.png>

***

- [ ] Mark the window using `echo gateworks window`.

***

- [ ] Split the **gateworks*** window into two horizontal panes.

```
prefix "
```

<img src=../assets/tmux-rpi-gateworks-window-split.png>

***

- [ ] Create a third **window** and name it ***digitalocean***.  Split the window into four (4) panes.

```
prefix c    # creates window

prefix , then enter new name

prefix "    # splits window horizontally

prefix %    # splits window vertically

prefix ⬇️    # moves down to next pane

prefix %    # splits vertically
```

<img src=../assets/tmux-rpi-session-digitalocean-4-panes.png>

***

- [ ] Mark the window using `echo digitalocean window`.

***

## Navigating Between Windows

There are at least four (4) ways to move between windows.

1.  `prefix n` and `prefix p`   # "next" and "previous"
2.  `prefix #`  where `#` is the window index number
3.  `prefix s`  opens the tmux Session Manager. 
4.  `prefix w`  opens the tmux Window Manager.  This is the Session Manager with the windows pre-expanded.

<img src=../assets/tmux-rpi-session-prefix-manager.png>

- [ ] Try each option above, moving from window to window.

***

## Using Pre-Defined Pane Layouts

tmux can apply pre-defined **pane** layouts to simplify **window** appearance.

- [ ] Create a new **window** and name it ***test***.  Divde the window into two (2) panes, vertical or horizontal.

```
prefix c    # creates a new window

prefix "    # splits horizontally

# or

# prefix %  # splits vertically
```

- [ ] Use `prefix <SPACE>` to cycle through different two-pane layouts.

- [ ] Experiment with diving your window into different combination of vertical and horizontal panes and then use `prefix <SPACE>` to cycle through the various pre-defined **pane** layouts.

***

## Closing a Window

There are at least three (3) ways to close a **window**.

1.  Type exit in each **pane** in the **window**.  When you `exit` the last **pane**, the **window** will close.
2.  `prefix &`  # will close all **panes** and the **window**.  Choose **Y** when prompted.
3.  `prefix :` to open the tmux command line, then `kill-window`

- [ ] When you are done, delete/close the ***test*** window.

***

# Customizing tmux

```bash
mkdir -p ~/.config/tmux
```

```bash
cd ~/.config/tmux

touch tmux.conf
```

- [ ] Create a soft link to `tmux.conf` in your home folder (as `.tmux.conf`).

```bash
ln -s ~/.config/tmux/tmux.conf ~/.tmux.conf
```

```bash
vim tmux.conf
# or
# vim ~/.tmux.conf
```

***

Add the following to `tmux.conf`; save and close when done.

```bash
##########################################################################################
# CUSTOM SETTINGS
###########################################################################################
set -g prefix ^A                        # Sets prefix key to 'a' rather than 'b'
set -g mouse on                         # Mouse support: resize panes, select windows, & scrolling
set -g base-index 1                     # Start window numbering at 1 rather than 0
set -g renumber-windows on              # renumber all windows when any window is closed
set -g set-clipboard on                 # use system clipboard
set -g history-limit 1000000            # increase history size (from 2,000)
set -g detach-on-destroy off            # don't exit from tmux when closing a session
set -s escape-time 0                    # address vim mode switching delay
set -g display-time 5000                # set tmux message display duration to 5 seconds
set -g status-interval 5                # refresh status bars every 5s (rather than 15s)
set -g focus-events on                  # focus events enabled for terminals that support them
set -g display-panes-time 4000          # time (ms) pane numbers are shown for `prefix q`
setw -g mode-keys vi
set -g window-style 'bg=#0c0c0c,fg=#ffffff'         # Inactive panes: light black
set -g window-active-style 'bg=#010101,fg=#ffffff'  # Active pane: black
```

***

- [ ] If tmux is running, exit all sessions and then re-open it.  Confirm no sessions are running.  If there are any sessions running, kill them with `tmux kill-server -t <session_name>`.

```bash
tmux ls
```

***

- [ ] \[Re-]Start tmux.  The settings in the new `tmux.conf` are applied.  Nothing will look particularly different (yet).

```bash
tmux
```

<img src=../assets/tmux-custom-bg-color.png>

***

### tmux Window Numbering

By default, tmux indexes (numbers) its **windows** starting at zero (0).  Because you can use `prefix <window #>` to cycle between windows (`prefix 0`, `prefix 1`, etc.), this creates an unnatural keyboard flow (because 0 is on the far right in the number row on the keyboard).  To fix this, `set -g base-index 1` starts window numbering at one (1).  Notice that your default window numbered one (1) in your new tmux session.

***

### Changing the tmux Prefix

- [ ] With the `set -g prefix ^A` setting in `tmux.conf`, your prefix key is now `C-a` rather than `C-b`.   This is personal preference.  Many people choose to switch to `C-a` or `C-s`; it's up to you.  Set the `set -g prefix ^<value>` to whatever you want your prefix key to be.  If you prefer the default `C-b`, remove the `set -g prefic ^A` line from `tmux.conf` and refresh the config.

> Note: It is good to always remember what the defaults are so you can still use tmux on remote/new systems.

***

### Config File Reload Options

You do not have to exit tmux to update your config file.  You can update the config file using your tmux command line or from within the tmux session (using the CLI).  Try one of those options now.

Example using the tmux command-line:

```
prefix :

# then
source-file tmux.conf
```

Example using the CLI:

```
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

<img src=../assets/tmux-bind-r-reload-config.png>

***

- [ ] Test your ability to refresh the `tmux.conf` file using the newly mapped `prefix r` mapping.

> Note: The 'tmux Config Reloaded!' message will be displayed in the status bar for the duration defined by the `set -g display-time 5000` setting (5000 ms, 5s).

```
prefix r
```

<img src=../assets/tmux-tmux-config-reloaded.png>

***

### Highlighting the Active Pane

- [ ] Split the tmux window horizontally, then vertically.  You should see the active pane is a different color than the inactive pane(s).  Switch from pane to pane and see that the active pane is always a different color.

This change comes from the following added to `tmux.conf`:

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

<img src=../assets/tmux-custom-inactive-bg-color.png>

***

### Further Highlighting the Active Pane

- [ ] Edit `tmux.conf` and the following to the **CUSTOM SETTINGS** section.

```bash
set -g pane-active-border-style 'fg=yellow'
set -g pane-border-style 'fg=brightblack'
```

<img src=../assets/tmux-conf-pane-border-config.png>

Reload the `tmux.conf` file.

```
prefix r
```

***

- [ ] Move from pane-to-pane or create new panes and you should now see additional highlighting around the border of the active pane.  This further helps to identify which pane is active.

<img src=../assets/tmux-conf-pane-border-color.png>

***

### Changing Key Bindings

- [ ] Some people prefer to re-map their **window** split keys to something more intuitive than the default `prefix "` and `prefix %`.  Many prefer to use `prefix -` and `prefix \` (because `\` is the same key as `|`) to split horizontally and vertically, respectively.  Try that by adding the following to `tmux.conf`.  Add the following to the **KEY BINDINGS** section of `tmux.conf`:

> Remember to update your `tmux.conf` file (`prefix r`) after making the changes.

```bash
bind-key '-' split-window -v      # '-' horizontal window split
bind-key '\' split-window -h      # '\' vertical window split
```

<img src=../assets/tmux-conf.split-window-bindings.png

***

- [ ] Test the new `prefix -` and `prefix \` bindings.  

> Note: The old key bindings are still in place so you can use either `prefix "` or `prefix -` to split horizontally and `prefix %` or `prefix \` to split vertically.  If you want to unbind the old keys, add `unbind '%'` and `unbind "` to `tmux.conf`.

> Note: Some people (e.g. tmux super-nerds) get aggressive with tmux and unbind all keys using `unbind-key -a` and then manually bind everything to their personal preferences.   This is well beyond the scope of this lab.  Your takeaway is that you can selectively bind and unbind (i.e. change) keys to better match how you use your keyboard, what seems intuitive to you, etc.  You are not locked in to using the default, and often ambiguous, key bindings.

***

### Enabling Mouse Control

- [ ] The `set -g mouse on` setting you added to `tmux.conf` enables the ability to use your mouse to do the following:

* Resize frames
* Select frames
* Change between windows

Try it now.  Create two or more windows (`prefix c`) and divide them into some panes (`prefix "`, `prefix %` or your newly bound `prefix \` and `prefix -`) then use your mouse to move between the windows (click on the window name in the status bar) and frames (click from frame to frame in a window).  Also try resizing the frames by clicking and dragging the frame borders.

***

### Tweaking Pane Size

Earlier in this lab you used `prefix <space>` to cycle through different pre-set **pane** layouts.  The pre-defined layouts are different depending on how many panes you have open in a **window**.

With `set -g mouse on` in your `tmux.conf` you can use the mouse to change **pane** size similar to how you would any window on your computer.  Try that now.

***

Some people prefer to keep their fingers on the keyboard as much as possible (it speeds up your workflow).  There are key bindings for that.

- [ ] Add the following to `tmux.conf` in the the **KEY BINDINGS** section:

> Note: the `-r` means the command can be repeated.  For example, `prefix H H H H`. Each `H` press will resize the window a little more.

```bash
bind -r H resize-pane -L                # Resize pane left
bind -r J resize-pane -D                # Resize pane down
bind -r K resize-pane -U                # Resize pane up
bind -r L resize-pane -R                # Resize pane right
```

<img src=../assets/tmux-conf-resize-pane-keys.png>

Reload `tmux.conf`.

```
prefix r
```

***

- [ ] Create a window with multiple vertical and horizontal panes.  Select a pane that has both horizontal and vertical sides and use the newly added bindings to resize the windows.

> Note: Use capital `H`, `J`, `K` and `L`.

```
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

The `setw -g  mode-keys vi` option set in `tmux.conf` enables `vi`-style key bindings within tmux.  In the steps below you will explore a portion of what that means.

- [ ] Create a new window and split it into two vertical panes (`prefix %`).
- [ ] In the right pane, run `ping localhost` and leave it running.
- [ ] Move to the left pane (`prefix ⬅️`) and run the following in sequence:

> `diskutil list` is a MacOS-only command

```
dig aaaa itdojo.com
dig mx itdojo.com
ifconfig
diskutil list
ls ~
```
<img src=../assets/tmux-ls-ping-localhost.png>

- [ ] Move to the ping pane, stop the ping and return to the `ls` pane.
- [ ] Using the mouse, try to highlight the output of `ls` and copy it to your clipboard.  You should see that all text across panes is highlighted.

<img src=../assets/tmux-select-across-panes.png>

- [ ] Open an external text editor and paste the clipboard.  You should see the paste contains data from both panes, which is not what you wanted.

<img src=../assets/tmux-mouse-select-paste.png>

> Note: There are way to deal with this buy they often become terminal program specific (iTerm, Alacrity, etc.).

- [ ] Using the mouse notice you can scroll up and down the command history of each pane.  The behavior is typical of what you expect from a terminal.

### Copying Output in tmux

- [ ] To select text and copy (yank) it to the clipboard, do the following:

* Select the left pane where you last ran `ls`.
* Press `prefix [` to enter copy mode.  This enables the vim keys motions defined in the `setw -g  mode-keys vi` option.  When in copy mode a yellow counter will appear in the pane.

<img src=../assets/tmux-entered-copy-mode.png>

- [ ] Using vim navigation keys (`h`, `j`, `k`, `l`) move up to the beginning of your `ls` output.
- [ ] Press the spacebar to begin copying.  Use arrow keys or vim navigation keys to select the `ls` output.
- [ ] After selecting all the values, use `y` to yank/copy the data.
- [ ] Press `Enter` to leave copy mode.
- [ ] Press `prefix ]` to paste the yanked text.

### Searching Command History  

The `setw -g mode-keys vi` option also enables the ability to search your command history output.  To do so, type `?<somestring>`.

- [ ] Press `prefix [` to enter copy mode.
- [ ] Type `?MX` to search backward through your history for any instances of `MX` in your command history output.  Use vim navigation keys to mode down to the beginning of the line for `alt4.aspmx.l.google.com`.
- [ ] Press SPACE to begin copying.  
- [ ] Press `SHIFT $` to highlight to the end of the line.
- [ ] Press `y` to yank the string to the clipboard.
- [ ] Press `Enter` to exit copy mode.
- [ ] At the terminal prompt, type `ping` then press `prefix ]` to paste the copied string.  If all went well you should now have: `ping alt4.aspmx.l.google.com.`.  Press enter to ping the server.

<img src=../assets/tmux-ping-google-mx.png>
<br/>
<img src=../assets/tmux-ping-google-mx2.png>

***

# Customizing tmux with Plugins and Themes

If you have not already installed zsh and PowerLevel10k, it is recommended you do so now.  Refer to ***install-zsh-powerlevel10k-and-plugins.md*** for steps to do so.  After doing so, return to this lab and continue.

## Installing Required Fonts

Tools like tmux, neovim and many of their themes (like Powerlevel10K) need, at most, two fonts for proper look and function.  They are:

* MesloLG Nerd Font
* Symbols Nerd Font

The Linux script below has commented out sections that allow for downloading and installing all Nerd Fonts.  Be very careful if you do this; downloading all the fonts is well over 3GB and the uncompressed fonts are over 7GB.  Ask yourself if you really need all those fonts before downloading them.

### MacOS Nerd Font Installation

If you ran the `install_zsh.sh` script from ITdojo's ***qol*** GitHub repo, Homebrew and Nerd Fonts are already installed and you can skip the font installation steps here.

Install Homebrew if necessary.  Visit https://brew.sh for install instructions.

> Visit nerdfonts.com for a list of available Nerd Fonts.  There are more than 70 of them.

- [ ] To install the fonts on MacOS, run:

```shell
brew install font-symbols-only-nerd-font font-meslo-lg-nerd-font font-meslo-for-powerlevel10k
```

***

### Linux Nerd Font Installation

If you ran the `install_zsh.sh` script from ITdojo's ***qol*** GitHub repo, the required Nerd Fonts are already installed and you can skip the font installation steps here.

> Note: These steps will install the required fonts for the logged in user only.  If you want to install the fonts globally (available to all users), unzip the files to `/usr/share/fonts/truetype/` instead of `~/.fonts/` (uncomment the appropriate lines in the script below).

The commands below do the following:
* Creates a `/.fonts` folder in your home directory
* Downloads and unzips the required font files into the `~/.fonts` folder
* Runs `fonts-cache` to update the list of installed fonts.

- [ ] To install Nerd Fonts on Debian Linux, run the following:

```shell
BASE_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0"
FONTS=("Meslo" "NerdFontsSymbolsOnly" "FiraCode" "Hack" "SourceCodePro")
TMP_DIR="/tmp"

if [[ ! $(command -v fc-cache) ]]; then echo "Installing fontconfig..." && sudo apt install fontconfig; fi

if [[ ! $(command -v unzip) ]]; then echo "Installing unzip..." && sudo apt install unzip; fi

mkdir -p ~/.fonts

for FONT in "${FONTS[@]}"; do
  wget -q "${BASE_URL}/${FONT}.zip" -O "${TMP_DIR}/${FONT}.zip"
  unzip -oq "${TMP_DIR}/${FONT}.zip" -d ~/.fonts/
  # Global install
  # sudo unzip -oq "${TMP_DIR}/${FONT}.zip" -d /usr/share/fonts/truetype/
  
done

rm /tmp/Meslo.zip /tmp/NerdFontsSymbolsOnly.zip /tmp/FiraCode.zip /tmp/SourceCodePro.zip /tmp/Hack.zip

# For ALL Nerd fonts (Be careful! HUGE!!! >3.2GB file)
# Check https://github.com/ryanoasis/nerd-fonts/tags for most up-to-date release

# wget -q https://github.com/ryanoasis/nerd-fonts/archive/refs/tags/v3.3.0.zip -O /tmp/v3.3.0.zip
# sudo unzip -oq /tmp/v3.3.0.zip -d ~/.fonts                    # Local User Only
# sudo unzip -oq /tmp/v3.3.0.zip -d /usr/share/fonts/truetype   # All Users
# rm /tmp/v3.3.0.zip

sudo fc-cache -f
```

***

## Set $XDG_CONFIG_HOME Variable

`$XDG_CONFIG_HOME` defines the base location of user-specific configuration files.  If it is not set, the default is usually `$HOME/.config`.  Setting this variable  allows you to specify an alternate location for your config files (based on your personal preferences).  However, unless you have a specific reason for doing so, leave `~/.config/` as your default config file location, many different programs use it.

In this lab, we will set `${XDG_CONIFG_HOME}` but still point it to the default location of `$HOME/.config`.

***

- [ ] Confirm `${XDG_CONIFG_HOME}` is not already set.

```shell
echo $XDG_CONFIG_HOME   # Should return nothing
```

***

- [ ] Add an export for the variable to your `~/.bashrc` or `~/.zshrc`.

```shell
cat >> ~/.zshrc << 'EOL'
if [[ ! -d ~/.config ]]; then mkdir -p ~/.config/; fi
export XDG_CONFIG_HOME=$HOME/.config
EOL
```

***

- [ ] Source your config file to update the changes.

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

> Note: The remainder of this lab will assume your shell is zsh.

***

## Installing tmux Plugin Manager

tmux Plugin Manager (tpm) is a script that installs a wide array of tmux plugins.  It simplifies the addition of plugins to tmux.

- [ ] Clone the TPM repo.

```shell
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

- [ ] Edit `.tmux.conf`, adding the following.

> Note: The [`tmux-sensible` plugin](https://github.com/tmux-plugins/tmux-sensible) is almost universally installed.  It is a set of options that are considered essential improvements that "everyone can agree on".

```
###########################################################################################
# PLUGINS
###########################################################################################
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
```

*** 

- [ ] Add the following as the last line of the file:

> Important Note: `run '~/.tmux/plugins/tpm/tpm'` must always be at the end of the `.tmux.conf` file.

```
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.config/tmux/plugins/tpm/tpm'
```

<img src=../assets/tmux-config-file-tpm.png>

***

- [ ] Reload the tmux environment using `prefix I`.

```
prefix I
```

<img src=../assets/tmux-reload-tmux-config.png>

https://github.com/catppuccin/tmux/discussions/317

***

The tmux Plugin Manager simplifies the installation of a lot of different plugins.  The GitHub project page for tpm is here: https://github.com/tmux-plugins/tpm

A list of many of the plugins that can be installed using tpm can be found here: https://github.com/tmux-plugins/list

Installing plugins using tpm is usually very straightforward.  You only need to add the plugin to `tmux.conf` and tpm will handle the installation for you.  For example, to install the plugin `tmux-yank` add the following to `tmux.conf` and refresh (`prefix I`)

```vim
set -g @plugin 'tmux-plugins/tmux-yank'
```

```
prefix I
```

<img src=../assets/tmux-tpm-install-tmux-yank.png>

***

## Installing tmux Themes

There are hundreds of themes available for tmux.  This lab demonstrates two:

* catppuccin
* powerline

- [ ] Make a copy/backup of your current `tmux.conf` file.

```bash
cp ~/.config/tmux/tmux.conf ~/.config/tmux/tmux.conf.base
```

***

### Installing catppuccin for tmux

Project Page: https://github.com/catppuccin/tmux

- [ ] Clone the catppuccin repo.

```bash
mkdir -p ~/.config/tmux/plugins/catppuccin

# Check the repo page for the most up-to-date release (v2.1.2 at the time of writing)
git clone -b v2.1.2 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
```

- [ ] Add the following at the bottom of your `tmux.conf` file (just above the tpm run script):

```
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
```

<img src=../assets/tmux-catppuccin-tmux-config.png>

***

- [ ] Run tmux or reload the `tmux.conf` file (`prefix r`, or `tmux source-file ~/.config/tmux/tmux.conf`).  The catppuccin theme should be loaded and the status bar at the bottom of the page will change color.

<img src=../assets/tmux-catppuccin-loaded.png>

***

Most themes are highly customizable.  Catppuccin is no exception.  Add the following to `tmux.conf`:

> Note: The run line to load catppuccin is included twice in my config.  I have found that it sometimes does not load correctly unless loaded before applying catppuccin-specific settings and then again afterward.  Until I figure out why, this workaround consistently works.

```vim
###########################################################################################
# CATPPUCCIN THEME SETTINGS
###########################################################################################
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
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
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"
set -g default-terminal "tmux-256color"
```

***

- [ ] Add the following to the plugins section of `tmux.conf`

```vim
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'robhurring/tmux-uptime'
set -g @plugin 'tmux-plugins/tmux-battery'
```

*** 

- [ ] Add the following to your **CUSTOM SETTINGS** section of `tmux.conf`:

```bash
set -g status-position bottom           # status bar position (top, bottom)
```

***

- [ ] Your `tmux.conf` should look similar to this:

```shell
##########################################################################################
# CUSTOM SETTINGS
###########################################################################################
set -g prefix ^A                        # Sets prefix key to 'a' rather than 'b'
set -g mouse on                         # Mouse support: resize panes, select windows, & scrolling
set -g base-index 1                     # Start window numbering at 1 rather than 0
set -g renumber-windows on              # renumber all windows when any window is closed
set -g set-clipboard on                 # use system clipboard
set -g history-limit 1000000            # increase history size (from 2,000)
set -g detach-on-destroy off            # don't exit from tmux when closing a session
set -s escape-time 0                    # address vim mode switching delay
set -g display-time 5000                # set tmux message display duration to 5 seconds
set -g status-interval 5                # refresh status bars every 5s (rather than 15s)
set -g focus-events on                  # focus events enabled for terminals that support them
set -g display-panes-time 4000          # time (ms) pane numbers are shown for `prefix q`
setw -g mode-keys vi
set -g window-style 'bg=#0c0c0c,fg=#ffffff'         # Inactive panes: light black
set -g window-active-style 'bg=#010101,fg=#ffffff'  # Active pane: black
set -g pane-active-border-style 'fg=yellow'
set -g pane-border-style 'fg=brightblack'

###########################################################################################
# KEY BINDINGS
###########################################################################################
bind r source-file ~/.config/tmux/tmux.conf \; display "tmux Config Reloaded!"
bind-key '-' split-window -v            # '-' horizontal window split
bind-key '\' split-window -h            # '\' vertical window split
bind -r H resize-pane -L                # Resize pane left
bind -r J resize-pane -D                # Resize pane down
bind -r K resize-pane -U                # Resize pane up
bind -r L resize-pane -R                # Resize pane right

###########################################################################################
# PLUGINS
###########################################################################################
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-yank'
set -g @plugin 'tmux-plugins/tmux-cpu'
set -g @plugin 'robhurring/tmux-uptime'
set -g @plugin 'tmux-plugins/tmux-battery'

###########################################################################################
# CATPPUCCIN THEME SETTINGS
###########################################################################################
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
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
set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_application}"
set -agF status-right "#{E:@catppuccin_status_cpu}"
set -ag status-right "#{E:@catppuccin_status_session}"
set -ag status-right "#{E:@catppuccin_status_uptime}"
set -agF status-right "#{E:@catppuccin_status_battery}"
set -g default-terminal "tmux-256color"

###########################################################################################
# SCRIPTS
###########################################################################################
run ~/.config/tmux/plugins/catppuccin/tmux/catppuccin.tmux
# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.config/tmux/plugins/tpm/tpm'
```

***

- [ ] Save `.tmux.conf` and reload the tmux config.

```
prefix I

prefix r
```

***

Your tmux session should now look like this:

<img src=../assets/tmux-catppuccin-labels.png>

***

To illustrate how the labels are being displayed, do the following:

- [ ] Name the session `kismet`.

```
prefix :

# then 
rename-session kismet
```

- [ ] Rename window 1 to `server`. 

```
prefix ,

# then enter a new name
```

- [ ] Create two new windows and rename each to `remote1` and `remote2`

- [ ] Run the following programs:
* server window: `htop` or `top`
* remote1 window: `python3`
* remote2 window: `vim`

- [ ] Switch between the windows usinf either your mouse to click on the window names, the window manager (`prefix w`) or `prefix 1`, `prefix 2` and `prefix 3`, you should see that the name of each program running is displayed along with the window names.  The active window is squared in the number on the status bar (rather than rounded).

<img src=../assets/catppuccin-window1.png>
<br/><br/>
<img src=../assets/catppuccin-window2.png>
<br/><br/>
<img src=../assets/catppuccin-window3.png>

***

- [ ] Go to window 2 (remote1) and split the window horizontally into two panes.

```
prefix "

# or

prefix -
```

- [ ] Move between the panes and notice the name of the app changes from **bash** (or **zsh**) to **python** depending on the pane that is active within the window.

***

- [ ] Zoom in on the python pane.  In the status bar the window name will now have a magnifying glass next to it to indicate the windows is zoomed.  When done, use `prefix z` to zoom back out.

```
prefix z
```

<img src=../assets/catppuccin-zoomed-pane.png>

*** 

- [ ] Move the status bar to the top.  To do so, edit `tmux.conf` and change:

```bash
set -g status-position bottom

# to

set -g status-position top
```

***

- [ ] Save the changes and reload the config.  The bar is now on top.  Some poeple prefer this layout.  You decide.  Leave it or change it.

```
prefix r
```

<img src=../assets/catppuccin-status-bar-top.png>

***

- [ ] Once your catppuccin theme is set up the way you want it, make a copy of the `tmux.conf` and name it `tmux.conf.catppuccin`.

***

My suggestion:  Make a GitHub repo that holds your personal config preferences like this tmux config file.  Add to a README.md or other markdown file to document the few steps involved in installing the required fonts & packages (font install, repos to clone, .zshrc entries, etc.) and save it all in a concise script that you can clone to any computer, run the script to download and install everything and place this `tmux.conf` file in `/.config/tmux/`.  Everything you need is in this document.  Once you have this available you can install tmux with all of your preferred settings on any new device in a few seconds.


***

## Installing the tmux Powerline Theme

Project Page: https://github.com/erikw/tmux-powerline 

- [ ] Copy your `tmux.conf.base` file to `tmux.conf`.

***

- [ ] Edit `tmux.conf` and add the following to the plugins section:

```
set -g @plugin 'erikw/tmux-powerline'
```

***

- [ ] Save and close, then reload the config file.

```
prefix I

prefix r
```

Your theme should change to something similar to what you see below.

<img src=../assets/tmux-powerline-theme.png>

***

- [ ] Generate a custom config file for the theme.

```
~/.config/tmux/plugins/tmux-powerline/generate_config.sh

mv ~/.config/tmux-powerline/config.sh.default ~/.config/tmux-powerline/config.sh

vim ~/.config/tmux-powerline/config.sh
```

***

This theme has a lot of different options available.  Each is in th form of a 'segment' you can configure.  This includes:
* Weather
* Now playing integration with your music player
* IP address info
* Realtime upload/download data stats
* Email integration (notifications)
* System load (CPU, Memory, etc.)
* Battery status, disk usage, 
* Calendar
* Air quality
* Earthquake data
* GitHub integration
* ...and more

> This theme can get really busy if you want it to.  Do you really need to see all of this information?

***

The network info (which will show tunnel/wireguard addresses, too) combined with the upload/download data rates is interesting for some use-cases.

- [ ] To enable the network up/down stats go to `~/.config/tmux/plugins/tmux-powerline/themes/default.sh` and search for and uncomment these lines:

```
"ifstat 30 255"
"ifstat_sys 30 255"
```

Save and close when done.

***

- [ ] Edit `~/.config/tmux-powerline/config.sh` and find:

```
        # The maximum length of the left status bar.
        export TMUX_POWERLINE_STATUS_LEFT_LENGTH="60"
        # The maximum length of the right status bar.
        export TMUX_POWERLINE_STATUS_RIGHT_LENGTH="90"
```

Change the left length to 160 and the right length to 190.  You may need to modify these later depending on screen size and how many segments you have enabled.

- [ ] Save the file and reload using `prefix r`.  

The network up/down stats should appear.

<img src=../assets/powerline-network-up-down.png>

***

The documentation on how to configure this theme is mostly by reading the config file at `~/.config/tmux-powerline/config.sh`.  Work through the comments to turn segments on/off to your liking.

> Note: I have used the "Now Playing" feature with Apple Music and it works quite well.  I have not used it with any other music services.

***

- [ ] If you like the Powerline theme, keep it.  If you prefer catppuccin, replace your `tmux.conf` with the `tmux.conf.catppuccin` back up you made earlier and reload your config (`prefix r`).  If you don't like either theme, find another one on the Interwebs or go back to the backup `tmux.conf.base` you made.

***

End of Lab.