#!/usr/bin/env bash
# Symlink the configs in this repo into place.
# Existing files are moved aside to <path>.pre-dotfiles before linking.
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"

link() {
    local src="$DOTFILES/$1" dest="$2"

    if [ -L "$dest" ]; then
        # Already a symlink. Ours -> nothing to do; someone else's -> replace it.
        [ "$(readlink -f "$dest")" = "$src" ] && { echo "ok      $dest"; return; }
        rm "$dest"
    elif [ -e "$dest" ]; then
        mv "$dest" "$dest.pre-dotfiles"
        echo "backup  $dest -> $dest.pre-dotfiles"
    fi

    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo "link    $dest -> $src"
}

link kitty      "$CONFIG/kitty"
link bash/bashrc "$HOME/.bashrc"

echo
echo "Done. Restart kitty (or ctrl+shift+f5 to reload config) and run: source ~/.bashrc"
