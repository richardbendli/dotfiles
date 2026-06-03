# ============================================================
#  exports.zsh
# ============================================================

# XDG
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

# Dirs that must exist
mkdir -p \
  "$HOME/.cache/zsh" \
  "$HOME/.local/state/zsh" \
  "$HOME/.local/state/less" \
  "$HOME/.config/zsh/plugins"

# Editor
export EDITOR="${EDITOR:-nvim}"
export VISUAL="${VISUAL:-nvim}"
export PAGER="less"
export LESS="-R --mouse --wheel-lines=3"

# PATH
typeset -U path PATH
path=(
  "$HOME/.local/bin"
  "$HOME/bin"
  "/usr/local/bin"
  "/usr/bin"
  "/bin"
  "/usr/local/sbin"
  "/usr/sbin"
  "/sbin"
  $path
)
export PATH

# fpath
typeset -U fpath
fpath=(
  "$ZDOTDIR/plugins/zsh-completions/src"
  $fpath
)

# Locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Terminal
export COLORTERM="truecolor"

# History
export HISTFILE="$ZDOTDIR/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# FZF
export FZF_DEFAULT_OPTS="
  --height=40%
  --layout=reverse
  --border=rounded
  --info=inline
  --prompt='❯ '
  --pointer='▶'
  --marker='✓'
  --color=dark
  --color=fg:-1,bg:-1,hl:#5f87af
  --color=fg+:#d0d0d0,bg+:#262626,hl+:#5fd7ff
  --color=info:#afaf87,prompt:#d7005f,pointer:#af5fff
  --color=marker:#87ff00,spinner:#af5fff,header:#87afaf
"
export FZF_DEFAULT_COMMAND="find . -type f -not -path '*/.git/*' 2>/dev/null"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="find . -type d -not -path '*/.git/*' 2>/dev/null"

# Zoxide
export _ZO_DATA_DIR="$HOME/.local/share/zoxide"
export _ZO_ECHO=1
