# ----------------------------------------------------------------------------
# Auto-Completion
# ----------------------------------------------------------------------------
fpath+="${HOME}/.zfunc"

# ----------------------------------------------------------------------------
# zsh setup
# ----------------------------------------------------------------------------
zstyle ':completion*' auto-description 'Specify: %d'
zstyle ':completion*' completer _complete _ignored _approximate
zstyle ':completion*' expand prefix suffix
zstyle ':completion*' file-sort modification
zstyle ':completion*' format 'Type of Completion: %d'
zstyle ':completion*' ignore-parents parent pwd .. directory
zstyle ':completion*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion*' menu select=0
zstyle ':completion*' preserve-prefix '//[^/]##/'
zstyle ':completion*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion*' verbose true
zstyle :compinstall filename '/home/givon/.zshrc'
autoload -Uz compinit
compinit

HISTFILE=~/.cache/zsh/.hist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -v

# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------

export DOTS="${HOME}/dots/arch-nb"
export REPOS="${HOME}/repos"
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/.cargo/bin"
export EDITOR="nvim"
export MANPAGER="nvim +Man!"

# ----------------------------------------------------------------------------
# Aliases
# ----------------------------------------------------------------------------
# git
alias g="git"
alias ga="git add"
alias gaa="git add --all"
alias gb="git branch"
alias gc="git commit --verbose"
alias gca="git commit --all --verbose"
alias gco="git checkout"
alias gconf="git config"
alias gd="git diff"
alias gf="git fetch"
alias ggr="git grep"
alias gl="git log --graph --decorate --summary --stat"
alias gll="git log --graph --decorate --all --summary --stat"
alias gm="git merge"
alias gpull="git pull"
alias gpush="git push"
alias gshow="git show"
alias gs="git status"
alias gss="git stauts --short"
alias gsw="git switch"

# misc.
alias ......="./../../../../.."
alias .....="./../../../.."
alias ....="./../../.."
alias ...="./../.."
alias ..="./.."
alias c="clear"
alias cp="cp -i"
alias e="exit"
alias l="exa -la --git --time modified --time-style long-iso --group --icons"
alias ll="exa -la --git --time modified --time-style long-iso --group --icons --only-dirs"
alias md="mkdir -p"
alias n="$EDITOR"
alias o="xdg-open"
alias pqi="pacman -Qi"
alias pqs="pacman -Qs"
alias pqo="pacman -Qo"
alias psi="pacman -Si"
alias pss="pacman -Ss"
alias q="exit"
alias sz="source ~/.zshrc"
alias tm="tmux"

# ----------------------------------------------------------------------------
# proc management
# ----------------------------------------------------------------------------

# ssh-agent
SSH_AGENT_DOTENV="${XDG_RUNTIME_DIR}/ssh-agent.env"

if ! pgrep -u "${USER}" ssh-agent > /dev/null; then
    ssh-agent -t 1h > "${SSH_AGENT_DOTENV}"
fi

if [[ ! "${SSH_AUTH_SOCK}" ]]; then
    . "${SSH_AGENT_DOTENV}" > /dev/null
fi

# ----------------------------------------------------------------------------
# misc. software setup
# ----------------------------------------------------------------------------

# fzf
export FZF_DEFAULT_COMMAND="fd . --type file --full-path"

# bat
export BAT_THEME="base16"

# mcfly
export MCFLY_KEY_SCHEME=vim
export MCFLY_FUZZY=true
export MCFLY_HISTORY_LIMIT=10000
export MCFLY_RESULTS=50
eval "$(mcfly init zsh)"

# starship
export STARSHIP_CONFIG="${HOME}/.config/starship/starship.toml"
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"

# zsh-autosuggestions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
