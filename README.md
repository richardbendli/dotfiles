## Dotfiles

This repository contains the tools and configurations I use across my systems.

---

## Zsh Config

A modular, plugin-manager-free zsh configuration.
Tested on **Ubuntu**, **Pop OS**, and **Fedora**.

## Features

- No plugin manager — plugins are cloned directly with git
- Modular structure — every concern in its own file
- Comment one line to disable any plugin
- Standard keybindings
- fzf-powered tab completion, history search, and directory jumping
- zoxide for smart directory jumping
- Multiple prompt styles — switch by editing one line
- tmux integration
- Single history file shared across all sessions
- Target startup time under 100ms

---

## Requirements

### Install zsh

```bash
sudo apt update
sudo apt install zsh

# Set zsh as your default shell
chsh -s $(which zsh)

# Log out and back in, then verify
echo $SHELL
```

### Install required tools

```bash
# Required
sudo apt install git wget curl tmux fzf zoxide eza bat xclip
```

### Install a Nerd Font

```bash
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.x.x/fonts.zip
unzip fonts.zip -d ~/.local/share/fonts/your_fonts or ~/.fonts

fc-cache -fv
```

Then set the font in your terminal settings.

---

## File Structure

```
~/.zshenv                               # sets ZDOTDIR — must live here
~/.zshrc                                # fallback source pointer
~/.config/zsh/
├── .zshrc                              # main entry point, sources all modules
├── .zsh_history                        # extended history entries
├── exports.zsh                         # PATH, env vars, XDG, fzf, zoxide config
├── options.zsh                         # setopt flags
├── history.zsh                         # single history file, shared across sessions
├── completions.zsh                     # completion system + zstyle config
├── keybindings.zsh                     # keybindings
├── plugins.zsh                         # all plugins — comment a line to disable
├── aliases.zsh                         # aliases for dev + sysadmin
├── functions.zsh                       # shell functions
├── tmux.zsh                            # tmux integration
├── prompt.zsh                          # prompt styles
├── install-plugins.sh                  # clone all plugins in one shot
└── plugins/                            # cloned by install-plugins.sh — not tracked
    ├── zsh-syntax-highlighting/
    ├── fast-syntax-highlighting/
    ├── zsh-autosuggestions/
    ├── zsh-history-substring-search/
    ├── zsh-completions/
    ├── zsh-autopair/
    ├── fzf-tab/
    ├── forgit/
    └── zsh-you-should-use/
```

---

## Installation

### 1. Clone the repo

```bash
git clone https://github.com/richardbendli/dotfiles.git ~/dotfiles
```

### 2. Copy files into place

```bash
mkdir -p ~/.config/zsh/plugins

# The two root files
cp ~/dotfiles/.zshenv ~/.zshenv
cp ~/dotfiles/.zshrc ~/.zshrc

# All config files
cp ~/dotfiles/.config/zsh/*.zsh ~/.config/zsh/
cp ~/dotfiles/.config/zsh/*.sh ~/.config/zsh/
```

### 3. Install plugins

```bash
chmod +x ~/.config/zsh/install-plugins.sh
~/.config/zsh/install-plugins.sh
```

### 4. Reload

```bash
rm -f ~/.cache/zsh/zcompdump*
exec zsh
```

---

## The Two Root Files

These two files must live in your home directory. They are just pointers —
all real config lives in `~/.config/zsh/`.

**`~/.zshenv`** — tells zsh where to find your config. Must be here, read before everything else:
```bash
export ZDOTDIR="$HOME/.config/zsh"
```

**`~/.zshrc`** — fallback in case ZDOTDIR is not set:
```bash
[[ -f "$HOME/.config/zsh/.zshrc" ]] && source "$HOME/.config/zsh/.zshrc"
```

---

## Enabling and Disabling Plugins

Every plugin in `plugins.zsh` is controlled by a single line.

**Disable:**
```bash
# _plug zsh-autosuggestions
```

**Enable:**
```bash
_plug zsh-autosuggestions
```

Then reload:
```bash
exec zsh
```

---

## Updating Plugins

Use alias in `aliases.zsh`:
```bash
alias zsh-update-plugins='for d in ~/.config/zsh/plugins/*/; do echo "updating ${d##*/}..."; git -C "$d" pull --ff-only --quiet && echo "✓" || echo "✗ failed"; done'
```

---
