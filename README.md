# dotfiles

Config for a Ubuntu + GNOME/Wayland box. Symlinked into place, so editing the
live file edits the repo.

## Install

```sh
git clone https://github.com/verd1c/dotfiles ~/src/dotfiles
~/src/dotfiles/install.sh
```

Anything already at a target path is moved to `<path>.pre-dotfiles` first, so
running this on a machine with existing configs is non-destructive.

## What's here

| Path      | Links to         | Notes |
|-----------|------------------|-------|
| `kitty/`  | `~/.config/kitty` | Terminal config + colour theme |
| `bash/bashrc` | `~/.bashrc`  | Stock Ubuntu bashrc plus `~/.local/bin` on PATH |

## kitty

`kitty.conf` is tuned for a 2560x1600 165Hz panel: `repaint_delay 6` to match
the refresh rate, `input_delay 0`, and `sync_to_monitor`. Scrollback is 100k
lines for long disassembly dumps.

The theme is **Ayu**, kept in `current-theme.conf` and pulled in by the
`include` at the bottom of `kitty.conf`. That file is what `kitten themes`
writes, so it round-trips: pick a new theme with

```sh
kitten themes
```

and the change lands in this repo as a diff to `current-theme.conf` — commit it
and every machine follows. Don't hand-edit the `BEGIN_KITTY_THEME` block in
`kitty.conf`; `kitten themes` rewrites it.

Fonts are not in here (they're binaries). This config wants
[JetBrainsMono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip):

```sh
mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
unzip -o JetBrainsMono.zip && rm JetBrainsMono.zip && fc-cache -f
```

### Keys worth remembering

| Binding | Does |
|---------|------|
| `ctrl+shift+enter` | vsplit in cwd |
| `ctrl+shift+d` | hsplit in cwd |
| `ctrl+shift+p` `h` | hint-grab a hex address off the screen |
| `ctrl+shift+p` `f` | hint-grab a file path |
| `ctrl+shift+p` `s` | hint-grab an md5/sha1/sha256 |

`ctrl+shift+d` rather than the obvious `ctrl+shift+minus` on purpose: kitty
*appends* to its keymap instead of replacing, so rebinding `minus` silently
kills the built-in decrease-font-size.

## Not tracked here

Secrets. `~/.ssh/id_*`, `~/.config/gh/hosts.yml` (holds a live OAuth token) and
`~/.claude.json` stay off this repo — `.gitignore` blocks the usual shapes, but
it is not a substitute for looking before committing.
