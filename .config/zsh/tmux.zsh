# ============================================================
#  tmux.zsh
# ============================================================

if [[ -n "$TMUX" ]]; then
  export TERM="tmux-256color"
else
  export TERM="${TERM:-xterm-256color}"
fi

# Window title
_set_title() {
  local t="${PWD/#$HOME/~}"
  if [[ -n "$TMUX" ]]; then
    printf '\033]2;%s\033\\' "$t"
  else
    printf '\033]0;%s\033\\' "$t"
  fi
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _set_title

# ── Auto-start (disabled — uncomment one option to enable) ───

# OPTION A: attach to existing session or create 'main'
# if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
#   tmux attach 2>/dev/null || tmux new-session -s main
# fi

# OPTION B: always create new session
# if command -v tmux &>/dev/null && [[ -z "$TMUX" ]]; then
#   tmux new-session -s "$(date +%H%M)"
# fi

# Helper functions
tns() {
  local name="${1:-main}"
  tmux has-session -t "$name" 2>/dev/null \
    && tmux attach -t "$name" \
    || tmux new-session -s "$name"
}

tss() {
  local s
  s=$(tmux list-sessions -F '#S' 2>/dev/null | fzf --prompt='session ❯ ')
  [[ -n "$s" ]] && tmux switch-client -t "$s"
}

tsw() {
  [[ -z "$TMUX" ]] && { echo "not in tmux" >&2; return 1; }
  local w
  w=$(tmux list-windows -F '#I: #W' | fzf --prompt='window ❯ ' | cut -d: -f1)
  [[ -n "$w" ]] && tmux select-window -t "$w"
}
