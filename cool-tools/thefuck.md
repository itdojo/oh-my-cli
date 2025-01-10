# thefuck

Command syntax autocorrection tool

Project Page: https://github.com/nvbn/thefuck

## Installation 

### MacOS

```shell
brew install thefuck
```

### Linux

```shell
sudo apt update

sudo apt install python3-dev python3-pip python3-setuptools

pip3 install thefuck --user
```

***

Add to `~/.zsrhc` or `~/.bashrc`:

```shell
eval $(thefuck --alias)
```

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

***

### Usage

Enter a command wrong.  After getting an error, run `fuck` and choose the correct command offered.

Examples:
```groovy
➜ apt-get install vim
E: Could not open lock file /var/lib/dpkg/lock - open (13: Permission denied)
E: Unable to lock the administration directory (/var/lib/dpkg/), are you root?

➜ fuck
sudo apt-get install vim [enter/↑/↓/ctrl+c]
[sudo] password for nvbn:
Reading package lists... Done
...
```

```groovy
➜ puthon
No command 'puthon' found, did you mean:
 Command 'python' from package 'python-minimal' (main)
 Command 'python' from package 'python3' (main)
zsh: command not found: puthon

➜ fuck
python [enter/↑/↓/ctrl+c]
Python 3.4.2 (default, Oct  8 2014, 13:08:17)
...
```