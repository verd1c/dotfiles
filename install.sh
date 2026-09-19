#!/usr/bin/env bash
# Symlink the configs in this repo into place and fetch what they depend on.
# Existing files are moved aside to <path>.pre-dotfiles before linking.
# Safe to re-run: everything here is idempotent.
#
# Fonts are not in this repo (binaries). kitty.conf wants JetBrainsMono Nerd
# Font; if glyphs look wrong, install it with:
#   mkdir -p ~/.local/share/fonts && cd ~/.local/share/fonts \
#     && curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
#     && unzip -o JetBrainsMono.zip && rm JetBrainsMono.zip && fc-cache -f
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}"
ZSH_DIR="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH_DIR/custom"

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

# Clone at depth 1: these are upstream repos we track, not fork.
clone() {
    local url="$1" dest="$2"
    if [ -d "$dest" ]; then
        echo "ok      $dest"
    else
        echo "clone   $dest"
        git clone -q --depth=1 "$url" "$dest"
    fi
}

# oh-my-zsh, installed by hand rather than via its curl|sh installer, because
# that installer overwrites ~/.zshrc and would clobber the symlink below.
clone https://github.com/ohmyzsh/ohmyzsh.git "$ZSH_DIR"
clone https://github.com/zsh-users/zsh-autosuggestions.git \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

link kitty        "$CONFIG/kitty"
link zsh/zshrc    "$HOME/.zshrc"
link git/gitconfig "$HOME/.gitconfig"

# One working agreement, read by every agent. Each tool looks for its own
# filename, so the same file is linked under each of them.
link ai/AGENTS.md "$HOME/.claude/CLAUDE.md"   # Claude Code global memory
link ai/AGENTS.md "$HOME/.codex/AGENTS.md"    # Codex global instructions
link ai/AGENTS.md "$HOME/.omp/AGENTS.md"      # omp
link ai/AGENTS.md "$HOME/.omp/rules/shared.md"

echo
echo "Done. Restart kitty (or ctrl+shift+f5 to reload its config)."
command -v zsh >/dev/null || echo "NOTE: zsh isn't installed yet: sudo apt install zsh"
