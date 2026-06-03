# ============================================================
#  plugins.zsh — manual loading, no plugin manager
#
#  Comment any _plug line to disable that plugin.
#  All plugins live in ~/.config/zsh/plugins/
# ============================================================

ZPLUGINDIR="$ZDOTDIR/plugins"

_plug() {
  local name="$1" file="${2:-}"
  local dir="$ZPLUGINDIR/$name"

  if [[ ! -d "$dir" ]]; then
    echo "zsh: plugin '$name' not found — run install-plugins.sh" >&2
    return 1
  fi

  # Try supplied filename first, then common patterns
  local try
  for try in \
    "$dir/$file" \
    "$dir/$name.plugin.zsh" \
    "$dir/$name.zsh" \
    "$dir/init.zsh"
  do
    if [[ -n "$try" && -f "$try" ]]; then
      source "$try"
      return 0
    fi
  done

  echo "zsh: plugin '$name' — no loadable file found in $dir" >&2
  return 1
}

# ============================================================
#  SYNTAX HIGHLIGHTING — pick ONE, comment the other
# ============================================================

# _plug fast-syntax-highlighting
_plug zsh-syntax-highlighting

# ============================================================
#  HISTORY SUBSTRING SEARCH — load AFTER syntax highlighting
# ============================================================

_plug zsh-history-substring-search

#bindkey '^[[A' history-substring-search-up
#bindkey '^[[B' history-substring-search-down
#bindkey -M vicmd 'k' history-substring-search-up
#bindkey -M vicmd 'j' history-substring-search-down

HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=green,bold"
HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red,bold"
HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS="i"

# ============================================================
#  AUTOPAIR
# ============================================================

_plug zsh-autopair autopair.zsh

# ============================================================
#  FZF — key bindings and ** completion
# ============================================================

if [[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi
if [[ -f /usr/share/doc/fzf/examples/completion.zsh ]]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# ============================================================
#  FZF-TAB — must load after compinit and fzf
# ============================================================

_plug fzf-tab fzf-tab.plugin.zsh

# ============================================================
#  AUTOSUGGESTIONS — must load AFTER fzf-tab
# ============================================================

_plug zsh-autosuggestions

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#6c6c6c,underline"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1

bindkey '^ ' autosuggest-accept
bindkey '^]' autosuggest-accept-word

# ============================================================
#  ZOXIDE
# ============================================================

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# ============================================================
#  FORGIT — interactive git with fzf (optional)
# ============================================================

# _plug forgit forgit.plugin.zsh

# ============================================================
#  YOU-SHOULD-USE (optional)
# ============================================================

# _plug zsh-you-should-use you-should-use.plugin.zsh

# ============================================================
#  ATUIN — history sync (optional, install separately)
# ============================================================

# if command -v atuin &>/dev/null; then
#   eval "$(atuin init zsh --disable-up-arrow)"
# fi

unfunction _plug