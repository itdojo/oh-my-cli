# thefuck (and its successor, pay-respects)

Command syntax autocorrection tool.  Enter a command wrong, then run the magic word and it offers you the corrected command.

Project Page: https://github.com/nvbn/thefuck

> [!Warning]
> **thefuck is no longer maintained.**  The last release (v3.32) was in January 2022 and the maintainer has been inactive since.  Installing it with `pip` on Python 3.12 or newer **fails at runtime** (it imports the `imp` module, which was removed in Python 3.12).  Homebrew's package still works because Homebrew patches it.
>
> The community-recommended replacement is **[pay-respects](https://codeberg.org/iff/pay-respects)** — a fast, actively maintained Rust rewrite of the same idea.  Instructions for both are below; prefer pay-respects for new installs.

## Option 1 (Recommended): pay-respects

Project Page: https://codeberg.org/iff/pay-respects (GitHub mirror: https://github.com/iffse/pay-respects)

### MacOS

```shell
brew install pay-respects
```

### Linux

```shell
# Via cargo (install rust/cargo with 'sudo apt install cargo' if needed)
cargo install pay-respects

# or use the install script from the project page for pre-built binaries
```

Add to `~/.zshrc` or `~/.bashrc`:

```shell
# Default alias is 'f'.  Use --alias <name> to pick your own (e.g. --alias fuck).
eval "$(pay-respects zsh --alias)"

# or, for bash
# eval "$(pay-respects bash --alias)"
```

Then run:

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

### Usage

Enter a command wrong.  After getting an error, run `f` (or whatever alias you chose) and confirm the suggested correction.

```console
❯ apt install tmux
E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied)

❯ f
sudo apt install tmux [enter/ctrl+c]
```

***

## Option 2 (Legacy): thefuck

### MacOS

```shell
# Works: Homebrew patches thefuck to run on current Python
brew install thefuck
```

### Linux

> Reminder: `pip3 install thefuck` is broken on Python 3.12+ (Ubuntu 24.04 and newer).  Only use this on older systems, or use pay-respects above.

```shell
sudo apt update

sudo apt install python3-dev python3-pip python3-setuptools

pip3 install thefuck --user
```

Add to `~/.zshrc` or `~/.bashrc`:

```shell
eval $(thefuck --alias)
```

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

### Usage

Enter a command wrong.  After getting an error, run `fuck` and choose the correct command offered.

```console
➜ apt-get install vim
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?

➜ fuck
sudo apt-get install vim [enter/↑/↓/ctrl+c]
[sudo] password for nvbn:
Reading package lists... Done
...
```
