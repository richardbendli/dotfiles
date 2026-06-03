# ============================================================
#  completions.zsh
# ============================================================

# MUST be before compinit
zmodload zsh/complist

# compinit with 24h cache
autoload -Uz compinit

_zcd="$HOME/.cache/zsh/zcompdump"

# Check if dump is less than 24h old — if so skip full init
if [[ -f "$_zcd" && $(( $(date +%s) - $(stat -c %Y "$_zcd" 2>/dev/null || echo 0) )) -lt 86400 ]]; then
  compinit -C -d "$_zcd"
else
  compinit -d "$_zcd"
fi
unset _zcd

# Styling
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}── %d ──%f'
zstyle ':completion:*:messages'     format '%F{purple}%d%f'
zstyle ':completion:*:warnings'     format '%F{red}No matches: %d%f'
zstyle ':completion:*:corrections'  format '%F{green}%d (errors: %e)%f'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list \
  '' \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/completion-cache"
zstyle ':completion:*' verbose yes
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Kill
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

# fzf-tab (parsed after fzf-tab loads)
zstyle ':fzf-tab:complete:cd:*'         fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=always $realpath'
zstyle ':fzf-tab:*'                     switch-group ',' '.'
zstyle ':fzf-tab:*'                     fzf-flags '--height=50%' '--border=rounded'
