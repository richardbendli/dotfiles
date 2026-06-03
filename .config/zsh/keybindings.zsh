# ============================================================
#  keybindings.zsh — vi mode
# ============================================================

#bindkey -v
#export KEYTIMEOUT=1

# Fix keys broken by vi mode
bindkey '^?'  backward-delete-char
bindkey '^h'  backward-delete-char
bindkey '^w'  backward-kill-word
bindkey '^u'  backward-kill-line

# Navigation
bindkey '^a'  beginning-of-line
bindkey '^e'  end-of-line
bindkey '^k'  kill-line
bindkey '^p'  up-line-or-history
bindkey '^n'  down-line-or-history

# Word movement
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

# History search (overridden by substring-search plugin)
bindkey '^[[A' up-line-or-history
bindkey '^[[B' down-line-or-history

# Menuselect (vi keys in completion menu)
#bindkey -M menuselect 'h' vi-backward-char
#bindkey -M menuselect 'k' vi-up-line-or-history
#bindkey -M menuselect 'l' vi-forward-char
#bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^M'   .accept-line

# Vi normal mode
#bindkey -M vicmd 'H' beginning-of-line
#bindkey -M vicmd 'L' end-of-line

# Edit in $EDITOR
#autoload -Uz edit-command-line
#zle -N edit-command-line
#bindkey -M vicmd 'v' edit-command-line

# Cursor shape — beam in insert, block in normal
#_zle_vi_cursor() {
#  case $KEYMAP in
#    vicmd)      print -n '\e[1 q' ;;
#    viins|main) print -n '\e[5 q' ;;
#  esac
#}
#zle -N zle-keymap-select _zle_vi_cursor
#zle -N zle-line-init     _zle_vi_cursor
#_zle_line_finish() { print -n '\e[5 q' }
#zle -N zle-line-finish _zle_line_finish