# eza - Better ls

## Installation

### MacOS

```shell
brew install eza
```

### Linux

```shell
sudo apt update
sudo apt install -y gpg

sudo mkdir -p /etc/apt/keyrings

wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg

echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list

sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list

sudo apt update && sudo apt install -y eza
```

***

## Alias eza for ls

Add to `~/.zshrc` or `~/.bashrc`:

```shell
alias ls="eza"

# or, whatever options you like as your defaults
alias ls="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
```

***

## eza Tree View

```shell
eza --tree --levels=2
```

***

## Most Used Options

| Option | What it does
|:--|:--|
| `-1`, `--oneline` |display one entry per line
| `-G`, `--grid` |display entries as a grid (default)
| `-l`, `--long` |display extended details and attributes
| `-T`, `--tree` | recurse into directories as a tree
| `-R`, `--recurse` | recurse into directories
| `--icons`, `--icons=(when)` |when to display icons (`always`, `auto`, `never`)
| `-a`, `--all` | show hidden and 'dot' files
| `-d`, `--list-dirs` | list directories like regular files
| `-L`, `--level=(depth)` | limit the depth of recursion

***

## Common Long View Options

| Option | What it does
|:--|:--|
| `-h`, `--header` | add a header row to each column
| `-m`, `--modified` | use the modified timestamp field
| `-u`, `--accessed` | use the accessed timestamp field
| `-U`, `--created` | use the created timestamp field
| `-g`, `--group` | list each file’s group
| `--total-size` | show recursive directory size

## Long View 'no' Options

| Option | What it does
|:--|:--|
| `--no-permissions` | suppress the permissions field
| `--no-filesize` | suppress the filesize field
| `--no-user` | suppress the user field
| `--no-time` | suppress the time field

## Seldom Used Long View Options

| Option | What it does
|:--|:--|
| `-H`, `--links` | list each file’s number of hard links
| `-i`, `--inode` | list each file’s inode number
| `-b`, `--binary` | list file sizes with binary prefixes
| `-B`, `--bytes` | list file sizes in bytes, without any prefixes
| `-S`, `--blocksize` | show size of allocated file system blocks
| `-t`, `--time=(field)` | which timestamp field to use
| `-M`, `--mounts` | Show mount details (Linux and MacOS only).
| `--changed` | use the changed timestamp field
| `--git` | list each file’s Git status, if tracked or ignored
| `--git-repos` | list each directory’s Git status, if tracked
| `--git-repos-no-status` | list whether a directory is a Git repository, but not its status (faster)
| `--no-git` | suppress Git status (always overrides `--git`, `--git-repos`, `--git-repos-no-status`)
| `--time-style` | how to format timestamps. valid timestamp styles are `default`, `iso`, `long-iso`, `full-iso`, `relative`, or a custom style `+<FORMAT>` (e.g., `+%Y-%m-%d %H:%M` => ‘2023-09-30 13:00’. For more specifications on the format string, see the eza(1) manual page and chrono documentation.).
| `-X`, `--dereference` | dereference symlinks for file information
| `-Z`, `--context` | list each file’s security context
| `-@`, `--extended` | list each file’s extended attributes and sizes
| `-o`, `--octal-permissions` | list each file's permission in octal format
| `--stdin` | read file names from stdin

## Less Often Used Options

| Option | What it does
|:--|:--|
| `-r`, `--reverse` | reverse the sort order
| `-s`, `--sort=(field)` | which field to sort by
| `--group-directories-first` | list directories before other files
| `--group-directories-last` | list directories after other files
| `-D`, `--only-dirs` | list only directories
| `-f`, `--only-files` | list only files
| `--no-symlinks` | don't show symbolic links
| `--show-symlinks` | explicitly show links (with `--only-dirs`, `--only-files`, to show symlinks that match the filter)
| `--git-ignore` | ignore files mentioned in `.gitignore`
| `-I`, `--ignore-glob=(globs)` | glob patterns (pipe-separated) of files to ignore