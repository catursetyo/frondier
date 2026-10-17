# ========================
# >> Environment Setup
# ========================

export EDITOR="nvim"
export MANPAGER="$EDITOR +Man!"

# Unified PATH setup
export PATH="$HOME/bin:/usr/local/bin:/home/hypr/.local/bin:/home/hypr/.cargo/bin:$HOME/.bun/bin:/home/hypr/.spicetify:$PATH"

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
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# tdl completion

# ========================
# >> Appearance / Theme
# ========================
# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
HISTDUPE=erase

# zsh options
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Freetype font rendering tweaks
export FREETYPE_PROPERTIES="truetype:interpreter-version=35 autofitter:no-stem-darkening=0 cff:no-stem-darkining=0"

zstyle ':completion:*' file-sort date
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:paths' path-completion yes
zstyle ':completion:*:processes' command 'ps -afu $USER'
zstyle ':autocomplete:*' min-input 1
zstyle ':autocomplete:*' insert-unambiguous yes

# ========================
# >> Aliases
# ========================
alias ls='eza --icons --color=always --group-directories-first'
alias v="nvim"
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias lf='yazi'
alias pdf='soffice --headless --convert-to pdf'
alias discord='Discord --disable-gpu'
alias android='/opt/android-studio/bin/studio.sh'
alias gns3='source ~/.venvs/gns3/bin/activate && gns3'

# ========================
# >> Other Exports
# ========================
export LIBVIRT_DEFAULT_URI="qemu:///system"

# ========================
# >> Optional / Commented Tools
# ========================
# ========================
export FZF_DEFAULT_OPTS='
--color=spinner:2,hl:6
--color=fg:7,header:3,info:4,pointer:4
--color=marker:2,fg+:7,prompt:6,hl+:6
'

# ========================
fastfetch

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/home/caur/.spicetify
eval "$(starship init zsh)"

# opencode
export PATH=/home/caur/.opencode/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"


# Added by Antigravity CLI installer
export PATH="/home/caur/.local/bin:$PATH"

# pnpm
export PNPM_HOME="/home/caur/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/caur/google-cloud-sdk/path.zsh.inc' ]; then . '/home/caur/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/caur/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/caur/google-cloud-sdk/completion.zsh.inc'; fi

export DASHSCOPE_API_KEY="sk-ws-H.DMMDYHY.0CUB.MEUCIA2mWwWlItpItTq6uJZkjU16ArdOOi7kH3F-pSX7w_iyAiEAwQ3pmkxjqFlPKG0diuIRleuRCnp_pBMrbMuRUXCFAkM"
export BLUESMINDS_API_KEY="sk-isWYIyF3e204UQQx3Bt7OgNe0w3NA4PcjNmQBryTJytvVuYK"
#export ANTHROPIC_API_KEY="sk-MkMgP7dOhnGDCv8EgdTa6TkaVmNom3sMA09P5hHSUd5COCjO"
export ANTHROPIC_API_KEY="aero_live_v-rhh5yWxpQ3vYA4TlCzaml7034TUlIKvrodCvH3enQ"
#xport ANTHROPIC_BASE_URL="https://api.justwoker.icu"
#export ANTHROPIC_MODEL="claude-opus-4-8"
export ANTHROPIC_BASE_URL="https://capi.aerolink.lat/"

# Added by flyctl installer
export FLYCTL_INSTALL="/home/caur/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
