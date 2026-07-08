# zoxide (Better cd)

Project Page: https://github.com/ajeetdsouza/zoxide

A smarter `cd`.

> zoxide is best used with [`fzf`](https://github.com/junegunn/fzf) (https://github.com/junegunn/fzf).
## Installation

### MacOS

```shell
brew install zoxide

# or
# curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

### Linux

```shell
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# or (distro packages tend to be older versions)
# sudo apt install zoxide
```

***

Add to `~/.zshrc` or `~/.bashrc`:

> Note: Put this near the ***end*** of your config file (in zsh, it must come after `compinit` runs — which oh-my-zsh handles for you).

```shell
eval "$(zoxide init zsh)"

# or
# eval "$(zoxide init bash)"
```

then run:

```shell
source ~/.zshrc

# or
# source ~/.bashrc
```

***

### Usage

Use `z` instead of `cd`.  Syntax is the same:

```shell
cd path/to/some/directory

z path/to/some/directory
```

zoxide remembers the directories you have been to.  To test this, run the following `mkdir` commands to make a sample folder structure.

```shell
cd
mkdir -p ~/ztest/{apple,linux,windows}/tools/{fzf,eza,bat}
mkdir -p ~/ztest/windows/office/{word,excel,powerpoint,outlook}
mkdir -p ~/ztest/{windows,apple}/crypto/{bitcoin,ethereum,cardano}/wallet
mkdir -p ~/ztest/linux/{tmux,screen}/tutorial
```

The commands above create the following test folder structure:

```
❯ tree ztest
ztest
├── apple
│   ├── crypto
│   │   ├── bitcoin
│   │   │   └── wallet
│   │   ├── cardano
│   │   │   └── wallet
│   │   └── ethereum
│   │       └── wallet
│   └── tools
│       ├── bat
│       ├── eza
│       └── fzf
├── linux
│   ├── screen
│   │   └── tutorial
│   ├── tmux
│   │   └── tutorial
│   └── tools
│       ├── bat
│       ├── eza
│       └── fzf
└── windows
    ├── crypto
    │   ├── bitcoin
    │   │   └── wallet
    │   ├── cardano
    │   │   └── wallet
    │   └── ethereum
    │       └── wallet
    ├── office
    │   ├── excel
    │   ├── outlook
    │   ├── powerpoint
    │   └── word
    └── tools
        ├── bat
        ├── eza
        └── fzf
```
 
 *** 

Now, navigate to test how zoxide works:

```bash
# Home directory
z

# Navigate to excel folder
z ztest/windows/office/excel

# Home directory
z

# Use zoxide to get back to excel folder
z excel

# Navigate from excel folder to tmux tutorial folder
z ~/ztest/linux/tmux/tutorial

# Navigate from tmux tutorial folder to apple bitcoin wallet folder
z ../../../apple/crypto/bitcoin/wallet

## Use zoxide to get back to excel folder
z excel

## Navigate to the windoes cardano wallet folder

z ~/ztest/windows/crypto/cardano/wallet

# Home directory
z

# Use zoxide with fzf to pick which wallet folder to go back to
z wallet<SPACE><tab>    # note: a space before TAB; use arrow keys to pick the folder you want

# or use zoxide's built-in interactive mode (also uses fzf)
zi wallet
```

***

## Alias z for cd

> This is optional.

Add to `~/.zshrc` or `~/.bashrc`:

```shell
alias cd="z"
```

Alternatively, zoxide can replace `cd` natively (this also gives you `cdi` for interactive mode).  Instead of the alias, change your init line to:

```shell
eval "$(zoxide init --cmd cd zsh)"

# or
# eval "$(zoxide init --cmd cd bash)"
```

Then run:

```shell
source ~/.zshrc
```

