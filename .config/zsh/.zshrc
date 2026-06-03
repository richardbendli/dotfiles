# ============================================================
#  ~/.config/zsh/.zshrc — main entry point
# ============================================================

[[ $- != *i* ]] && return

_src() { [[ -f "$1" ]] && source "$1" }

_src "$ZDOTDIR/exports.zsh"
_src "$ZDOTDIR/options.zsh"
_src "$ZDOTDIR/history.zsh"
_src "$ZDOTDIR/completions.zsh"
_src "$ZDOTDIR/keybindings.zsh"
_src "$ZDOTDIR/plugins.zsh"
_src "$ZDOTDIR/aliases.zsh"
_src "$ZDOTDIR/functions.zsh"
_src "$ZDOTDIR/tmux.zsh"
_src "$ZDOTDIR/prompt.zsh"

unfunction _src
