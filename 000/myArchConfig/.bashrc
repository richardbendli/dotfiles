#
# ~/.bashrc
#
#---------------------------------------------------------------

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


PS1='[\u@\h \W]\$ '

### EXPORT
# export HISTCONTROL=ignoredups:erasedups           # no duplicate entries

### SET MANPAGER
### Uncomment only one of these!

### "bat" as manpager
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

### "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\">

### "nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

#HISTORY
#add date and time to history
export HISTTIMEFORMAT="%h %d %H:%M:%S "
#increase bash history size
export HISTSIZE=10000
#increase number of lines contained in history files
export HISTFILESIZE=10000

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control


#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

### ARCHIVE EXTRACTION
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#---------------------------------------------------------------

### ALIASES ###

# root privileges
# alias doas="doas --"

#---------------------------------------------------------------

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# nano
alias na='sudo nano -l'

# vim
alias vim="nvim"

#---------------------------------------------------------------

#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"

# pacman and yay
alias pacsyu='sudo pacman -Syyu'                 # update only standard pkgs
# alias yaysua='yay -Sua --noconfirm'              # update only AUR pkgs (yay)
# alias yaysyu='yay -Syu --noconfirm'              # update standard pkgs and AUR pkgs (yay)
# alias parsua='paru -Sua --noconfirm'             # update only AUR pkgs (paru)
# alias parsyu='paru -Syu --noconfirm'             # update standard pkgs and AUR pkgs (paru)
# alias unlock='sudo rm /var/lib/pacman/db.lck'    # remove pacman lock
# alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  # remove orphaned packages

#---------------------------------------------------------------

#update archlinux-keyring
alias keyr="sudo pacman -Syu archlinux-keyring"

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

#---------------------------------------------------------------

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#---------------------------------------------------------------

# adding flags
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias lynx='lynx -cfg=~/.lynx/lynx.cfg -lss=~/.lynx/lynx.lss -vikeys'
alias vifm='./.config/vifm/scripts/vifmrun'
alias ncmpcpp='ncmpcpp ncmpcpp_directory=$HOME/.config/ncmpcpp/'
alias mocp='mocp -M "$XDG_CONFIG_HOME"/moc -O MOCDir="$XDG_CONFIG_HOME"/moc'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4 | head -5'
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

#hardware info --short
alias hw="hwinfo --short"

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#userlist
alias userlist="cut -d: -f1 /etc/passwd"

#which graphical card is working
alias whichvga="/usr/local/bin/arcolinux-which-vga"

#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

#give the list of all installed desktops - xsessions desktops
alias xd="ls /usr/share/xsessions"

#---------------------------------------------------------------

# Merge Xresources
# alias merge='xrdb -merge ~/.Xresources'

# get error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# gpg encryption
# verify signature for isos
# alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
# alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"


#---------------------------------------------------------------

# youtube-dl
alias yta-aac="youtube-dl --extract-audio --audio-format aac "
alias yta-best="youtube-dl --extract-audio --audio-format best "
alias yta-flac="youtube-dl --extract-audio --audio-format flac "
alias yta-m4a="youtube-dl --extract-audio --audio-format m4a "
alias yta-mp3="youtube-dl --extract-audio --audio-format mp3 "
alias yta-opus="youtube-dl --extract-audio --audio-format opus "
alias yta-vorbis="youtube-dl --extract-audio --audio-format vorbis "
alias yta-wav="youtube-dl --extract-audio --audio-format wav "
alias ytv-best="youtube-dl -f bestvideo+bestaudio "

#off and reboot
alias shut="shutdown now"
alias reb="reboot"

#file manager
alias rang="ranger"

#---------------------------------------------------------------

#remove
#alias rmgitcache="rm -r ~/.cache/git"

#---------------------------------------------------------------

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
# alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

#---------------------------------------------------------------

# bare git repo alias for dotfiles
# alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

# termbin
# alias tb="nc termbin.com 9999"

# the terminal rickroll
# alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Unlock LBRY tips
# alias tips='lbrynet txo spend --type=support --is_not_my_input --blocking'

#---------------------------------------------------------------

#tools

#neofetch
#screenfetch
#alsi
#paleofetch
#fetch
#hfetch
#sfetch
#ufetch
#ufetch-arco
#pfetch
#sysinfo
#sysinfo-retro
#cpufetch
#colorscript random

#---------------------------------------------------------------




