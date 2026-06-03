#!/usr/bin/env bash
# Run once to clone all plugins
set -euo pipefail

PLUGIN_DIR="${HOME}/.config/zsh/plugins"
mkdir -p "$PLUGIN_DIR"

_clone() {
  local name="$1" url="$2" dest="$PLUGIN_DIR/$1"
  if [[ -d "$dest/.git" ]]; then
    echo "✓ $name — pulling"
    git -C "$dest" pull --ff-only --quiet
  else
    echo "⟳ cloning $name..."
    git clone --depth=1 "$url" "$dest"
  fi
}

_clone zsh-syntax-highlighting   https://github.com/zsh-users/zsh-syntax-highlighting
_clone fast-syntax-highlighting  https://github.com/zdharma-continuum/fast-syntax-highlighting
_clone zsh-autosuggestions       https://github.com/zsh-users/zsh-autosuggestions
_clone zsh-history-substring-search https://github.com/zsh-users/zsh-history-substring-search
_clone zsh-completions           https://github.com/zsh-users/zsh-completions
_clone zsh-autopair              https://github.com/hlissner/zsh-autopair
_clone fzf-tab                   https://github.com/Aloxaf/fzf-tab
_clone forgit                    https://github.com/wfxr/forgit
_clone zsh-you-should-use        https://github.com/MichaelAquilina/zsh-you-should-use

echo ""
echo "✓ all plugins installed"
echo "  now run: rm -f ~/.cache/zsh/zcompdump* && exec zsh"
