# Screenshots To Create / Verify

This log lists screenshots that need to be **created** (for newly added lab content) or **verified/re-taken** (for content whose configuration changed).  I could not generate these automatically in a way that would match the visual style (terminal, fonts, theme, prompt) of your existing screenshots, so they are listed here with exact reproduction steps.

For the three *new* screenshots, commented-out image references are already in place in `tmux/00-tmux-lab.md` — search for `TODO screenshot`, create the image with the filename shown, drop it in `assets/`, and uncomment the line.

***

## 1. New screenshots needed (tmux lab — "More Useful tmux Tricks" section)

### `assets/tmux-break-pane-after.png`
- **Where used:** `tmux/00-tmux-lab.md` → *Breaking a Pane Out into its Own Window*
- **How to reproduce:**
  1. Start tmux, split the window into two panes (`prefix "`), run something recognizable in one pane (e.g. `htop`).
  2. From that pane, press `prefix !`.
  3. Capture the result: the pane is now its own window (status bar shows the extra window; the original window has a single pane).

### `assets/tmux-synchronize-panes.png`
- **Where used:** `tmux/00-tmux-lab.md` → *Typing in All Panes at Once (synchronize-panes)*
- **How to reproduce:**
  1. Split a window into 3–4 panes.
  2. `prefix :` → `setw synchronize-panes on`
  3. Type `echo hello from all panes` (visible simultaneously in every pane) and capture before/as you press Enter so the duplicated typing is visible in all panes.

### `assets/tmux-display-popup.png`
- **Where used:** `tmux/00-tmux-lab.md` → *Popup Windows (tmux 3.2+)*
- **How to reproduce:**
  1. In a tmux session with a couple of panes, run: `tmux display-popup -w 80% -h 75% -E "htop"`
  2. Capture the floating popup overlaying the panes.

***

## 2. Screenshots to verify (existing images, config behind them changed)

The catppuccin configuration in the lab was corrected from mixed v0.x/v2.x syntax to clean **v2.x syntax pinned at v2.3.0** (the dead v0.x options were silent no-ops, so the rendered result *should* be identical — but verify against a fresh install).

| Screenshot | Where used | What to verify |
|:--|:--|:--|
| `assets/tmux-catppuccin-tmux-config.png` | catppuccin install step | Shows `tmux.conf` in an editor.  If the visible config text includes old option names (`@catppuccin_flavour`, `@catppuccin_status_modules_right`, separators, etc.), re-take with the new config block. |
| `assets/tmux-catppuccin-loaded.png` | after first theme load | Status bar renders the same with v2.3.0. |
| `assets/tmux-catppuccin-labels.png` | after full theme config | Status bar modules (application/cpu/session/uptime/battery) render as pictured. |
| `assets/catppuccin-window1.png`, `catppuccin-window2.png`, `catppuccin-window3.png` | window/label walkthrough | Window tabs render the same (rounded style, program name per window). |
| `assets/catppuccin-zoomed-pane.png` | zoom step | Zoom indicator still shows next to the window name. |
| `assets/catppuccin-status-bar-top.png` | status-position top step | Same rendering with bar on top. |
| `assets/tmux-catppuccin-settings.png` | **not referenced by any doc** (orphan) | Safe to delete, or re-take with the new settings block if you want to use it. |

Also worth a quick check (content unchanged, but referenced steps were reworded):

| Screenshot | Note |
|:--|:--|
| `assets/tmux-config-file-tpm.png` | Should show `run '~/.config/tmux/plugins/tpm/tpm'` as the last line — confirm the pictured path matches. |
| `assets/tmux-reload-tmux-config.png` | Still valid for the `prefix r` → `prefix I` flow. |

***

## 3. Optional / nice-to-have

- **`vim/vim-comment-uncomment.md`** — the new *Method 4* (built-in comment plugin, `gcc`) has no illustration.  Optional: a before/after pair showing `gcc` toggling a comment (any vim ≥ 9.1.0375 or Neovim 0.10+).
- **`vim/vim-comment-uncomment.md`** — the existing before/after images are hosted on S3 (`dojolabs.s3.amazonaws.com`).  Consider mirroring them into `assets/` so the doc has no external image dependency.
- **Vim lab** — the new sections (Undo/Redo & Repeat, clipboard-support warning, text objects, `vimtutor` pointer) are text-only and need no screenshots.

***

## 4. Housekeeping notes (not screenshots, but found while walking the assets)

- `tmux/assets/excalidraw/Unconfirmed 969228.crdownload.excalidraw` looks like a stray partial Chrome download (`.crdownload`).  If it is a real diagram you want to keep, rename it to something meaningful; otherwise it can be deleted.
- `assets/install_zsh.sh` and `assets/install_zsh.sh.orig` were deliberately **left untouched** — they are the vim crash course's practice file (the lab references specific line numbers in them, e.g. `download_fonts` at line 123, `check_for_oh_my_zsh` at line 109), and the `.orig` copy lets you restore the file after doing the lab.  `scripts/install_zsh.sh` (the one people actually run) was refactored.
