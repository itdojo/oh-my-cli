## Installing zsh, Starship and the zsh plugins

[Starship](https://starship.rs) is a prompt, and only a prompt. It is a single binary, it is configured by one TOML file, and it renders the same prompt in zsh, bash, fish and PowerShell. That is the whole pitch, and it is why this guide starts here instead of with a framework.

The prompt is one piece. The other three are the plugins that make zsh pleasant to type in:

* **zsh-autosuggestions** — greys out the rest of a command as you type it, drawn from your history. Press `→` to accept.
* **zsh-syntax-highlighting** — colors the command line as you type. A command turns green when it exists and red when it does not, so you catch a typo before you press Enter.
* **zsh-completions** — a large pile of extra completion definitions for tools that do not ship their own.

You also need a **Nerd Font**. Starship's default prompt draws icons and powerline separators from glyphs that a normal font does not have. Without one, the prompt renders as a row of boxes. The installer handles this.

***

## The scripted path

- [ ] Run the following commands.

> Note: the `install-zsh-starship.sh` script installs zsh, Starship, MesloLGS Nerd Font, and all three plugins, then writes `~/.config/starship.toml` and a managed block in your `~/.zshrc` and changes your default shell to zsh.

> When needed, the script will prompt you for your password.

```shell
git clone https://github.com/itdojo/oh-my-cli.git

cd oh-my-cli/scripts

chmod +x install-zsh-starship.sh

./install-zsh-starship.sh

cd
```

The script is a thin wrapper: it fetches [`install_zsh_starship.sh`](https://github.com/itdojo/qol/blob/main/install_zsh_starship.sh) from the `itdojo/qol` repo and runs it. That is deliberate. The installer lives in exactly one place, so a fix reaches everyone who runs it rather than only the people who re-cloned this repo.

It works on macOS (Homebrew), Debian/Ubuntu/Pi OS (apt), Fedora/RHEL (dnf), Arch (pacman), Alpine (apk) and openSUSE (zypper). Rerunning it is safe — it checks before it writes, so nothing gets duplicated.

- [ ] After the script finishes, restart your terminal.

- [ ] Set your terminal's font to **MesloLGS Nerd Font Mono**. The script installs the font but cannot change your terminal's settings for you. If your prompt is full of `□` boxes, this is the step you skipped.

***

## Doing it by hand

Worth reading even if you ran the script, because it is what the script did.

### macOS

```shell
brew install zsh starship
brew install --cask font-meslo-lg-nerd-font font-symbols-only-nerd-font
```

### Debian / Ubuntu / Raspberry Pi OS

```shell
sudo apt-get update
sudo apt-get install -y zsh git curl
curl -sS https://starship.rs/install.sh | sh
```

Starship is not in most distro repos, so the official install script is the normal path on Linux. It drops a single binary in `/usr/local/bin`.

Fonts, on Linux:

```shell
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Meslo.zip
unzip -o Meslo.zip && rm Meslo.zip
fc-cache -f
```

### The plugins (both platforms)

The plugins are just git repos that zsh sources. No framework is involved.

```shell
mkdir -p ~/.zsh/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions     ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions         ~/.zsh/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh/plugins/zsh-syntax-highlighting
```

- [ ] Add this to the **end** of your `~/.zshrc`:

```shell
fpath=(~/.zsh/plugins/zsh-completions/src $fpath)
autoload -Uz compinit && compinit

source ~/.zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh   # must be last

eval "$(starship init zsh)"
```

Order matters twice here. `zsh-syntax-highlighting` has to be sourced after every other plugin, because it wraps the line editor and anything sourced later will not be highlighted. And `compinit` has to run before the plugins that hook into completion.

- [ ] Make zsh your default shell:

```shell
chsh -s "$(command -v zsh)"
```

***

## Configuring the prompt

Everything about the prompt lives in `~/.config/starship.toml`. There is no wizard — you edit the file, save it, and the next prompt reflects it. That is faster than it sounds, because a bad edit costs you one keystroke to undo.

The installer writes a powerline-style config to get you started. Delete the file entirely and Starship falls back to its (perfectly good) defaults.

A few things worth knowing:

* **Modules are opt-out, not opt-in.** Starship shows a module only when it is relevant — the Python version appears in a directory with a `.py` file and nowhere else. So a long config is usually a config that is *hiding* things.
* **`command_timeout`** defaults to 500ms. If your prompt stutters on a large git repo or a slow network mount, raise it, or disable the module that is doing the work.
* **`starship explain`** prints every module in your current prompt and why it is there. `starship timings` shows what each one cost. Reach for these before you start deleting things at random.

The full module reference is at [starship.rs/config](https://starship.rs/config/). The preset gallery at [starship.rs/presets](https://starship.rs/presets/) is a faster way to find a look you like than building one from scratch.

***

## If you already have Oh My Zsh and Powerlevel10k

The installer detects both and offers to remove them before it proceeds. Take the offer. Powerlevel10k is also a prompt, and two prompts fighting over the same line is not a state worth debugging.

Powerlevel10k's author put the project in maintenance mode — no new features, very limited support. It still works, and it is still fast. If you are happy with it, nothing here is urgent. This repo moved to Starship because it is actively developed, because it works in shells other than zsh, and because it does not need a framework underneath it.

***

End.
