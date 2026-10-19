# frondier — zsh configuration (template)
# Personal/sensitive values (API keys, machine-specific paths, private aliases)
# belong in ~/.zshrc.local (NOT tracked by git) — sourced at the end of this file.

# ========================
# >> Environment Setup
# ========================

export EDITOR="nvim"
export MANPAGER="$EDITOR +Man!"

# PATH (generic dev locations)
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.cargo/bin:$HOME/.bun/bin:$PATH"

# Cargo env
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

# ========================
# >> Plugins
# ========================
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh

# ========================
# >> Tools Init
# ========================
[ -x "$(command -v starship)" ] && eval "$(starship init zsh)"
[ -x "$(command -v zoxide)" ]  && eval "$(zoxide init zsh)"
[ -x "$(command -v fzf)" ]     && eval "$(fzf --zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# ========================
# >> History
# ========================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTDUPE=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# ========================
# >> Completion
# ========================
zstyle ':completion:*' file-sort date
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:paths' path-completion yes
zstyle ':completion:*:processes' command 'ps -afu $USER'
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' insert-unambiguous yes

# Freetype font rendering tweaks
export FREETYPE_PROPERTIES="truetype:interpreter-version=35 autofitter:no-stem-darkening=0 cff:no-stem-darkening=0"

export FZF_DEFAULT_OPTS='
--color=spinner:2,hl:6
--color=fg:7,header:3,info:4,pointer:4
--color=marker:2,fg+:7,prompt:6,hl+:6
'

# ========================
# >> Aliases
# ========================
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias v='nvim'
alias lf='yazi'
alias pdf='soffice --headless --convert-to pdf'

# ========================
# >> Other
# ========================
export LIBVIRT_DEFAULT_URI="qemu:///system"

# fastfetch on interactive shell open (comment out if unwanted)
fastfetch

# nvm (guarded — only loads when present)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ========================
# >> Personal layer (gitignored)
# API keys, machine-specific PATHs, private aliases go in ~/.zshrc.local
# ========================
[ -f "$HOME/.zshrc.local" ] && source "$HOME/.zshrc.local"
