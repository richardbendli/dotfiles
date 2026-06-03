# ============================================================

# █████╗ ██╗     ██╗ █████╗ ███████╗███████╗███████╗
#██╔══██╗██║     ██║██╔══██╗██╔════╝██╔════╝██╔════╝
#███████║██║     ██║███████║███████╗█████╗  ███████╗
#██╔══██║██║     ██║██╔══██║╚════██║██╔══╝  ╚════██║
#██║  ██║███████╗██║██║  ██║███████║███████╗███████║
#╚═╝  ╚═╝╚══════╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝

# ============================================================

# Copy, Move, Remove, Make
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'
alias mkdir='mkdir -pv'

# Listing
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --git --group-directories-first'
  alias lt='eza --tree --icons --level=2 --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
  alias l='eza -1 --icons'
else
  alias ls='ls --color=auto --group-directories-first'
  alias ll='ls -lahF'
  alias la='ls -A'
  alias l='ls -1'
fi

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias d='dirs -v'
for index ({1..9}) alias "$index"="cd +${index}"; unset index

# Config shortcuts
alias zshrc='$EDITOR $ZDOTDIR/.zshrc'
alias zshal='$EDITOR $ZDOTDIR/aliases.zsh'
alias zshplug='$EDITOR $ZDOTDIR/plugins.zsh'
alias zshexp='$EDITOR $ZDOTDIR/exports.zsh'
alias zshprompt='$EDITOR $ZDOTDIR/prompt.zsh'
alias reload='exec zsh && echo "✓ reloaded"'

# Editor
alias v='$EDITOR'
alias vi='$EDITOR'
alias vim='$EDITOR'

# Git
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gca='git commit --amend --no-edit'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --decorate --graph --all'
alias grb='git rebase'
alias grbi='git rebase -i'
alias gst='git stash'
alias gstp='git stash pop'
alias gbr='git branch'

# System
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i'
alias df='df -hT'
alias du='du -sh'
alias free='free -mh'

# Network
alias ip='ip a'
alias ports='ss -tulnp'
alias ping='ping -c 5'
alias myip='curl -s ifconfig.me && echo'

# Apt
alias apti='sudo apt install'
alias aptr='sudo apt remove'
alias aptu='sudo apt update && sudo apt upgrade'
alias apts='apt search'

# Update plugins
alias zsh-update-plugins='for d in ~/.config/zsh/plugins/*/; do echo "updating ${d##*/}..."; git -C "$d" pull --ff-only --quiet && echo "✓ done" || echo "✗ failed"; done'

# Systemd
alias sc='sudo systemctl'
alias scstart='sudo systemctl start'
alias scstop='sudo systemctl stop'
alias screstart='sudo systemctl restart'
alias scstatus='systemctl status'
alias scenable='sudo systemctl enable'
alias scdisable='sudo systemctl disable'
alias sclog='journalctl -fu'

# Files
alias grep='grep --color=auto'
alias diff='diff --color=auto'

# tmux
alias t='tmux'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias tl='tmux ls'
alias tk='tmux kill-session -t'

# Clipboard
if command -v xclip &>/dev/null; then
  alias pbcopy='xclip -selection clipboard'
  alias pbpaste='xclip -selection clipboard -o'
fi

# Misc
alias c='clear'
alias q='exit'
alias path='echo -e ${PATH//:/\\n}'
alias now='date +"%Y-%m-%d %H:%M:%S"'
alias py='python3'
alias serve='python3 -m http.server'
alias wrt='curl wttr.in'
alias chx='chmod +x'

# Seedtest # install speedtest-cli
alias st="speedtest-cli --secure"

# Cheat sheet commands
alias cheatsh="curl https://cheat.sh/"

# chmod
#alias mx='chmod a+x'
alias ux='chmod u+x'
alias 000='chmod -R 000'
alias 644='chmod -R 644'
alias 666='chmod -R 666'
alias 755='chmod -R 755'
#alias 777='chmod -R 777'

# Userlist
alias userlist="cut -d: -f1 /etc/passwd"

# safe and forced reboots
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'
