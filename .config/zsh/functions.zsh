# ============================================================
#  functions.zsh
# ============================================================

mkcd()   { mkdir -p "$1" && cd "$1" }

up() {
  local d="" n="${1:-1}"
  for ((i=0;i<n;i++)); do d="../$d"; done
  cd "$d" || return 1
}

extract() {
  [[ ! -f "$1" ]] && { echo "not a file: $1" >&2; return 1; }
  case "$1" in
    *.tar.bz2) tar xjf "$1"  ;;
    *.tar.gz)  tar xzf "$1"  ;;
    *.tar.xz)  tar xJf "$1"  ;;
    *.bz2)     bunzip2 "$1"  ;;
    *.gz)      gunzip "$1"   ;;
    *.tar)     tar xf "$1"   ;;
    *.zip)     unzip "$1"    ;;
    *.7z)      7z x "$1"     ;;
    *.xz)      unxz "$1"     ;;
    *.rar)     unrar x "$1"  ;;
    *)         echo "unknown format: $1" >&2; return 1 ;;
  esac
}

fcd() {
  local dir
  dir=$(find "${1:-.}" -type d -not -path '*/.git/*' 2>/dev/null | \
    fzf --preview 'ls --color=always {}' \
        --preview-window=right:50%:wrap \
        --prompt='cd ❯ ') && cd "$dir"
}

fkill() {
  local pid
  pid=$(ps -u "$USER" -o pid,comm,%cpu,%mem --no-headers | \
    fzf --multi --prompt='kill ❯ ' | awk '{print $1}')
  [[ -n "$pid" ]] && kill -${1:-9} $pid
}

fman() {
  man -k . 2>/dev/null | fzf \
    --prompt='man ❯ ' \
    --preview 'echo {} | awk "{print \$1}" | xargs man 2>/dev/null | head -80' \
    --preview-window=right:60%:wrap | \
    awk '{print $1}' | xargs man
}

gch() {
  local branch
  branch=$(git branch --all --sort=-committerdate 2>/dev/null | \
    grep -v HEAD | \
    fzf --prompt='branch ❯ ' \
        --preview 'git log --oneline --color=always $(echo {} | sed "s/remotes\/origin\///")' | \
    sed 's/^[[:space:]]*//' | sed 's|remotes/origin/||')
  [[ -n "$branch" ]] && git checkout "$branch"
}

portcheck() {
  local host="${1:-localhost}" port="$2"
  [[ -z "$port" ]] && { echo "Usage: portcheck <host> <port>" >&2; return 1; }
  if timeout 3 bash -c ">/dev/tcp/$host/$port" 2>/dev/null; then
    echo "✓ $host:$port is open"
  else
    echo "✗ $host:$port is closed"
  fi
}

sysinfo() {
  echo "── System ────────────────────────────────"
  echo "  OS:     $(grep PRETTY_NAME /etc/os-release | cut -d'"' -f2)"
  echo "  Kernel: $(uname -r)"
  echo "  Uptime: $(uptime -p)"
  echo "── Resources ─────────────────────────────"
  echo "  CPU:    $(nproc) cores"
  echo "  RAM:    $(free -h | awk '/Mem/{printf "%s used / %s total",$3,$2}')"
  echo "  Disk:   $(df -h / | awk 'NR==2{printf "%s used / %s total",$3,$2}')"
  echo "── Network ───────────────────────────────"
  echo "  IP:     $(ip route get 1 2>/dev/null | awk '{print $NF; exit}')"
  echo "──────────────────────────────────────────"
}

zsh_benchmark() {
  local n="${1:-5}"
  for i in $(seq 1 $n); do
    { time zsh -i -c exit } 2>&1 | grep real
  done
}
