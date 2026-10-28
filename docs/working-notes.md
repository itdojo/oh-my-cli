# working notes — oh-my-cli

## Decisions

- 2026-09-10: Moved the shell guide from Oh My Zsh + Powerlevel10k to Starship. Starship is a single binary needing no framework, is actively developed (p10k is in maintenance mode), and works in shells other than zsh.
- 2026-09-10: `scripts/install-zsh-starship.sh` is a thin wrapper that curls `itdojo/qol`'s `install_zsh_starship.sh` and runs it, rather than vendoring 1200+ lines. One installer, one place to fix it. Same cross-repo-fetch pattern `install-cool-tools.sh` already uses for `base_functions.sh`.
- 2026-09-10: `scripts/install-ghostty.sh` is written here rather than in `qol` because no ghostty installer existed anywhere. It follows qol's `script-design.md` house style and embeds the theme block copied verbatim from `qol/install_zsh_starship.sh` lines 55–406.
- 2026-09-10: Ghostty config installs to `~/.config/ghostty/config.ghostty` on both platforms. macOS also reads `~/Library/Application Support/com.mitchellh.ghostty/`, but one path is easier to remember and both platforms honour the XDG location.

## Constraints

- `assets/install_zsh.sh` and `assets/install_zsh.sh.orig` are the vim crash course's practice file, not runnable guidance. The lab cites exact line numbers in them (`check_for_oh_my_zsh` at 109, `download_fonts` at 123). They keep their Oh My Zsh / Powerlevel10k content on purpose — rewriting them means rewriting every line-number reference in `vim/just-enough-vim-a-crash-course.md`.
- Operator-facing shell scripts follow qol's `script-design.md`. No emoji in output, `log_*` helpers only, badges carry the meaning.

## Gotchas

- Ghostty distributes official prebuilt binaries for **macOS only**. Every Linux path is a distro package or a community build, which is why `install-ghostty.sh` has a per-manager case statement instead of a `pkg_install` one-liner. Ubuntu got a real archive package in 26.04; anything older needs the Snap or the `ghostty-ubuntu` .deb.
- `install-cool-tools.sh` is still Linux-only (`check_if_linux`, apt-get throughout). The rest of the repo now covers macOS.
- `scripts/install-nerd-fonts.sh` takes the Homebrew cask path on macOS and returns early; its Linux dependency installs still assume apt-get.

## Open questions

- `assets/p10k-configure.png` and `assets/p10k-layout-colin.png` are now orphaned — nothing references them. Replace with Starship prompt screenshots or delete. Logged in `SCREENSHOTS-TODO.md`.
