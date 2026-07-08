# tldr-pages (User-Friendly Manpages)

Project Page: https://github.com/tldr-pages/tldr

Simplified, concise manpages.  Community driven help files.

The `tldr` pages are a dataset; you install a *client* to read them.  There are several clients — the two best options are the official Rust client (**tlrc**) and the official Python client.

## Installation

### MacOS

```shell
brew install tlrc   # No, tlrc is not a typo (tldr rust client)
```

### Linux

```shell
# Official Python client (recommended)
pipx install tldr       # sudo apt install pipx, if you don't have pipx

# or the Rust client (tlrc)
cargo install tlrc --locked
```

or download the [latest tlrc release from GitHub](https://github.com/tldr-pages/tlrc/releases/)

> [!Note]
> Avoid `sudo apt install tldr` — the `tldr` package in Debian/Ubuntu is an outdated, unofficial client.  If you want an apt-installable client, `sudo apt install tealdeer` (another Rust client, command is still `tldr`) is the better choice.  The npm client (`npm install -g tldr`) has fallen behind and is no longer recommended.

***

## Usage

```shell
tldr <command>

# Example
tldr eza
```

> Tip: The first run may ask to download/update the page cache.  Update it any time with `tldr --update`.
