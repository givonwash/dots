################################################################################
# Givon's .zshrc
# NOTE: .zshrc is meant to be as vanilla as possible so as to be usable across
#       machines before being forked
################################################################################

# Zsh Completions
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

# Zsh Options
HISTFILE=~/.cache/zsh/.hist
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep extendedglob nomatch notify
bindkey -v

# Environment Variables
export DOTFILES="${HOME}/DotFiles"
export PATH="${PATH}:${HOME}/.local/bin"

# Machine Dependent Environment Variables
if ! nvim_loc="$(whence -p nvim)" || [[ -x $nvim_loc ]]; then
    export EDITOR="nvim"
    export MANPAGER="nvim +Man!"
else
    export EDITOR="vim"
fi

# Aliases
# -- General
alias ..="./.."
alias ...="./../.."
alias ....="./../../.."
alias .....="./../../../.."
alias ......="./../../../../.."
alias c="clear"
alias cp="cp -i"
alias e="exit"
alias l="ls -lah"
alias md="mkdir -p"
alias n="$EDITOR"
alias nn="n ${DOTFILES}/nvim/init.vim"
alias na="n ${DOTFILES}/alacritty/alacritty.yml"
alias nb="n ${DOTFILES}/bash/.bashrc"
alias nz="n ${DOTFILES}/zsh/.zshrc"
alias sb="source ~/.bashrc"
alias sz="source ~/.zshrc"

# -- Git Related
alias g="git"
alias ga="g add"
alias gb="g branch"
alias gaa="g add --all"
alias gc="g commit --verbose"
alias gca="g commit --all --verbose"
alias gco="g checkout"
alias gconf="g config"
alias gd="g diff"
alias gf="g fetch"
alias gl="g log --graph --decorate --all"
alias gm="g merge"
alias gpush="g push"
alias gpull="g pull"
alias gs="g status"
alias gss="g stauts --short"
